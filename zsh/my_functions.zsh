ff() {
  if [[ -d $1 ]]; then
    cd $1
  else
    nvim $1
  fi
}

fp() {
  cd $(fd -H --no-ignore-vcs -t d '.git$' ~/code | sed 's/.\{5\}$//' | fzf --height 40% --reverse)
}
