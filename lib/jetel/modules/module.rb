# encoding: utf-8

require_relative '../downloader/downloader'

module Jetel
  module Modules
    class Module
      def downloader
        Jetel::Downloader
      end
    end
  end
end
