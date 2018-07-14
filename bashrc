export PATH="$HOME/bin:$HOME/.rbenv/bin:/opt/homebrew/bin:$PATH"
export EDITOR=vim

eval "$(rbenv init - --no-rehash)"

autoload -Uz compinit && compinit

parse_git_branch() {
  git symbolic-ref --short HEAD 2> /dev/null
}
setopt PROMPT_SUBST
PROMPT='%9c%{%F{green}%} $(parse_git_branch)%{%F{none}%} '

alias ..='cd ..'
alias ls='ls -alFG'

alias v=vim
alias vi=vim

alias vimrc='vim ~/.vimrc'
alias bashrc='vim ~/.bashrc'

alias g=git

alias b='bundle exec'
alias r='bundle exec rails'
alias t='bundle exec rails test'

alias dbreset='r db:environment:set RAILS_ENV=development db:drop db:create db:migrate'
