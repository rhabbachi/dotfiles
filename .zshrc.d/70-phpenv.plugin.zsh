# Sourced from https://github.com/robbyrussell/oh-my-zsh/blob/master/plugins/composer/composer.plugin.zsh

# Composer basic command completion
_composer_get_command_list() {
  $_comp_command1 --no-ansi 2>/dev/null | sed "1,/Available commands/d" | awk '/^[ \t]*[a-z]+/ { print $1 }'
}

_composer_get_required_list() {
  $_comp_command1 show -s --no-ansi 2>/dev/null | sed '1,/requires/d' | awk 'NF > 0 && !/^requires \(dev\)/{ print $1 }'
}

_composer() {
  local curcontext="$curcontext" state line
  typeset -A opt_args
  _arguments \
    '1: :->command' \
    '*: :->args'

  case $state in
  command)
    compadd $(_composer_get_command_list)
    ;;
  *)
    compadd $(_composer_get_required_list)
    ;;
  esac
}

compdef _composer composer
compdef _composer composer.phar

# https://github.com/phpenv/phpenv#installation
export PATH="$HOME/.phpenv/bin:$PATH"
eval "$(phpenv init -)"

alias drupalcs="phpcs --standard=Drupal --extensions='php,module,inc,install,test,profile,theme,css,info,txt,md'"
alias drupalcsp="phpcs --standard=DrupalPractice --extensions='php,module,inc,install,test,profile,theme,css,info,txt,md'"
alias drupalcbf="phpcbf --standard=Drupal --extensions='php,module,inc,install,test,profile,theme,css,info,txt,md'"

# CGR
export CGR_BASE_DIR="$(phpenv prefix)/composer/global"
export CGR_BIN_DIR="$(phpenv prefix)/composer/vendor/bin"
