# encoding: utf-8

require 'pmap'

require_relative '../../config/config'
require_relative '../../modules/module'

module Jetel
  module Modules
    class Geolite < Module
      class << self
        def sources
          [
            {
              name: 'geolite',
              # filename_downloaded: 'SFPD_Incidents_-_from_1_January_2003.csv',
              filename_extracted: 'GeoLite2-City-Blocks-IPv4.csv',
              filename_transformed: 'GeoLite2-City-Blocks-IPv4.csv',
              url: 'http://geolite.maxmind.com/download/geoip/database/GeoLite2-City-CSV.zip'
            }
          ]
        end
      end

      def download(global_options, options, args)
        self.class.sources.pmap do |source|
          download_source(source, global_options.merge(options))
        end
      end

      def extract(global_options, options, args)
        self.class.sources.pmap do |source|
          unzip(source, global_options.merge(options))
        end
      end

      def transform(global_options, options, args)
        self.class.sources.pmap do |source|
          extracted_file = extracted_file(source, global_options.merge(options))
          dest_dir = transform_dir(source, global_options.merge(options))

          puts "Transforming #{extracted_file}"

          FileUtils.mkdir_p(dest_dir)
          FileUtils.cp(extracted_file, dest_dir)
        end
      end
    end
  end
end
