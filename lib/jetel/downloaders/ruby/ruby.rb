# encoding: utf-8

require 'rest-client'

require_relative '../../version.rb'

require_relative '../base_downloader'

module Jetel
  module Downloaders
    class Ruby < BaseDownloader
      def download(url, opts = BaseDownloader::OPTS_DOWNLOAD)
        super

        raw = {
          :headers => {
            :user_agent => "jetel/#{Jetel::VERSION}"
          },
          :method => :get,
          :url => url,
          # TODO: Load from config, param or so
          :verify_ssl => false
        }

        FileUtils.mkdir_p(opts[:dir])

        filename = opts[:filename] || url.split('/').last

        out_full_path = File.join(opts[:dir], filename)

        File.open(out_full_path, 'w') do |file|
          RestClient::Request.execute(raw) do |chunk, _x, response|
            if response.code.to_s != '200'
              fail ArgumentError, "Error downloading #{url}. Got response: #{response.code} #{response} #{response.body}"
            end
            file.write chunk
          end
        end
      end
    end
  end
end
