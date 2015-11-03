# encoding: utf-8

require_relative '../downloader/downloader'

module Jetel
  module Modules
    class Module
      attr_reader :downloader

      def initialize
        @downloader = Downloader.new
      end

      def download(*args)
        downloader.download(*args)
      end
    end
  end
end
