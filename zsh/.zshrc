export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && . "$NVM_DIR/nvm.sh"  # This loads nvm
if which pyenv > /dev/null; then eval "$(pyenv init -)"; fi
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
export LC_ALL=en_US.UTF-8
export LANG=en_US.UTF-8

export VISUAL=nvim
export EDITOR="$VISUAL"

export PATH="$HOME/.poetry/bin:$PATH"

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
  fi
}

gctx() {
  gcloud config set project $(gcloud projects list --format=json | jq -r  '.[].projectId' | fzf)
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

