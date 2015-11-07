# encoding: utf-8

require 'terminal-table'

require_relative '../../loaders/loaders'

LOADERS = Jetel::Loaders.loaders

desc 'Print loaders info'
command :loaders do |c|
  c.action do |_global_options, _options, _args|
    rows = LOADERS.map do |m|
      [m[:name], m[:klass]]
    end

    table = Terminal::Table.new :headings => %w(Name Class), :rows => rows
    puts table
  end
end
