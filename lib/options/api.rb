
module VagrantAem
  class Option

    priority = -1

    # Specify command line options.
    def options(optparse)
      raise 'Specify command line options method not implemented.'
    end

    # Populate from YAML data
    def parse(data)
      raise 'Parse data method not implemented.'
    end

    # Confirm selected value
    def confirm
      raise 'Confirm method not implemented.'
    end

    # Prompt for selection
    def prompt
      raise 'Prompt method not implemented.'
    end

    # Populate data for YAML persistence
    def populate(store)
      raise 'Populate method not implemented.'
    end
  end
end

