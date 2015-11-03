# encoding: utf-8

require_relative 'base_downloader'

module Jetel
  module Downloaders
    class Aria < BaseDownloader
      def download(url)
        `aria2c -d #{DATA_DIRECTORY} #{url}`
      end
    end
  end
end
