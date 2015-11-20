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
require 'pmap'
require 'pty'

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
