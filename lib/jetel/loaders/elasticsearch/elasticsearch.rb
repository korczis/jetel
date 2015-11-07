require_relative '../loader'

require_relative '../../helpers/helpers'

require 'elasticsearch'

module Jetel
  module Loaders
    class Elasticsearch < Loader
      attr_reader :client, :index, :document_type

      def initialize(uri)
        super

        tmp = uri.split('://')
        tmp = tmp[1].split('@')

        parts = tmp[0].split(':')
        user = parts[0]
        password = parts[1]

        parts = tmp[1].split('/')
        host, port = parts[0].split(':')
        @index, @document_type = parts[1], parts[2]

        opts = {
          :host => host,
          :port => (port && port.to_i) || 9200,
          # :options => '',
          # :tty => '',
          # :bucket => bucket,
          # :username => user,
          # :password => password,
          # :connection_timeout => 360e6,
          # :timeout => 360e6
        }

        @client = ::Elasticsearch::Client.new(opts)

        puts client.cluster.health

        # client.index index: index, type: document_type, body: {title: 'Test'}
      end

      def load(modul, source, file, opts)
        super

        cache = []
        CSV.open(file, 'rt', :headers => true, :converters => :all) do |csv|
          csv.each do |row|
            cache << {
              create: {
                _index: @index,
                _type: @document_type,
                # _id: 1,
                data: row.to_hash
              }
            }
            if cache.length === 5_000
              client.bulk(body: cache)
              cache = []
              print '.'
            end
          end

          if cache.length > 0
            client.bulk(body: cache)
            cache = []
          end
        end
      end
    end
  end
end
