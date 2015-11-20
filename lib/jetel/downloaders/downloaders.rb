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

require 'active_support/inflector'
require_relative 'downloaders'

require_relative '../extensions/extensions'
require_relative '../helpers/helpers'

module Jetel
  module Downloaders
    class << self
      def downloaders(loaders_dir = File.join(File.dirname(__FILE__)), auto_require = true, require_only = false)
        dir = File.absolute_path(loaders_dir)
        res = Dir.entries(dir).map do |entry|
          dir_path = File.join(dir, entry)

          next unless File.directory?(dir_path)
          next if entry == '.' || entry == '..'

          full_path = File.join(dir_path, "#{entry}.rb")
          next unless File.exist?(full_path)

          # Require file if auto_require true
          require(full_path) if auto_require

          # Go to next file if require_only mode
          next if require_only

          class_name = entry.camelize
          qualified_class_name = "Jetel::Downloaders::#{class_name}"

          # Return value from map iteration
          {
            name: entry,
            path: full_path,
            class_name: class_name,
            qualified_class_name: qualified_class_name,
            klass: auto_require ? Kernel.qualified_const_get(qualified_class_name) : nil
          }
        end

        # Remove nil values and return
        res.compact
      end

      def choose_downloader
        if Helper.which('aria2c')
          return Downloaders::Aria
        end

        if Helper.which('curl')
          return Downloaders::Curl
        end

        if Helper.which('wget')
          return Downloaders::Wget
        end

        Downloaders::Ruby
      end
    end
  end
end
