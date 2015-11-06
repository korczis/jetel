# encoding: utf-8

require_relative '../config/config'

require_relative '../helpers/helpers'
require_relative '../loaders/loaders'

require 'erb'
require 'i18n'
require 'ostruct'

module Jetel
  module Helper
    class << self
      def target_dir(modul, dir, source)
        klass = modul.class.name.split('::').last
        source_name = Helper.sanitize(source[:name])
        File.join(dir || Config[:DATA_DIRECTORY], klass, source_name)
      end

      def get_loader(uri)
        loaders = Loaders.loaders
        loader_schema = uri.split(':/').first.downcase
        res = loaders.find do |loader|
          loader[:class_name].downcase === loader_schema
        end

        res[:klass].new(uri)
      end

      def erb(template, vars)
        ERB.new(template).result(OpenStruct.new(vars).instance_eval { binding })
      end

      def erb_template(file, vars)
        template = File.open(file, 'r').read
        ERB.new(template).result(OpenStruct.new(vars).instance_eval { binding })
      end

      def sanitize(str)
        I18n.transliterate(str).gsub(/[^0-9a-z_\-]/i, '_')
      end
    end
  end
end
