Pry.config.exception_handler = proc do |output, exception, _|
  puts PryrcHelpers.colorize "#{exception.class}: #{exception.message}", 31
  puts PryrcHelpers.colorize "from #{exception.backtrace.first}", 31
end
