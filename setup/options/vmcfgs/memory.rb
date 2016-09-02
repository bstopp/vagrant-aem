require_relative '../api'

class Memory < Option

  attr_accessor :memory

  def prompt
    loop do
      print 'Enter the amount of memory (MB) for the guest: '
      opt = gets.chomp
      @memory = opt.to_i
      break if @memory > 0
    end

  end

  def persist(hash)
    hash[:vm_memory] = @memory
  end
end