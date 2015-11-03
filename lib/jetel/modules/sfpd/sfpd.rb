# encoding: utf-8

require 'pmap'

require_relative '../../config/config'
require_relative '../../helpers/helpers'
require_relative '../../modules/module'

module Jetel
  module Modules
    class Sfpd < Module
      SOURCES = [
        {
          name: 'sfpd',
          url: 'https://data.sfgov.org/api/views/tmnf-yvry/rows.csv'
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
