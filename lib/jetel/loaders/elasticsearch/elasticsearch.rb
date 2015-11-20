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
