# encoding: utf-8

require 'pp'

require_relative '../../version'

require_relative '../shared'

require_relative '../../config/config'

desc 'Show config'
command :config do |c|
  c.action do |_global_options, _options, _args|
    pp Jetel::Config
  end
end
