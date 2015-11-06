# encoding: utf-8

require 'pmap'

require_relative '../../config/config'
require_relative '../../modules/module'

module Jetel
  module Modules
    class Wifileaks < Module
      class << self
        def sources
          [
            {
              name: 'wifileaks',
              url: 'http://download.wifileaks.cz/data/wifileaks_150709.tsv'
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
          downloaded_file = downloaded_file(source, global_options.merge(options))
          dest_dir = extract_dir(source, global_options.merge(options))

          puts "Extracting #{downloaded_file}"

          FileUtils.mkdir_p(dest_dir)
          FileUtils.cp(downloaded_file, dest_dir)
        end
      end

      def transform(global_options, options, args)
        self.class.sources.pmap do |source|
          opts = global_options.merge(options)

          extracted_file = extracted_file(source, opts)
          transformed_file = transformed_file(source, opts)

          puts "Transforming #{extracted_file}"

          headers = %w(
            MAC
            SSID
            security
            latitude
            longitude
            altitude
            updated_at
          )

          File.open(extracted_file, 'r') do |file_in|
            File.open(transformed_file, 'w') do |file_out|
              file_out.puts(headers.join("\t"))
              file_in.each do |line|
                next if line == "\n"
                file_out.puts(line.chomp)
              end
            end
          end
        end
      end

      def load(global_options, options, args)
        res = super(global_options, options.merge({:delimiter => "\t"}), args)
        res
      end

    end
  end
end
