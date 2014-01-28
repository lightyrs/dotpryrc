module PryrcHelpers
  extend self

  ## Add color to terminal text.
  # \033 is 100% POSIX compatible. Use \e is also fine.
  # http://www.termsys.demon.co.uk/vtansi.htm
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
end

# ==================
# Monkey Patches
# ==================

class Array
  ## Require many gems at once.
  # Input: array of gems' name
  # The side effect is requiring all of them.
  def ___require_gems
    missing = []
    self.each do |e|
      begin
        require e
      rescue LoadError => err
        missing << e
      end
    end
    if !missing.empty?
      puts 'Missing ' + missing.join(' ') + ' goodies :('
    end
  end

  ## Generate a toy of array to play with.
  # Array.toy => [1,2,3,4,5,6,7,8,9,10]
  # Array.toy { |i| i ** 2 }
  # => [0,1,4,9,16,25,36,49,64,81]
  def self.toy(n = 10, &block)
    block_given? ? Array.new(n, &block) : Array.new(n) { |i| i+1 }
  end

end

class Hash

  ### Generate a toy of hash to play with.
  # Hash.toy 3
  # => { 1 => "a", 2 => "b", 3 => "c" }
  def self.toy(n = 10)
    Hash[Array.toy(n).zip(Array.toy(n){ |c| (96+(c+1)).chr })]
  end

end

class Object

  ## Open file with exact location via editor of your choice.
  # Defaults to Sublime Text.
  def subl(method_name, editor='subl')
    file, line = method(method_name).source_location
    `"#{editor}" "#{file}:#{line}"`
  end

  ## Only return the methods not present on basic objects
  def interesting_methods
    (self.methods - Object.instance_methods).sort
  end

  ## Safely require gem with message when a LoadError is signaled.
  def safe_require(gem, msg)
    begin
      require gem
    rescue LoadError
      puts 'No ' + "#{gem}" ' available.'
      puts msg
    end
  end

end

# ==============================
#   Helpers!
# ==============================

## YAML#to_yaml abstraction.
# yaml("language: ruby\nrvm:\n  - 2.0.0\n  - 1.9.3\nscript: rake test\n")
# =>
# --- |
#   language: ruby
#   rvm:
#     - 2.0.0
#     - 1.9.3
#   script: rake test
def yaml(obj)
  puts obj.to_yaml
end

### Benchmark

## Benchmark.measure abstraction.
# puts bm { "a"*1_000_000_000 }
def bm(&block)
  Benchmark.measure &block
end

## Generate Lorem Ipsum String.
def lorem
  "Lorem ipsum dolor sit amet, consectetur adipisicing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum."
end
