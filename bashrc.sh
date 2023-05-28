yellow_fg=$(tput setaf 11)
reset=$(tput sgr0)

export PS1='\w${GUIX_ENVIRONMENT:+ [guix]} \[${yellow_fg}${reset}\]  '

eval "$(direnv hook bash)"
