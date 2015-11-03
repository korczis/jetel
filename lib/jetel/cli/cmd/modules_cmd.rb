# encoding: utf-8

require 'gli'
require 'terminal-table'

include GLI::App

require_relative '../../version'

require_relative '../shared'

require_relative '../../modules/modules'

MODULES = Jetel::Modules.modules

MODULES_ACTIONS = {
  download: nil,
  extract: nil,
  transform: nil,
  load: nil
}

def get_module_name(m)
  m[:name]
end

def register_module_action(c, _m, action_command, action_desc, &block)
  c.desc(action_desc)
  c.command(action_command) do |cmd|
    cmd.action(&block)
  end
end

def register_module(m)
  module_name = get_module_name(m)

  desc "Module #{module_name}"
  command(m[:name], m[:class_name]) do |c|
    module_instance = m[:klass].new
    module_name = m[:name]

    MODULES_ACTIONS.each do |k, v|
      next unless module_instance.respond_to?(k)

      action_name = k
      action_description = v || "#{action_name} #{module_name}"
      register_module_action(c, m, action_name, action_description) do
        module_instance.send(k)
      end
    end
  end
end

desc 'Print modules info'
command :modules do |c|
  c.action do |_global_options, _options, _args|
    rows = MODULES.map do |m|
      [m[:name], m[:klass]]
    end

    table = Terminal::Table.new :headings => %w(Name Class), :rows => rows
    puts table
  end
end

# Register all modules
MODULES.each do |m|
  register_module(m)
end
