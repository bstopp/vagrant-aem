require_relative 'options/api'
require_relative 'options/name'
require_relative 'options/provider'
require_relative 'options/vmconfig'
require_relative 'options/updatevm'
require_relative 'options/updateruby'



class ConfigOptions < Option

  attr_accessor :option_list

  def initialize
    @option_list = Array.new
    @option_list << BoxName.new
    @option_list << Provider.new
    @option_list << VMConfig.new
  end

  def confirm(store)

    if (store.length > 0 ) 
      print "Configurations found, do you want to review? [y/N]: "
      response = gets.chomp
      if (respnse.casecmp('y') == 0)
        @option_list.each do | opt |
          opt.confirm(store)
        end
      end
    end
  end

  def prompt
    @option_list.each do | opt |
      opt.prompt
    end
  end

  def populate(store)
    @option_list.each do | option |
      option.populate(store)
    end
  end

end

