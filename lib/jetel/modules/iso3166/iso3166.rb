# encoding: utf-8

require 'pmap'
require 'zip'
require 'csv'

require_relative '../../config/config'
require_relative '../../modules/module'

module Jetel
  module Modules
    class Iso3166 < Module
      class << self
        def sources
          [
            {
              name: 'iso366',
              filename_extracted: 'IP2LOCATION-ISO3166-2.CSV',
              filename_transformed: 'IP2LOCATION-ISO3166-2.CSV',
              url: 'http://www.ip2location.com/downloads/Hi3sL9bnXfe/IP2LOCATION-ISO3166-2.ZIP'
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
          opts = global_options.merge(options)

          extracted_file = extracted_file(source, opts)
          transformed_file = transformed_file(source, opts)

          FileUtils.mkdir_p(transform_dir(source, opts))

          csv_opts = {
            :headers => true
          }

          puts "Transforming #{extracted_file}"
          CSV.open(extracted_file, 'r', csv_opts) do |csv|
            headers = %w(
              country_code
              subdivision_name
              code
            )
            CSV.open(transformed_file, 'w', :write_headers => true, :headers => headers) do |csv_out|
              csv.each do |row|
                next if row.length < 3
                csv_out << row
              end
            end
          end
        end
      end
    end
  end
end
