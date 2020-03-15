# oh-my-zsh
sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"

# zsh-syntax-highlighting
git clone https://github.com/zsh-users/zsh-syntax-highlighting.git ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-syntax-highlighting

# autojump
if [[ "$OSTYPE" == "linux-gnu" ]]; then
    sudo apt install autojump
elif [[ "$OSTYPE" == "darwin"* ]]; then
    brew install autojump
