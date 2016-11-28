class UpdateRuby

  attr_accessor :response

  def prompt
    loop do
      print 'Do you want to update Ruby every time it is provisioned? [Y/n]: '
      opt = gets.chomp
      @response = (opt.empty? or opt.casecmp('y') == 0)
      break if (opt.empty? or opt.casecmp('y') == 0 or opt.casecmp('n') == 0)
    end
  end

  def persist(hash)
    hash[:update_ruby] = @response
  end

end