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
