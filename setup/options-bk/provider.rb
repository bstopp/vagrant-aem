require_relative 'api'
require File.dirname(File.absolute_path(__FILE__)) + '/providers/virtualbox.rb'

module VagrantAem
  class Provider < VagrantAem::Option

    priority = 10

    attr_accessor :selected

    def initialize
      @selected = VirtualBox.new
    end

    def parse(opts)
      @selected.parse(opts)
    end

    def prompt
      @selected.prompt
    end

  end
end