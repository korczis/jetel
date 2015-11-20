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

require 'fileutils'
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
