# install fonts for iterm
echo "Installing fonts for iterm"
git clone https://github.com/powerline/fonts.git --depth=1
cd fonts
./install.sh
cd ..
rm -rf fonts

# install iterm
ITERM_SYNC_DIR="${HOME}/repos/dotfiles/iterm"
brew install iterm2 --cask
defaults write com.googlecode.iterm2 LoadPrefsFromCustomFolder -bool TRUE
defaults write com.googlecode.iterm2 PrefsCustomFolder $ITERM_SYNC_DIR

brew install google-chrome --cask
brew install java --cask
brew install whatsapp --cask
brew install slack --cask
brew install visual-studio-code --cask
brew install zoom --cask
brew install karabiner-elements --cask
