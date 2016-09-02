require_relative 'api'
require_relative 'vmcfgs/cpus'
require_relative 'vmcfgs/memory'

class VMConfig < Option


  def initialize
    @cfgs = Array.new
    @cfgs << Cpus.new
    @cfgs << Memory.new
  end

  def prompt

    @cfgs.each do | config |
      config.prompt
    end

  end

  def populate(hash)
    vm_config = Hash.new
    @cfgs.each do | config |
      config.persist(vm_config)
    end
    hash[:vm_config] = vm_config
  end
end