#!/usr/bin/env ruby

require 'json'
require 'erb'
require_relative 'setup/options'

# Constants

PROJECT_ROOT = File.expand_path(File.join(File.dirname(__FILE__)))
SETUP_DIR = File.join(PROJECT_ROOT, 'setup')
TEMPLATE_DIR = File.join(SETUP_DIR, 'templates')

FILE_MODES = File::CREAT | File::TRUNC | File::WRONLY
VAGRANT_FILE = 'Vagrantfile'
PARAMS_FILE = File.join(SETUP_DIR, 'config.json')

# Functions

def readConfig(file)

  if File.exist?(file)
    contents = ''
    File.open(file, File::RDONLY) do |f|
      contents = f.read()
    end
    JSON.parse(contents)
  end
end

def getConfig(cfg_file)
  config = readConfig(cfg_file)
  config = Hash.new unless config
  config
end

def writeTemplate(tplfile, outfile, params, dest_dir = PROJECT_ROOT, mode = 0644)

  tpl_data = OpenStruct.new(params)
  template = File.read(File.join(TEMPLATE_DIR, "#{tplfile}.erb"))
  renderer = ERB.new(template, nil, '<>')
  File.open(File.join(dest_dir, outfile), FILE_MODES, mode) do |f|
    f.write(renderer.result(tpl_data.instance_eval { binding }))
  end
end

# Main Functionality

cfg_file = ARGV.shift || PARAMS_FILE

puts "CFG: #{cfg_file}"
store = getConfig(cfg_file)

puts "Current Store: #{store}"

config_options = ConfigOptions.new
config_options.confirm(store)
config_options.prompt
config_options.populate(store)

puts store.to_json

# Configure the OS Update rules

# Configure the Ruby Update rules

# Customize Vagrant options
# CPU
# Memory
# Hostname


# Create the Vagrant file

writeTemplate(File.join(store[:provider], VAGRANT_FILE).to_s, VAGRANT_FILE, store)


