# encoding: utf-8

# Copyright (c) 2015, Tomas Korcak <korczis@gmail.com>
#
# Permission is hereby granted, free of charge, to any person obtaining a copy
# of this software and associated documentation files (the "Software"), to deal
# in the Software without restriction, including without limitation the rights
# to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
# copies of the Software, and to permit persons to whom the Software is
# furnished to do so, subject to the following conditions:
#
# The above copyright notice and this permission notice shall be included in
# all copies or substantial portions of the Software.
#
# THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
# IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
# FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT.  IN NO EVENT SHALL THE
# AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
# LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
# OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
# THE SOFTWARE.

require_relative '../loader'

require_relative '../../helpers/helpers'

require 'pg'
require 'csv2psql/convert/convert'
require 'csv2psql/analyzer/analyzer'

module Jetel
  module Loaders
    class Pg < Loader
      def initialize(uri)
        super

        tmp = uri.split('://')
        tmp = tmp[1].split('@')

        parts = tmp[0].split(':')
        user = parts[0]
        password = parts[1]

        parts = tmp[1].split('/')
        host, port = parts[0].split(':')
        dbname = parts[1]

        opts = {
          :host => host,
          :port => port.to_i,
          # :options => '',
          # :tty => '',
          :dbname => dbname,
          :user => user,
          :password => password
        }

        @client = PG.connect(opts)
      end

      def load(modul, source, file, opts)
        super

        convert_opts = {
          :l => opts['analyze_num_rows'] && opts['analyze_num_rows'].to_i,
          :skip => 0,
          :header => true,
          :delimiter => opts[:delimiter]
        }

        schema_list = Csv2Psql::Convert.generate_schema([file], convert_opts)
        _file_name, schema = schema_list.first

        return nil if schema.nil?

        analyzer = Csv2Psql::Analyzer.new
        column_types = (opts['column_type'] && opts['column_type'].split(/[;,]/)) || []
        column_types.each do |ct|
          name, type = ct.split('=')

          columns = schema[:columns] || []
          column = columns.find do |k, v|
            k.downcase == name
          end

          analyzer_type = analyzer.analyzers.find do |spec|
            spec[:class].name.split('::').last.downcase == type.downcase
          end

          type_val = analyzer_type ? analyzer_type[:class].const_get(:TYPE) : type

          if column
            columns[column[0]] = {
              type: type_val.to_sym,
              null: true
            }
          end
        end

        ctx = {
          :ctx => {
            :table => Helper.sanitize(source[:name]).downcase,
            :columns => schema[:columns],
            :source => source,
            :module => modul,
            :file => File.absolute_path(modul.transformed_file(source, opts)),
            :delimiter => opts[:delimiter]
          }
        }

        sql = Helper.erb_template(File.expand_path('../sql/schema.sql.erb', __FILE__), ctx)
        sql.gsub!("\n\n", "\n")
        puts sql
        @client.exec(sql)

        sql = Helper.erb_template(File.expand_path('../sql/copy.sql.erb', __FILE__), ctx)
        sql.gsub!("\n\n", "\n")
        puts sql
        @client.exec(sql)

        file = File.open(ctx[:ctx][:file], 'r')
        while !file.eof?
          # Add row to copy data
          @client.put_copy_data(file.readline)
        end

        # We are done adding copy data
        @client.put_copy_end

        # Display any error messages
        while res = @client.get_result
          e_message = res.error_message
          if e_message && !e_message.empty?
            puts e_message
          end
          puts "#{res.cmdtuples} row(s) affected"
        end

        sql
      end
    end
  end
end
