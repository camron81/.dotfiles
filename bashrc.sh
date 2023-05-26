yellow_fg=$(tput setaf 11)
reset=$(tput sgr0)
export PS1='\w${GUIX_ENVIRONMENT:+ [env]} \[${yellow_fg}${reset}\]  '
