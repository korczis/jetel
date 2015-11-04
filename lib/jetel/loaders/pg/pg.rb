require_relative '../loader'

require 'pg'

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
    end
  end
end
