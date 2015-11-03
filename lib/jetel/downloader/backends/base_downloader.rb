# encoding: utf-8

require_relative '../../config/config'

module Jetel
  module Downloaders
    class BaseDownloader
      DATA_DIRECTORY = Config[:DATA_DIRECTORY]
    end
  end
end
