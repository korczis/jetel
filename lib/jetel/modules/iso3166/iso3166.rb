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

require 'nokogiri'
require 'open-uri'
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
              name: 'iso3166',
              url: 'https://en.wikipedia.org/wiki/ISO_3166-1'
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
          extracted_file = extracted_file(source, global_options.merge(options))
          dest_dir = transform_dir(source, global_options.merge(options))
          FileUtils.mkdir_p(dest_dir)

          puts "Transforming #{extracted_file}"

          page = Nokogiri::HTML(open(extracted_file))
          rows = page.css('table.wikitable.sortable tr')

          headers = [
            'name',
            'alpha2',
            'alpha3',
            'numeric'
          ]

          transformed_file = "#{extracted_file.gsub(extract_dir(source, global_options.merge(options)), dest_dir)}.csv"
          CSV.open(transformed_file, 'w', :write_headers => true, :headers => headers, :quote_char => '"', :force_quotes => true) do |csv|
            rows.each do |row|
              td = row.css('td')

              next if td.length < 4

              name = td[0].css('a').text
              alpha2 = td[1].text
              alpha3 = td[2].text
              numeric = td[3].text

              csv << [
                 name,
                 alpha2,
                 alpha3,
                 numeric
              ]
            end
          end
        end
      end
    end
  end
end
