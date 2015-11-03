# encoding: utf-8

require_relative '../../modules/module'

module Jetel
  module Modules
    class Ip < Module
      SOURCES = {
        afrinic: 'ftp://ftp.afrinic.net/pub/stats/afrinic/delegated-afrinic-latest',
        apnic: 'ftp://ftp.apnic.net/pub/stats/apnic/delegated-apnic-latest',
        arin: 'ftp://ftp.arin.net/pub/stats/arin/delegated-arin-latest',
        lacnic: 'ftp://ftp.lacnic.net/pub/stats/lacnic/delegated-lacnic-latest',
        ripencc: 'ftp://ftp.ripe.net/ripe/stats/delegated-ripencc-latest',
        iana: 'ftp://ftp.apnic.net/pub/stats/iana/delegated-iana-latest'
      }

      def download
        SOURCES.each do |_name, url|
          Downloader.download(url)
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
