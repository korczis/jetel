# encoding: utf-8

require_relative '../config/config'

module Jetel
  module Helper
    class << self
      def target_dir(modul, source)
        "#{Config[:DATA_DIRECTORY]}"
      end
    end
  end
end
