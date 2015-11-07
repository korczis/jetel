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
        return Downloaders::Wgetx

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
