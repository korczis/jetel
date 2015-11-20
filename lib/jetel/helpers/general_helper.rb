# encoding: utf-8

# Copyright (c) 2015, Tomas Korcak <korczis@gmail.com>
#
# Permission is hereby granted, free of charge, to any person obtaining a copy
# of this software and associated documentation files (the "Software"), to deal
# in the Software without restriction, including without limitation the rights
# to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
# copies of the Software, and to permit persons to whom the Software is
# furnished to do so, subject to the following conditions:
#
# The above copyright notice and this permission notice shall be included in
# all copies or substantial portions of the Software.
#
# THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
# IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
# FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT.  IN NO EVENT SHALL THE
# AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
# LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
# OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
# THE SOFTWARE.

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
