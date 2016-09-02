require_relative './providers/virtualbox'

class Provider < Option

  attr_accessor :selected

  def initialize
    @providers = Array.new
    @providers << VirtualBox.new
  end

  def prompt

    if @providers.size > 1
      loop do
        puts 'Select which type of Provider to use:'
        @providers.each_with_index do | provider, idx |
          idxp1 = idx + 1
          puts "#{idxp1}. #{provider.name}"
        end
        print 'Selection: '
        opt = gets.chomp
        @selected = @providers[opt.to_i - 1]
        break if opt.to_i > 0
      end
    else
      @selected = VirtualBox.new
    end
    
    @selected.prompt

  end

  def populate(hash)
    @selected.populate(hash)
  end
end