# encoding: utf-8

require_relative '../config/config'

module Jetel
  module Helper
    class << self
      def target_dir(modul, source)
        "#{File.join(Config[:DATA_DIRECTORY], modul.class.name.split('::').last, source[:name])}"
      end
    end
  end
end
