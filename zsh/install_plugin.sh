# zsh
case "$(uname -s)" in
   Darwin)
     brew install -y zsh
     ;;

   Linux)
     sudo apt install -y zsh
     ;;

    *)
     echo 'Other OS'
     ;;
esac

# oh-my-zsh
sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"

# power level 10k
git clone --depth=1 https://github.com/romkatv/powerlevel10k.git $ZSH_CUSTOM/themes/powerlevel10k

# zsh-syntax-highlighting
git clone https://github.com/zsh-users/zsh-syntax-highlighting.git ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-syntax-highlighting

cp ./.zshrc $HOME/.zshrc
cp ./.p10k.zsh $HOME/.p10k.zsh
