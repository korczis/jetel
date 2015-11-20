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

require_relative '../../config/config'
require_relative '../../modules/module'

require 'nokogiri'
require 'open-uri'

module Jetel
  module Modules
    class Gadm < Module
      class << self
        def sources
          page = Nokogiri::HTML(open('http://www.gadm.org/country'))

          options = page.css('select[name="cnt"] > option')

          res = options.map do |option|
            full_name = option['value']
            name = "#{full_name.split('_').first}"
            filename = "#{name}_adm_shp.zip"
            {
              name: name,
              url: "http://biogeo.ucdavis.edu/data/gadm2.8/shp/#{filename}",
              filename_downloaded: filename,
              flat: true,
              filename_transformed: "#{name}_adm?.topo.json"
            }
          end

          res
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
        self.class.sources.pmap(8) do |source|
          extracted_file = extracted_file(source, global_options.merge(options))
          transformed_file = transformed_file(source, global_options.merge(options))
          dest_dir = transform_dir(source, global_options.merge(options))
          FileUtils.mkdir_p(dest_dir)

          extracted_dir = extract_dir(source, global_options.merge(options))
          Dir.glob("#{extracted_dir}/*.shp") do |shapefile|
            puts "Transforming #{shapefile}"

            # "topojson data/Gadm/AFG/extracted/AFG_adm0.shp -o data/Gadm/AFG/transformed/AFG_adm0.topo.json"
            cmd = "topojson #{shapefile} -o #{shapefile.gsub(extracted_dir, dest_dir).gsub('.shp', '.topo.json')}"
            puts cmd
            PTY.spawn(cmd) do |stdout, stdin, pid|
              begin
                # Do stuff with the output here. Just printing to show it works
                stdout.each { |line| print line }
              end
            end
          end
        end
      end
    end
  end
end
