# encoding: UTF-8

require 'gli'
require 'pathname'

require_relative '../version'

require_relative '../downloader/backends/base_downloader'

include GLI::App

# Program description
program_desc 'Simple custom made tool for data download and basic ETL'

# Version info
version Jetel::VERSION

# Download directory
desc 'Download directory'
default_value 'data' # File.absolute_path(File.join(File.dirname(__FILE__), '..', '..', '..', 'data'))
arg_name 'download-dir'
flag [:d, :download_dir]

# Download timeout
desc 'Download timeout'
default_value Jetel::Downloaders::BaseDownloader::OPTS_DOWNLOAD[:timeout]
arg_name 'download-timeout'
flag [:t, :timeout]

# Data loader
desc 'Data Loader'
default_value 'pg://jetel:jetel@localhost:5432/jetel'

arg_name 'data-loader'
flag [:l, :data_loader]

# On Error handler
on_error do |exception|
  pp exception.backtrace
  pp exception
  true
end