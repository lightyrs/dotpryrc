Pry.config.exception_handler = proc do |output, exception, _|
  puts PryrcUtils.colorize "#{exception.class}: #{exception.message}", 31
  puts PryrcUtils.colorize "from #{exception.backtrace.first}", 31
end
