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

require 'fileutils'
require_relative '../config/config'

module Jetel
  module Downloaders
    class BaseDownloader
      DATA_DIRECTORY = Config[:DATA_DIRECTORY]

      OPTS_DOWNLOAD = {
        :dir => DATA_DIRECTORY,
        :timeout => 600
      }

      def download(url, opts = OPTS_DOWNLOAD)
        opts = OPTS_DOWNLOAD.merge(opts)

        dir = opts[:dir]

        fail 'Dir can not be nil or empty!' if dir.nil? || dir.empty?
        unless Dir.exist?(dir)
          FileUtils.mkdir_p(dir)
        end

        puts "Downloading #{url}"
      end
    end
  end
end
