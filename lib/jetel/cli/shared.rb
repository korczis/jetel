# encoding: UTF-8

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

require 'gli'
require 'pathname'

require_relative '../version'

require_relative '../downloaders/base_downloader'

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
# on_error do |exception|
#   pp exception.backtrace
#   pp exception
#   true
# end