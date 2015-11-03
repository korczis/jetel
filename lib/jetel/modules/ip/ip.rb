# encoding: utf-8

require 'pmap'

require_relative '../../config/config'
require_relative '../../helpers/helpers'
require_relative '../../modules/module'

module Jetel
  module Modules
    class Ip < Module
      SOURCES = [
        {
          name: 'afrinic',
          url: 'ftp://ftp.afrinic.net/pub/stats/afrinic/delegated-afrinic-latest'
        },
        {
          name: 'apnic',
          url: 'ftp://ftp.apnic.net/pub/stats/apnic/delegated-apnic-latest'
        },
        {
          name: 'arin',
          url: 'ftp://ftp.arin.net/pub/stats/arin/delegated-arin-latest'
        },
        {
          name: 'lacnic',
          url: 'ftp://ftp.lacnic.net/pub/stats/lacnic/delegated-lacnic-latest'
        },
        {
          name: 'ripencc',
          url: 'ftp://ftp.ripe.net/ripe/stats/delegated-ripencc-latest'
        },
        {
          name: 'iana',
          url: 'ftp://ftp.apnic.net/pub/stats/iana/delegated-iana-latest'
        }
      ]

      def download
        SOURCES.pmap do |source|
          target_dir = Helper.target_dir(self, source)
          downloader.download(source[:url], {:dir => target_dir})
        end
      end

      def extract
      end

      def transform
      end

      def load
      end
    end
  end
end
