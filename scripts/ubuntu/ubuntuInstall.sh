sudo cp /etc/apt/sources.list /etc/apt/sources_init.list
sudo cp sources.list /etc/apt/sources.list
sudo apt-get update
sudo apt install vim git zsh curl
sh -c "$(curl -fsSL https://raw.github.com/robbyrussell/oh-my-zsh/master/tools/install.sh)"
