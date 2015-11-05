require_relative '../loader'

require_relative '../../helpers/helpers'

require 'pg'
require 'csv2psql/convert/convert'

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
        res = super(modul, source, file, opts)

        sql = Helper.erb_template(File.expand_path('../create_table.sql.erb', __FILE__), res)

        convert_opts = {
          :l => 100,
          :skip => 0,
          :header => true
        }

        res = Csv2Psql::Convert.generate_schema([file], convert_opts)
        k = res.keys.first
        v = res[k]

        res = Helper.erb_template(File.expand_path('../sql/schema.sql.erb', __FILE__), {:ctx => {:table => 'text', :columns => v[:columns]}})
        res.gsub!("\n\n", "\n")
        CSV.open(file, 'r', :headers => true) do |csv|
          csv.each do |row|
            puts row
          end
        end

        res
      end
    end
  end
end
