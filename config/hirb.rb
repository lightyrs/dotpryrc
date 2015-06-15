# A mini view framework for console/irb that's easy to use,
# even while under its influence. Console goodies include
# a no-wrap table, auto-pager, tree and menu.

# Visit http://tagaholic.me/hirb/ to know more.

if defined? Hirb
  # Slightly dirty hack to fully support
  # in-session Hirb.disable/enable toggling
  # Hirb::View.instance_eval do
  #   def enable_output_method
  #     @output_method = true
  #     @old_print = Pry.config.print

  #     Pry.config.print = proc do |output, value|
  #       Hirb::View.view_or_page_output(value) ||
  #         @old_print.call(output, value)
  #     end
  #   end

  #   def disable_output_method
  #     Pry.config.print = @old_print
  #     @output_method = nil
  #   end
  # end

  Hirb.enable

  Pry::Commands.block_command 'hirb', 'Hirb enable/disable' do |enabled|
    if enabled
      Hirb.enable
    else
      Hirb.disable
    end
  end
end

