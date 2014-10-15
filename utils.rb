module PryrcUtils
  extend self

  # Add color to terminal text.
  #
  # \033 is 100% POSIX compatible. Use \e is also fine.
  # http://www.termsys.demon.co.uk/vtansi.htm
  #
  # Foreground Colours
  #   30  Black
  #   31  Red
  #   32  Green
  #   33  Yellow
  #   34  Blue
  #   35  Magenta
  #   36  Cyan
  #   37  White
  def colorize(text, color_code)
    "\033[#{color_code}m#{text}\033[0m"
  end

  # Require many gems at once.
  def require_gems(gems)
    missing = []
    gems.each do |gem|
      begin
        require gem
      rescue LoadError
        missing << gem
      end
    end
    puts 'Missing ' + missing.join(' ') + ' gems' unless missing.empty?
  end
end
