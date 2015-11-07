# encoding: utf-8

require 'terminal-table'

require_relative '../../downloaders/downloaders'

DOWNLOADERS = Jetel::Downloaders.downloaders

desc 'Print downloaders info'
command :downloaders do |c|
  c.action do |_global_options, _options, _args|
    rows = DOWNLOADERS.map do |m|
      [m[:name], m[:klass]]
    end

    table = Terminal::Table.new :headings => %w(Name Class), :rows => rows
    puts table
  end
end
