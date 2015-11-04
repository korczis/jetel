# encoding: utf-8

require_relative '../downloader/downloader'
require_relative '../helpers/helpers'

module Jetel
  module Modules
    class Module
      attr_reader :downloader

      class << self
        def target_dir(modul, source, dir, *path)
          klass = I18n.transliterate(modul.class.name.split('::').last).gsub(/[^0-9a-z_\-]/i, '_')
          source_name = I18n.transliterate(source[:name]).gsub(/[^0-9a-z_\-]/i, '_')
          File.join(dir.kind_of?(String) ? dir : dir['download_dir'] || Config[:DATA_DIRECTORY], klass, source_name, path)
        end

        def download_dir(modul, source, opts)
          Module.target_dir(modul, source, opts, 'downloaded')
        end

        def extract_dir(modul, source, opts)
          Module.target_dir(modul, source, opts, 'extracted')
        end

        def transform_dir(modul, source, opts)
          Module.target_dir(modul, source, opts, 'transformed')
        end

        def downloaded_file(modul, source, opts)
          File.join(download_dir(modul, source, opts), source[:filename_downloaded] || source[:url].split('/').last)
        end

        def extracted_file(modul, source, opts)
          File.join(extract_dir(modul, source, opts), source[:filename_extracted] || source[:url].split('/').last)
        end

        def transformed_file(modul, source, opts)
          File.join(transform_dir(modul, source, opts), source[:filename_transformed] || source[:url].split('/').last)
        end
      end

      def initialize
        @downloader = Downloader.new
      end

      def download_source(source, opts)
        downloader.download(source[:url], {:dir => download_dir(source, opts)})
      end

      def target_dir(source, opts, *path)
        Module.target_dir(self, source, opts['download_dir'], *path)
      end

      def download_dir(source, opts)
        Module.download_dir(self, source, opts)
      end

      def extract_dir(source, opts)
        Module.extract_dir(self, source, opts)
      end

      def transform_dir(source, opts)
        Module.transform_dir(self, source, opts)
      end

      def downloaded_file(source, opts)
        Module.downloaded_file(self, source, opts)
      end

      def extracted_file(source, opts)
        Module.extracted_file(self, source, opts)
      end

      def transformed_file(source, opts)
        Module.transformed_file(self, source, opts)
      end
    end
  end
end
