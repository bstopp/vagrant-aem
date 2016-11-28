require_relative 'api'

class BoxName < Option

  def prompt
    print 'Enter the unique name (hostname) of this virtual machine: '
    @name = gets.chomp
  end

  def populate(hash)
    hash[:name] = @name
  end
end