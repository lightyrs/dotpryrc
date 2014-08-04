%w(utils helpers patches warnings pbcopy).each { |f| require_relative f }

PryrcUtils.require_gems(%w(benchmark yaml json))
PryrcUtils.require_gems(%w(
  awesome_print hirb hirb-unicode sketches pry-byebug
  pry-doc pry-coolline pry-remote pry-git
  pry-theme coolline coderay
))

%w(
  base hirb awesome_print prompt
  exception hotkeys aliases
).each { |f| require_relative File.join('config', f) }
