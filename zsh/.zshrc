export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && . "$NVM_DIR/nvm.sh"  # This loads nvm
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"
if which pyenv > /dev/null; then eval "$(pyenv init -)"; fi
# The next line updates PATH for the Google Cloud SDK.
if [ -f '/Users/yotamazriel/google-cloud-sdk/path.zsh.inc' ]; then . '/Users/yotamazriel/google-cloud-sdk/path.zsh.inc'; fi

# The next line enables shell command completion for gcloud.
if [ -f '/Users/yotamazriel/google-cloud-sdk/completion.zsh.inc' ]; then . '/Users/yotamazriel/google-cloud-sdk/completion.zsh.inc'; fi
$(brew --prefix)/etc/profile.d/z.sh

source <(kubectl completion zsh)
ZSH_THEME="robbyrussell"
ZSH_THEME="agnoster"
## Load Antigen
source "$HOME/repos/dotfiles/zsh/antigen.zsh"
# Load Antigen configurations
antigen init ~/.antigenrc

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
export LC_ALL=en_US.UTF-8
export LANG=en_US.UTF-8

export VISUAL=nvim
export EDITOR="$VISUAL"

export PATH="$HOME/.poetry/bin:$PATH"

# aws
autoload bashcompinit && bashcompinit
autoload -Uz compinit && compinit
complete -C '/usr/local/bin/aws_completer' aws

# Add leatherman
source ~/repos/leatherman/source-me.sh
#  pyenv
export PYENV_ROOT="$HOME/.pyenv"
export PATH="$PYENV_ROOT/bin:$PATH"
eval "$(pyenv init --path)"
eval "$(pyenv init -)"

# global pkg
export PATH="/opt/homebrew/bin:/Users/YOUR_USER_NAME/Library/Python/3.9/bin:/usr/local/bin:/usr/bin:/bin:/usr/sbin:/sbin:/Library/Apple/usr/bin:$PATH"
export SDKROOT="/Applications/Xcode.app/Contents/Developer/Platforms/MacOSX.platform/Developer/SDKs/MacOSX.sdk"

# pyenv
export PATH="$HOME/.pyenv/bin:$PATH"
if command -v pyenv 1>/dev/null 2>&1; then
  eval "$(pyenv init -)"
fi

# python3 Alias
alias python="python3"

# pipx
export PATH="~/.local/bin:$PATH"
### Add these next lines to protect your system python from
### pollution from 3rd-party packages

# pip should only run if there is a virtualenv currently activated
export PIP_REQUIRE_VIRTUALENV=true
 
# commands to override pip restriction above.
# use `gpip` or `gpip3` to force installation of
# a package in the global python environment
# Never do this! It is just an escape hatch.
gpip(){
   PIP_REQUIRE_VIRTUALENV="" pip "$@"
}
gpip3(){
   PIP_REQUIRE_VIRTUALENV="" pip3 "$@"
}

f3() {
  if [[ "$1" == '' ]]; then
    gcs_path=$(gsutil ls $1 | fzf --tac)
  else
    gcs_path=$((echo '..' && gsutil ls $1) | fzf --tac)
  fi
  if [[ "$gcs_path" == '..' ]]; then
    gcs_path=$(dirname $1)/
  fi
  if [[ "$gcs_path" == 'gs:/' ]]; then
    f3
  elif [[ "$gcs_path" =~ '^.*/$' ]]; then
    f3 $gcs_path
  elif [[ "$gcs_path" != '' ]]; then
    gsutil cp $gcs_path -
    #echo $gcs_path
  fi
}

gctx() {
  gcloud config set project $(gcloud projects list --format=json | jq -r  '.[].projectId' | fzf)
}

gpick() {
  rev=$1
  branch=$(git branch | fzf --reverse --height=10 | cut -d ' ' -f 1)

  if [[ -z $rev ]]; then
    rev=$(git log $branch --oneline | fzf --reverse --height=10 | cut -d ' ' -f 1)
  fi

  if [[ -z $rev ]]; then
    return 0
  fi

  git commit --fixup $rev

  CHANGED=$(git diff-index --name-only HEAD --)
  if [[ -n $CHANGED ]]; then
    git stash push
  fi

  git cherry-pick $rev^

  if [[ -n $CHANGED ]]; then
    git stash pop
  fi
}

gfix() {
  rev=$1

  if [[ -z $rev ]]; then
    rev=$(git log --oneline | fzf --reverse --height=10 | cut -d ' ' -f 1)
  fi

  if [[ -z $rev ]]; then
    return 0
  fi

  git commit --fixup $rev

  CHANGED=$(git diff-index --name-only HEAD --)
  if [[ -n $CHANGED ]]; then
    git stash push
  fi

  git rebase --autostash -i $rev^

  if [[ -n $CHANGED ]]; then
    git stash pop
  fi
}

wfw() {
  context='gke_tensorleap-ops3_us-central1-c_ops-cluster'
  workflow=$1
  if [[ -z $workflow ]]; then
    workflow=$(argo list --running --context $context | tail -n +2 | fzf --reverse --height=10 | cut -f 1 -d " ")
  fi
  if [ $workflow = "all" ]; then
    workflow=$(argo list --context $context | tail -n +2 | fzf --reverse --height=10 | cut -f 1 -d " ")
  fi
  argo watch --context $context $workflow
}

wfl() {
  context='gke_tensorleap-ops3_us-central1-c_ops-cluster'
  workflow=$1
  if [[ -z $workflow ]]; then
    workflow=$(argo list --running --context $context | tail -n +2 | fzf --reverse --height=10 | cut -f 1 -d " ")
  fi
  if [ $workflow = "all" ]; then
    workflow=$(argo list --context $context | tail -n +2 | fzf --reverse --height=10 | cut -f 1 -d " ")
  fi
  argo logs --context $context $workflow -f
}

