#!/usr/bin/env ruby

require 'erb'
require 'fileutils'
require 'json'
require 'ostruct'

PROJECT_ROOT = File.expand_path(File.join(File.dirname(__FILE__), '..'))
SETUP_DIR = File.join(PROJECT_ROOT, 'setup')
TEMPLATE_DIR = File.join(SETUP_DIR, 'templates')
PUPPET_DIR = File.join(PROJECT_ROOT, 'puppet')
FILES_DIR = File.join(PUPPET_DIR, 'files')
MANIFEST_DIR = File.join(PUPPET_DIR, 'environments', 'local', 'manifests')

FILE_MODES = File::CREAT | File::TRUNC | File::WRONLY
VAGRANT_FILE = 'Vagrantfile'
MANIFEST_FILE = 'site.pp'
DISPATCHER_FILE = 'dispatcher.any'
PARAMS_FILE = File.join(SETUP_DIR, 'parameters.json')

def readParams(file)

  if File.exist?(file)
    contents = ''
    File.open(file, File::RDONLY) do |f|
      contents = f.read()
    end
    OpenStruct.new(JSON.parse(contents))
  end
end

def writeParams(params, file)

  params ||= OpenStruct.new
  file ||= PARAMS_FILE
  File.open(file, FILE_MODES, 0644) do |f|
    f.write("#{params.to_h.to_json}\n")
  end

end

def getParameters(param_file)

  params = readParams(param_file) if param_file

  params = OpenStruct.new unless params

  if params.client.nil? || params.client.empty?
    print 'Client name: '
    params.client = gets.downcase.strip.gsub(' ', '-').gsub(/[^\w-]/, '')
  end

  if params.jdk_pkg.nil?
    print 'Path to JDK Package (leave blank to use default for OS): '
    params.jdk_pkg = gets.chomp
  end

  if params.aem_jar.nil? || params.aem_jar.empty?
    print 'Path to AEM installer jar: '
    params.aem_jar = gets.chomp
  end

  if params.aem_license.nil? || params.aem_license.empty?
    print 'AEM License Key: '
    params.aem_license = gets.chomp
  end

  if params.dispatcher_mod.nil? || params.dispatcher_mod.empty?
    print 'Path to Dispatcher Module file: '
    params.dispatcher_mod = gets.chomp
  end

  if params.dispatcher_any.nil?
    print 'Custom dispatcher.any file: '
    params.dispatcher_any = gets.chomp
  end

  writeParams(params, param_file)
  params
end

def writeTemplate(filename, params, dest_dir = PROJECT_ROOT, mode = 0644)

  tpl_data = OpenStruct.new(params)

  template = File.read(File.join(TEMPLATE_DIR, "#{filename}.erb"))
  renderer = ERB.new(template, nil, '<>')
  File.open(File.join(dest_dir, filename), FILE_MODES, mode) do |f|
    f.write(renderer.result(tpl_data.instance_eval { binding }))
  end
end

def copyFile(file)
  FileUtils.cp(file, FILES_DIR)
end

param_file = ARGV.shift

# Params is an OpenStruct
params = getParameters(param_file)

writeTemplate(VAGRANT_FILE, params)
writeTemplate(MANIFEST_FILE, params, MANIFEST_DIR)

if params[:dispatcher_any].nil? or params[:dispatcher_any].empty?
  writeTemplate(DISPATCHER_FILE, params, FILES_DIR)
else
  copyFile(params[:dispatcher_any])
end

copyFile(params[:jdk_pkg]) unless params[:jdk_pkg].nil? or params[:jdk_pkg].empty?

copyFile(params[:aem_jar])
copyFile(params[:dispatcher_mod])

# Make sure vbguest plugin exists
`vagrant plugin install vagrant-vbguest`
if $?.to_i != 0
  puts "Unable to install vbguest plugin, errors may occur with VirtualBox Guest pluings."
end
