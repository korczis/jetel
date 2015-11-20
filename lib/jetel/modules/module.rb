# encoding: utf-8

# Copyright (c) 2015, Tomas Korcak <korczis@gmail.com>
#
# Permission is hereby granted, free of charge, to any person obtaining a copy
# of this software and associated documentation files (the "Software"), to deal
# in the Software without restriction, including without limitation the rights
# to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
# copies of the Software, and to permit persons to whom the Software is
# furnished to do so, subject to the following conditions:
#
# The above copyright notice and this permission notice shall be included in
# all copies or substantial portions of the Software.
#
# THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
# IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
# FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT.  IN NO EVENT SHALL THE
# AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
# LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
# OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
# THE SOFTWARE.

require 'multi_json'
require 'pp'
require 'zip'

require_relative '../downloaders/downloader'
require_relative '../helpers/helpers'

module Jetel
  module Modules
    class Module
      attr_reader :downloader

      class << self
        def target_dir(modul, source, dir, *path)
          klass = modul.class.name.split('::').last
          source_name = Helper.sanitize(source[:name])
          File.join(dir.kind_of?(Hash) ? dir['download_dir'] : dir || Config[:DATA_DIRECTORY], klass, source[:flat] ? '' : source_name, path)
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
        downloaded_file = downloaded_file(source, opts)

        unless File.exists?(downloaded_file)
          downloader.download(source[:url], {:dir => download_dir(source, opts), :filename => source[:filename_downloaded]})
        end
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

      def load(global_options, options, args)
        sources = self.class.sources
        if args.length > 0
          args = args.map(&:downcase)
          sources = sources.select do |source|
            args.index(source[:name].downcase)
          end
        end

        sources.map do |source|
          opts = global_options.merge(options)

          transformed_file = transformed_file(source, opts)

          loader = Helper.get_loader(opts['data_loader'])

          Dir.glob(transformed_file).each do |one_file|
            puts "Loading file #{one_file}"
            loader.load(self, source, one_file, opts)
          end
        end
      end

      def sources(global_options, options, _args)
        opts = global_options.merge(options)

        res = self.class.sources

        if opts['format'] == 'json'
          puts MultiJson.dump(res, :pretty => true)
        else
          pp res
        end

      end

      def unzip(source, options = {})
        downloaded_file = downloaded_file(source, options)
        dest_dir = extract_dir(source, options)

        FileUtils.mkdir_p(dest_dir)

        Zip::ZipFile.open(downloaded_file) do |zip_file|
          # Handle entries one by one
          zip_file.each do |entry|
            # Extract to file/directory/symlink
            puts "Extracting #{entry.name}"
            dest_file = File.join(dest_dir, entry.name.split('/').last)
            FileUtils.rm_rf(dest_file)
            entry.extract(dest_file)
          end
        end
      end
    end
  end
end
