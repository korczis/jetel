# encoding: utf-8

require 'pmap'
require 'csv'

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

      def download(global_options, options, args)
        SOURCES.pmap do |source|
          download_source(source, global_options.merge(options))
        end
      end

      def extract(global_options, options, args)
        SOURCES.pmap do |source|
          downloaded_file = downloaded_file(source, global_options.merge(options))
          dest_dir = extract_dir(source, global_options.merge(options))

          puts "Extracting #{downloaded_file}"

          FileUtils.mkdir_p(dest_dir)
          FileUtils.cp(downloaded_file, dest_dir)
        end
      end

      def transform(global_options, options, args)
        SOURCES.pmap do |source|
          opts = global_options.merge(options)

          extracted_file = extracted_file(source, opts)
          transformed_file = transformed_file(source, opts)

          FileUtils.mkdir_p(transform_dir(source, opts))

          csv_opts = {
            :col_sep => '|'
          }

          puts "Transforming #{extracted_file}"
          CSV.open(extracted_file, 'r', csv_opts) do |csv|
            headers = %w(
              registry
              cc
              type
              start
              value
              date
              status
            )
            CSV.open(transformed_file, 'w', :write_headers => true, :headers => headers) do |csv_out|
              csv.each do |row|
                next if row.length < 7
                next if row[0] != source[:name]
                csv_out << row
              end
            end
          end
        end
      end

      def load(global_options, options, args)
        SOURCES.map do |source|
          opts = global_options.merge(options)

          transformed_file = transformed_file(source, opts)

          loader = Helper.get_loader(opts['data_loader'])

          loader.load(self, source, transformed_file, opts)
        end
      end
    end
  end
end
