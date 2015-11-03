# encoding: utf-8

require_relative 'backends/aria'

module Jetel
  class Downloader
    attr_reader :downloader

    def initialize
      @downloader = Downloaders::Aria.new
    end

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
      downloader.download(file)
    end
  end
end
