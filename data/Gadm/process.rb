#! /usr/bin/env ruby

require 'fileutils'

Dir['**/*.topo.json'].each do |path|
  parts = path.split('/')
  dest = parts[1..-1].join('/')
  dir = File.dirname(dest)
  unless Dir.exist?(dir)
    FileUtils.mkdir_p(dir)
  end

  puts "#{path} -> #{dest}"
  FileUtils.copy(path, dest)
end
