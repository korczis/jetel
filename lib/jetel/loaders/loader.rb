module Jetel
  module Loaders
    class Loader
      attr_reader :uri
      def initialize(uri)
        @uri = uri
      end

      def load(modul, source, file, opts)
        {
          :file => file,
          :module => modul,
          :source => source
        }
      end
    end
  end
end
