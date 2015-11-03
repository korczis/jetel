# encoding: utf-8

require 'fileutils'
require_relative '../../config/config'

module Jetel
  module Downloaders
    class BaseDownloader
      DATA_DIRECTORY = Config[:DATA_DIRECTORY]

      OPTS_DOWNLOAD = {
        :dir => DATA_DIRECTORY
      }

      def download(url, opts = OPTS_DOWNLOAD)
        opts = OPTS_DOWNLOAD.merge(opts)

        dir = opts[:dir]

        fail 'Dir can not be nil or empty!' if dir.nil? || dir.empty?
        unless Dir.exist?(dir)
          FileUtils.mkdir_p(dir)
        end

        puts "Downloading #{url}"
      end
    end
  end
end
