# encoding: utf-8

require_relative '../../version'

require_relative '../shared'

desc 'Print version info'
command :version do |c|
  c.action do |_global_options, _options, _args|
    puts Jetel::VERSION
  end
end
