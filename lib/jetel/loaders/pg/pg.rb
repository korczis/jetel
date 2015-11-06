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
          :l => 1_000,
          :skip => 0,
          :header => true
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
            :file => File.absolute_path(modul.transformed_file(source, opts))
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
          if e_message = res.error_message
            p e_message
          end
        end

        sql
      end
    end
  end
end
