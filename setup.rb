#!/usr/bin/env ruby
$LOAD_PATH.unshift(File.join(File.dirname(__FILE__), 'lib'))

require 'optparse'
require 'yaml'
require 'fileutils'
require 'ostruct'
require 'erb'
require 'options/api'

Dir[File.dirname(File.absolute_path(__FILE__)) + '/lib/options/*.rb'].each do |file|
  require file
end

interactive = false
defaults = false
config = {}

optparse = OptionParser.new do |opts|
  opts.banner = 'Usage: setup.rb [options]'

  opts.on('-cfgFILE', '--config-file=FILE', 'Existing YAML Config file, see docs for format.') do |file|
    config = YAML.load_file(file)
  end

  opts.on('-i', '--interactive', 'Confirm any existing configurations, YAML or options.') do
    interactive = true
  end

  opts.on('-d', '--defaults', 'Use all default value. Minimal prompting.') do
    defaults = true
  end
end

options = Array.new

VagrantAem.constants.select do |c|
  options << VagrantAem.const_get(c).new if VagrantAem.const_get(c) < VagrantAem::Option
end

options.sort { |left, right| left.priority <=> right.priority }

options.each do |opt|
  opt.options(optparse)
end

options.each do |opt|
  opt.confirm if interactive
  opt.prompt
end