require 'active_support/inflector'
require_relative '../extensions/extensions'

module Jetel
  module Loaders
    class << self
      def loaders(loaders_dir = File.join(File.dirname(__FILE__)), auto_require = true, require_only = false)
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
          qualified_class_name = "Jetel::Loaders::#{class_name}"

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
    end
  end
end
