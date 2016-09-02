require_relative '../api'

class Cpus < Option

  attr_accessor :cpus

  def prompt
    loop do
      print 'Enter the number of CPUs for the guest: '
      opt = gets.chomp
      @cpus = opt.to_i
      break if @cpus > 0
    end

  end

  def persist(hash)
    hash[:vm_cpus] = @cpus
  end
end