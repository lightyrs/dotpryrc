# Create command 'pbcopy' :
# Copy the last returned value in the Mac OS clipboard

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
