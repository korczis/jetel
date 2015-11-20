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


require 'terminal-table'

require_relative '../../modules/modules'

MODULES = Jetel::Modules.modules

MODULES_ACTIONS = {
  sources: {
    params: [
      {
        desc: 'Format',
        default_value: nil,
        arg_name: 'format=format',
        flag: [:format]
      }
    ]
  },
  download: nil,
  extract: nil,
  transform: nil,
  load: {
    params: [
      {
        desc: 'Column type',
        default_value: nil,
        arg_name: 'column-name=column-type',
        flag: [:column_type]
      },
      {
        desc: 'Num Lines to analyze',
        default_value: 1000,
        arg_name: 'num',
        flag: [:analyze_num_rows]
      }
    ]
  }
}

# Gets module name
#
# @param m [Hash] Module info
# @return [String] Module name
def get_module_name(m)
  m[:name]
end

# Register module (CLI) action
#
# @param c [] Parent command
# @param m [Module] Module instance
# @param action_command [String] Nested command name
# @param action_desc [String] Nested command action description
# @return [Object] Return value
def register_module_action(c, modul, name, spec, &block)
  module_name = modul[:name]
  action_description = spec && spec[:description] || "#{name} #{module_name}"

  params = spec && spec[:params] || []


  c.desc(action_description)
  c.command(name) do |cmd|
    params.each do |param|
      param.each do |name, val|
        cmd.send name, val
      end
    end

    cmd.action(&block)
  end
end

def register_module(m)
  module_name = get_module_name(m)

  desc "Module #{module_name}"
  command(m[:name], m[:class_name]) do |c|
    module_instance = m[:klass].new

    MODULES_ACTIONS.each do |name, spec|
      next unless module_instance.respond_to?(name)

      register_module_action(c, m, name, spec) do |global_options, options, args|
        module_instance.send(name, global_options, options, args)
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
