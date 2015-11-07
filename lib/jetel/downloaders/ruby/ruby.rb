# encoding: utf-8

require 'pty'

require_relative '../base_downloader'

module Jetel
  module Downloaders
    class Ruby < BaseDownloader
      def download(url, opts = BaseDownloader::OPTS_DOWNLOAD)
        super

        puts 'Not implemented'
      end
    end
  end
end
