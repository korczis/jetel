# encoding: utf-8

require_relative 'base_downloader'

module Jetel
  module Downloaders
    class Aria < BaseDownloader
      def download(url, opts = BaseDownloader::OPTS_DOWNLOAD)
        super

        opts = BaseDownloader::OPTS_DOWNLOAD.merge(opts)
        `aria2c -d #{opts[:dir]} #{url}`
      end
    end
  end
end
