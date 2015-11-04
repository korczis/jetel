# encoding: utf-8

require 'pmap'

require_relative '../../config/config'
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

      def download(global_options, options, args)
        SOURCES.pmap do |source|
          download_source(source, global_options.merge(options))
        end
      end

      def extract(global_options, options, args)
      end

      def transform(global_options, options, args)
      end

      def load(global_options, options, args)
      end
    end
  end
end
