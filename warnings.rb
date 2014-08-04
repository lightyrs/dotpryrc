# https://github.com/pry/pry/wiki/FAQ#how-can-i-use-show-method-with-ruby-187
if RUBY_VERSION == '1.8.7'
  safe_require 'ruby18_source_location', "Install this gem to enable Pry's show-method"
  warn 'Ruby 1.8.7 is retired now, please consider upgrade to newer version of Ruby.'
end

# https://github.com/pry/pry/wiki/FAQ#why-doesnt-pry-work-with-ruby-191
if RUBY_VERSION == '1.9.1'
  warn '1.9.1 has known issue with Pry. Please upgrade to 1.9.3-p448 or Ruby 2.0+.'
end
