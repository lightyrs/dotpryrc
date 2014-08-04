class Array
  def self.toy(n = 10, &block)
    block_given? ? Array.new(n, &block) : Array.new(n) { |i| i + 1 }
  end
end

class Hash
  def self.toy(n = 10)
    Hash[Array.toy(n).zip(Array.toy(n) { |c| (96 + (c + 1)).chr })]
  end
end

class Object
  # Only return the methods not present on basic objects.
  def interesting_methods
    (self.methods - Object.instance_methods).sort
  end

  # Safely require gem with message when a LoadError is signaled.
  def safe_require(gem, msg)
    begin
      require gem
    rescue LoadError
      puts 'No ' + "#{gem}" ' available.'
      puts msg
    end
  end
end
