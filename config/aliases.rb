alias :r :require
alias :l :load

Pry.config.commands.alias_command '..', 'cd ..'
Pry.config.commands.alias_command '...', 'cd ../..'
Pry.config.commands.alias_command '....', 'cd ../../..'

Pry.config.commands.alias_command 'ed', 'edit'
Pry.config.commands.alias_command 'em', 'edit -m'
Pry.config.commands.alias_command 'ec', 'edit -c'

Pry.config.commands.alias_command 'la', 'ls -ppp'
Pry.config.commands.alias_command 'll', 'ls -M'

Pry.config.commands.alias_command 'rm', 'reload-method'
Pry.config.commands.alias_command 'ss', 'show-source'
Pry.config.commands.alias_command 'fm', 'find-method'
Pry.config.commands.alias_command 'bt', 'pry-backtrace'
