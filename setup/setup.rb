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

def writeParams(params = OpenStruct.new, file = PARAMS_FILE)

  File.open(file, FILE_MODES, 0644) do |f|
    f.write("#{params.to_h.to_json}\n")
  end

end

def getParameters(param_file)

  params = readParams(param_file) if param_file

  params = OpenStruct.new unless params

  if params.client.nil?
    print 'Client name: '
    params.client = gets.chomp
  end

  if params.jdkpkg.nil?
    print 'Path to JDK Package (leave blank to use default for OS): '
    params.jdkpkg = gets.chomp
  end

  if params.aemjar.nil?
    print 'Path to AEM installer jar: '
    params.aemjar = gets.chomp
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

copyFile(params[:jdkpkg]) unless params[:jdkpkg].nil? or params[:jdkpkg].empty?

copyFile(params[:aemjar])

