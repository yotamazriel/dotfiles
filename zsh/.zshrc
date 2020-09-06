export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && . "$NVM_DIR/nvm.sh"  # This loads nvm

# The next line updates PATH for the Google Cloud SDK.
if [ -f '/Users/yotamazriel/google-cloud-sdk/path.zsh.inc' ]; then . '/Users/yotamazriel/google-cloud-sdk/path.zsh.inc'; fi

# The next line enables shell command completion for gcloud.
if [ -f '/Users/yotamazriel/google-cloud-sdk/completion.zsh.inc' ]; then . '/Users/yotamazriel/google-cloud-sdk/completion.zsh.inc'; fi

source <(kubectl completion zsh)
# Arik stuff 
source /usr/local/share/antigen/antigen.zsh
export DEFAULT_USER=yotamazriel # for agnoster theme
antigen use oh-my-zsh
antigen theme agnoster
antigen bundles <<EOBUNDLES
  git
  z
  osx
  zsh-users/zsh-syntax-highlighting
  docker
  terraform
EOBUNDLES
antigen apply
[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh

autoload -U +X bashcompinit && bashcompinit
complete -o nospace -C /usr/local/bin/terraform terraform

RPROMPT=$'%{$fg[white]%}$(tf_prompt_info)%{$reset_color%}'

