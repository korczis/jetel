# encoding: utf-8



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
              flat: false,
              filename_transformed: "#{name}_adm?.topo.json"
            }
          end

          res
        end
      end

      def download(global_options, options, args)
        self.class.sources.pmap(4) do |source|
          download_source(source, global_options.merge(options))
        end
      end

      def extract(global_options, options, args)
        self.class.sources.pmap(4) do |source|
          unzip(source, global_options.merge(options))
        end
      end

      def transform(global_options, options, args)
        [1, 2, 3, 4, 5, 6, 7, 8, 9].each do |quantization|
          self.class.sources.pmap(4) do |source|
            extracted_file = extracted_file(source, global_options.merge(options))
            transformed_file = transformed_file(source, global_options.merge(options))
            dest_dir = File.join(transform_dir(source, global_options.merge(options)), quantization.to_s)
            FileUtils.mkdir_p(dest_dir)

            extracted_dir = extract_dir(source, global_options.merge(options))
            Dir.glob("#{extracted_dir}/*.shp") do |shapefile|
              puts "Transforming #{shapefile}"

              destfile = shapefile.gsub(extracted_dir, dest_dir).gsub('.shp', '.topo.json')
              cmd = "topojson --no-stitch-poles -q 1e#{quantization} #{shapefile} -o #{destfile} -p --bbox --shapefile-encoding utf8"
              puts cmd
              begin
                PTY.spawn(cmd) do |stdout, stdin, pid|
                  begin
                    # Do stuff with the output here. Just printing to show it works
                    stdout.each { |line| print line }
                  end
                end
              rescue => e
                puts e.message
                puts e.backtrace
              end
            end
          end
        end
      end
    end
  end
end
