function mycolordiff() {
  colordiff $@ | less -R
}

alias diff=mycolordiff