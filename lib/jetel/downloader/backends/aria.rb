# encoding: utf-8

module Jetel
  module Downloaders
    class Aria
      class << self
        def download(url)
          `aria2c #{url}`
        end
      end
    end
  end
end
