# encoding: utf-8

require 'pty'

require_relative 'base_downloader'

module Jetel
  module Downloaders
    class Aria < BaseDownloader
      def download(url, opts = BaseDownloader::OPTS_DOWNLOAD)
        super

        $stdout.sync = true

        opts = BaseDownloader::OPTS_DOWNLOAD.merge(opts)

        cmd = "aria2c -j 4 -t 600 -d \"#{opts[:dir]}\" #{url}"
        puts(cmd)

        PTY.spawn(cmd) do |stdout, stdin, pid|
          begin
            # Do stuff with the output here. Just printing to show it works
            stdout.each { |line| print line }
          end
        end
      end
    end
  end
end
