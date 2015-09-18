#!/usr/bin/env ruby

require 'erb'
require 'fileutils'

PROJECT_ROOT = File.expand_path(File.join(File.dirname(__FILE__), '..'))


def writeVagrantfile
  filename = 'Vagrantfile'
  template = File.read(File.join(PROJECT_ROOT, 'setup', 'templates', "#{filename}.erb"))
  renderer = ERB.new(template)
  ofile = File.new(File.join(PROJECT_ROOT, filename), File::CREAT | File::TRUNC | File::WRONLY)
  ofile.write(renderer.result())
  ofile.close
end

def writeScriptProvisioner
  filename = 'update-vm.sh'
  template = File.read(File.join(PROJECT_ROOT, 'setup', 'templates', "#{filename}.erb"))
  renderer = ERB.new(template)
  ofile = File.new(File.join(PROJECT_ROOT, 'setup', filename), File::CREAT | File::TRUNC | File::WRONLY, 0755)
  ofile.write(renderer.result())
  ofile.close
end

def copyFile(file)
  FileUtils.cp(file, File.join(PROJECT_ROOT, 'puppet', 'files'))
end

puts ''
print 'Client name: ' 
@client = gets.chomp

print 'Path to JDK Package (leave blank to use default for OS): '
jdkpkg = gets.chomp 

print 'Path to AEM installer jar: '
aemjar = gets.chomp

writeVagrantfile
writeScriptProvisioner


copyFile(jdkpkg) unless jdkpkg.empty?

copyFile(aemjar)

