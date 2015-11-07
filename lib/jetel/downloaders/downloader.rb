# encoding: utf-8

module Jetel
  class Downloader
    attr_reader :downloader

    def initialize
      @downloader = Downloaders.choose_downloader.new
    end

    def download(file, opts = {})
      file.is_a?(Array) ? download_files(file, opts) : download_file(file, opts)
    end

    def download_files(files, opts = {})
      files.map do |file|
        download_file(file, opts)
      end
    end

    def download_file(file, opts = {})
      downloader.download(file, opts)
    end
  end
end
