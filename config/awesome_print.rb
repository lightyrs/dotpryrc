# Pretty print your Ruby objects with style -
# in full color and with proper indentation

# http://github.com/michaeldv/awesome_print

if defined? AwesomePrint
  AwesomePrint.pry!
  # The following line enables awesome_print for all pry output,
  # and enables paging using Pry's pager with awesome_print.
  Pry.config.print = proc do |output, value|
    Pry::Helpers::BaseHelpers.stagger_output("=> #{value.ai(indent: 2)}", output)
  end

  # If you want awesome_print without automatic pagination, use below:
  # Pry.config.print = proc { |output, value| output.puts value.ai }

  # Evaluated result display inline
  # Pry.config.print = lambda { |output, value| output.print "\e[1A\e[18C # => "; output.puts value.inspect }

  # if in bundler, break out, so awesome print doesn't have to be in Gemfile
  if defined? Bundler
    Gem.post_reset_hooks.reject! do |hook|
      hook.source_location.first =~ %r{/bundler/}
    end
    Gem::Specification.reset
    #load 'rubygems/custom_require.rb'
  end

  # awesome_print config for Minitest.
  if defined? Minitest
    module Minitest::Assertions
      def mu_pp(obj)
        obj.awesome_inspect
      end
    end
  end
end

