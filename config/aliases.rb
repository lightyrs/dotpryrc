alias :r :require
alias :l :load

Pry.commands.alias_command '..', 'cd ..'
Pry.commands.alias_command '...', 'cd ../..'
Pry.commands.alias_command '....', 'cd ../../..'

Pry.commands.alias_command 'ed', 'edit'
Pry.commands.alias_command 'em', 'edit -m'
Pry.commands.alias_command 'ec', 'edit -c'

Pry.commands.alias_command 'la', 'ls -ppp'
Pry.commands.alias_command 'll', 'ls -M'

Pry.commands.alias_command 'rm', 'reload-method'
Pry.commands.alias_command 'ss', 'show-source'
Pry.commands.alias_command 'fm', 'find-method'
Pry.commands.alias_command 'bt', 'pry-backtrace'

Pry.commands.alias_command 'e', 'exit!'
