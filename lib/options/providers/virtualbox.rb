require_relative '../api'

class VirtualBox < VagrantAem::Option

  priority = 1

  attr_accessor :selected
  attr_accessor :os_options

  def initialize
    @os_options = Array.new
    @os_options << CentOS72.new
    @os_options << Debian7.new
    @os_options << Debian8.new
    @os_options << Ubuntu14.new
    @os_options << Ubuntu16.new

  end

  def name
    'VirtualBox'
  end

  def parse(opts)
    @os_options.each do | os |
      @selected = os if os.match?(opts)
    end
  end

  def prompt

    loop do
      puts 'Select the Guest OS to use:'
      @os_options.each_with_index do | os, idx |
        idxp1 = idx + 1
        puts "#{idxp1}. #{os.display_name}"
      end
      print 'Selection: '
      opt = gets.chomp
      @selected = @os_options[opt.to_i - 1]
      break if opt.to_i > 0
    end

  end

  def populate(hash)
    @selected.populate(hash)
  end

end

class GuestOS

  attr_accessor :display_name
  attr_accessor :box

  def match(opts)

  end

  def populate(hash)
    data = Hash.new
    data[:name] = display_name
    data[:box] = box
    hash[:vagrantbox] = data
    hash[:provider] = 'virtualbox'
  end

end

class CentOS72 < GuestOS

  def initialize
    @display_name = 'CentOS 7.2'
    @box = 'bstopp/centos-7.2-x64'
  end
end

class Debian7 < GuestOS

  def initialize
    @display_name = 'Debian 7'
    @box = 'bstopp/debian-7-x64'
  end
end

class Debian8 < GuestOS
  def initialize
    @display_name = 'Debian 8'
    @box = 'bstopp/debian-8-x64'
  end
end

class Ubuntu14 < GuestOS

  def initialize
    @display_name = 'Ubuntu 14 LTS'
    @box = 'bstopp/ubuntu-14-x64'
  end
end

class Ubuntu16 < GuestOS

  def initialize
    @display_name = 'Ubuntu 16 LTS'
    @box = 'bstopp/ubuntu-16-x64'
  end
end
