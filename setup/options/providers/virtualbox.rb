require_relative '../api'

class VirtualBox < Option

  attr_accessor :selected
  attr_accessor :os_options

  def initialize
    @os_options = Array.new
    @os_options << CentOS70.new
    @os_options << CentOS72.new
    @os_options << Debian82.new
    @os_options << Ubuntu14.new
    
  end

  def name
    'VirtualBox'
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
  attr_accessor :platform
  attr_accessor :box
  attr_accessor :box_url


  def populate(hash)
    data = Hash.new
    data[:name] = display_name
    data[:platform] = platform
    data[:box] = box
    data[:box_url] = box_url
    hash[:vagrantbox] = data
    hash[:provider] = 'virtualbox'
  end

end

class CentOS70 < GuestOS

  def initialize
    @display_name = 'CentOS 7.0'
    @platform = 'el-7-x86_64'
    @box = 'puppetlabs/centos-7.0-64-nocm'
  end
end

class CentOS72 < GuestOS

  def initialize
    @display_name = 'CentOS 7.2'
    @platform = 'el-7-x86_64'
    @box = 'puppetlabs/centos-7.2-64-nocm'
  end
end

class Debian82 < GuestOS

  def initialize
    @display_name = 'Debian 8.2'
    @platform = 'debian-8-amd64'
    @box = 'puppetlabs/debian-8.2-64-nocm'
  end
end

class Ubuntu14 < GuestOS

  def initialize
    @display_name = 'Ubuntu 14.04'
    @platform = 'ubuntu-1404-amd64'
    @box = 'puppetlabs/ubuntu-14.04-64-nocm'
  end
end


