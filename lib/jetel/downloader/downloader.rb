module Jetel
  class Downloader
    class << self
      def download(file)
        file.is_a?(Array) ? download_files(file) : download_file(file)
      end

      def download_files(files)
        files.map do |file|
          download_file(file)
        end
      end

      def download_file(file)
        puts "Downloading file #{file}"
      end
    end
  end
end
