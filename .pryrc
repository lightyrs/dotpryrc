require '~/.pryrc-helpers'

# ___ is to Avoid name conflict
___ = PryrcHelpers

___daily_gems  = %w(benchmark yaml json).___require_gems
___pry_gems = %w(
  awesome_print hirb sketches debugger
  byebug pry-byebug pry-stack_explorer
).___require_gems

# https://github.com/pry/pry/wiki/FAQ#how-can-i-use-show-method-with-ruby-187
if RUBY_VERSION == "1.8.7"
  safe_require 'ruby18_source_location', "Install this gem to enable Pry's show-method"
  warn 'Ruby 1.8.7 is retired now, please consider upgrade to newer version of Ruby.'
end

# https://github.com/pry/pry/wiki/FAQ#why-doesnt-pry-work-with-ruby-191
if RUBY_VERSION == "1.9.1"
  warn '1.9.1 has known issue with Pry. Please upgrade to 1.9.3-p448 or Ruby 2.0+.'
end

# ============================
#   hirb
# ============================
# A mini view framework for console/irb that's easy to use, even while under its influence. Console goodies include a no-wrap table, auto-pager, tree and menu.
# Visit http://tagaholic.me/hirb/ to know more.

if defined? Hirb
  # Slightly dirty hack to fully support in-session Hirb.disable/enable toggling
  Hirb::View.instance_eval do
    def enable_output_method
      @output_method = true
      @old_print = Pry.config.print
      Pry.config.print = proc do |output, value|
        Hirb::View.view_or_page_output(value) || @old_print.call(output, value)
      end
    end

    def disable_output_method
      Pry.config.print = @old_print
      @output_method = nil
    end
  end

  Hirb.enable
end

# ==============================
#   Awesome Print
# ==============================
# Pretty print your Ruby objects with style -- in full color and with proper indentation
# http://github.com/michaeldv/awesome_print
if defined? AwesomePrint
  AwesomePrint.pry!
  ## The following line enables awesome_print for all pry output,
  # and enables paging using Pry's pager with awesome_print.
  Pry.config.print = proc { |output, value|
    Pry::Helpers::BaseHelpers.stagger_output("=> #{value.ai(indent: 2)}", output)
  }
  ## If you want awesome_print without automatic pagination, use below:
  # Pry.config.print = proc { |output, value| output.puts value.ai }


  ## Evaluated result display inline
  # Pry.config.print = lambda { |output, value| output.print "\e[1A\e[18C # => "; output.puts value.inspect }

  ## if in bundler, break out, so awesome print doesn't have to be in Gemfile
  if defined? Bundler
    Gem.post_reset_hooks.reject! { |hook| hook.source_location.first =~ %r{/bundler/} }
    Gem::Specification.reset
    #load 'rubygems/custom_require.rb'
  end

  ## awesome_print config for Minitest.
  if defined? Minitest
    module Minitest::Assertions
      def mu_pp(obj)
        obj.awesome_inspect
      end
    end
  end
end

# ==============================
#   Pry Configurations
# ==============================

# History (Use one history file)
Pry.config.history.file = "~/.irb_history"

# Editors
#   available options: vim, mvim, mate, emacsclient...etc.
Pry.config.editor = "vim"

# ==============================
#   Pry Theme
# ==============================
Pry.config.theme = 'solarized'

# ==============================
#   Pry Prompt
# ==============================
# with AWS:
#             AWS@3.0.0 (main)>
# with Rails:
#             3.2.13@2.0.0 (main)>
# Plain Ruby:
#             2.0.0 (main)>
Pry.config.prompt = proc do |obj, level, _|
  prompt = ""
  prompt << "AWS@" if defined?(AWS)
  prompt << "#{Rails.version}@" if defined?(Rails)
  prompt << "#{RUBY_VERSION}"
  "#{prompt} (#{obj})> "
end

# Exception
Pry.config.exception_handler = proc do |output, exception, _|
  puts ___.colorize "#{exception.class}: #{exception.message}", 31
  puts ___.colorize "from #{exception.backtrace.first}", 31
end

if defined?(Hirb)
  Pry::Commands.block_command 'hirb', 'Hirb enable/disable' do |enabled|
    if enabled
      Hirb.enable
    else
      Hirb.disable
    end
  end
end

# ==============================
#   Customized hotkeys for Pry
# ==============================
# Ever get lost in pryland? try w!
Pry.config.commands.alias_command 'w', 'whereami'
# Clear Screen
Pry.config.commands.alias_command '.clr', '.clear'

# ==============================
#   Customized hotkeys for Ruby
# ==============================
# Add more for your convenience
# You may quickly define a variable like r or l in REPL
# Then you lose these aliases, so take care!
alias :r :require
alias :l :load

### Copy to clipboard!

# ==============================
#   pbcopy
# ==============================
# Create command 'pbcopy' : Copy the last returned value in the Mac OS clipboard
# options : -m : Multiline copy
# Usage :
#         a => [1, 2, 3]
#         pbcopy
#         [1, 2, 3]
#         pbcopy -m
#          [
#           1,
#           2,
#           3,
#          ]
if RUBY_PLATFORM =~ /darwin/i # OSX only.
  # The pbcopy manual page for Mac OS X
  # http://goo.gl/o3nGsr
  def pbcopy(str, opts = {})
    IO.popen('pbcopy', 'r+') { |io| io.print str }
  end

  Pry.config.commands.command "pbcopy", "Copy last returned object to clipboard, -m for multiline copy" do
    multiline = arg_string == '-m'
    pbcopy _pry_.last_result.ai(
      :plain => true,
      :indent => 2,
      :index => false,
      :multiline => multiline
    )
    output.puts "Copied #{multiline ? 'multilined' : ''}!"
  end

  Pry.config.commands.alias_command 'cp', 'pbcopy'
end

# ==============================
#   clipit
# ==============================
# Copy to clipboard (If you're not using Mac OSX)
# First, you need to install jist gem
# pry> install-command clipit, you're all set now!
