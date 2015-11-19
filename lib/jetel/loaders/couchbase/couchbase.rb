require_relative '../loader'

require_relative '../../helpers/helpers'

require 'couchbase'
require 'multi_json'
require 'securerandom'

module Jetel
  module Loaders
    class Couchbase < Loader
      attr_reader :client

      def initialize(uri)
        super

        tmp = uri.split('://')
        tmp = tmp[1].split('@')

        parts = tmp[0].split(':')
        user = parts[0]
        password = parts[1]

        parts = tmp[1].split('/')
        host, port = parts[0].split(':')
        bucket = parts[1]

        opts = {
          :host => host,
          :port => (port && port.to_i) || 8091,
          # :options => '',
          # :tty => '',
          :bucket => bucket,
          # :username => user,
          # :password => password,
          :connection_timeout => 360e6,
          :timeout => 360e6
        }

        @client = ::Couchbase.connect(opts)
      end

      def load_csv(modul, source, file, opts)
        cache = {}
        CSV.open(file, 'rt', :headers => true, :converters => :all) do |csv|
          csv.each do |row|
            cache[SecureRandom.uuid] = row.to_hash
            if cache.length === 5_000
              client.add(cache)
              cache = {}
              print '.'
            end
          end

          if cache.length > 0
            client.add(cache)
            cache = {}
          end
        end
      end

      def load_json(modul, source, file, opts)
        uuid = SecureRandom.uuid
        doc = {
          uuid => MultiJson.load(File.read(file))
        }
        client.add(doc)
      end

      def load(modul, source, file, opts)
        super

        if file =~ /\.csv/
          load_csv(modul, source, file, opts)
        elsif file =~ /\.json/
          load_json(modul, source, file, opts)
        end
      end
    end
  end
end
