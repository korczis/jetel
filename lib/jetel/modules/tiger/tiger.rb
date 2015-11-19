# encoding: utf-8

require 'pmap'

require_relative '../../config/config'
require_relative '../../modules/module'

require 'nokogiri'
require 'open-uri'

module Jetel
  module Modules
    class Tiger < Module
      BASE_URL = 'http://www2.census.gov/geo/tiger/TIGER2015'
      CSS_SELECTOR = '#innerPage > table > tr > td > a'

      class << self
        def sub_sources(base_url)
          page = Nokogiri::HTML(open(base_url))

          links = page.css(CSS_SELECTOR)

          links[1..-1].map do |link|
            next unless link
            name = base_url.split('/').last # link.text.gsub('/', '')
            href = link.attr('href')

            {
              name: name,
              url: "#{base_url}#{href}".gsub('http://www2', 'ftp://ftp'),
              filename_downloaded: href,
              # flat: true,
              # filename_transformed: "#{name}_adm?.topo.json"
            }
          end
        end

        def sources
          page = Nokogiri::HTML(open(BASE_URL))

          links = page.css(CSS_SELECTOR)

          res = links[2..-1].pmap(8) do |link|
            next unless link
            href = link.attr('href')
            url = "#{BASE_URL}/#{href}"

            puts "Processing #{url}"
            tmp = sub_sources(url)
          end

          res.flatten
        end
      end

      def download(global_options, options, args)
        self.class.sources.pmap(16) do |source|
          download_source(source, global_options.merge(options))
        end
      end

      def extract(global_options, options, args)
        self.class.sources.pmap(8) do |source|
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
