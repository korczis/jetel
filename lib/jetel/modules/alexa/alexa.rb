# encoding: utf-8

require 'pmap'

require_relative '../../config/config'
require_relative '../../modules/module'

module Jetel
  module Modules
    class Alexa < Module
      class << self
        def sources
          [
            {
              name: 'alexa',
              # filename_downloaded: 'top-1m.csv.zip',
              filename_extracted: 'top-1m.csv',
              filename_transformed: 'top-1m.csv',
              url: 'http://s3.amazonaws.com/alexa-static/top-1m.csv.zip'
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
          transformed_file = transformed_file(source, global_options.merge(options))
          dest_dir = transform_dir(source, global_options.merge(options))

          puts "Transforming #{extracted_file}"

          FileUtils.mkdir_p(dest_dir)
          File.open(extracted_file, 'rt') do |fin|
            File.open(transformed_file, 'wt') do |fout|
              fout.puts('rank,url')

              while buff = fin.read(4096)
                fout.write(buff)
              end
            end
          end
        end
      end
    end
  end
end
