
module VagrantAem
  class BoxName < VagrantAem::Option

    priority = 1

    def options(optparse)
      optparse.on('-nNAME', '--name=NAME', 'Specify the name (ie .hostname) of this VM.') do |n|
        @name = n;
      end
    end

    def prompt
      print 'Enter the unique name (hostname) of this virtual machine: '
      @name = gets.chomp
    end

    def populate(hash)
      hash[:name] = @name
    end
  end
end
