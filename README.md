## New machine setup
Clone this repo: 
  `git clone git@github.com:yotamazriel/dotfiles.git ~/.dotfiles`.

Install homebrew: 
  `ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"`.

Install applications: 
  `~/.dotfiles/setup/apps.sh`.

Install developer tools: 
  `~/.dotfiles/setup/devtools.sh`.

Create symlinks: 
  `~/.dotfiles/setup/symlinks.sh`.

Configure osx: 
  `~/.dotfiles/setup/osx_settings.sh`


### Don't forget
Generate an ssh key for github: `~/.dotfiles/setup/generate_ssh_key.sh {email}` then paste [here](https://github.com/settings/keys) the public key already in the clipboard.
Install latest node: `nvm install 12`.
Install latest python: `pyenv install 3.8.2 & pyenv global 3.8.2`

