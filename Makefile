update:
	sudo zypper ref
	sudo zypper up


install-basic:
	sudo zypper install-new-recommends
	sudo zypper in gcc vim zsh make curl wget \
		git neofetch chromium docker rar \
		unrar clang cmake ninja gtk3-devel
	sudo zypper rm vlc
	sudo zypper in vlc vlc-codecs

git-configure:
	git config --global init.defaultBranch main
	git config --global user.name "diego-garro"
	git config --global user.email "diego.garromolina@yahoo.com"
	git config --global alias.s "status -s -b"
	git config --global alias.lg "log --oneline --all --graph"

install-go:
	zypper search go1.1
	echo '-> install the latest stable version'

install-node:
	sudo zypper in nodejs

enable-docker:
	sudo systemctl enable docker
	sudo systemctl start docker
	# Enable Docker to run on OpenSUSE without sudo
	sudo groupadd docker
	sudo gpasswd -a $(USER) docker
	newgrp docker

install-multi:
	sudo zypper install x264 libx264-161 libx264-devel \
		chromium-ffmpeg-extra ffmpeg-4 vlc vlc-codecs \
		h264enc libopenh264-6

ohmyzsh:
	sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"
	echo 'alias python="python3"' >> ~/.zshrc
	echo 'alias py="python3"' >> ~/.zshrc
	echo 'alias c="clear"' >> ~/.zshrc

powerlevel-theme:
	# First install the Meslo Nerd Font
	# https://github.com/romkatv/powerlevel10k#meslo-nerd-font-patched-for-powerlevel10k
	git clone --depth=1 https://github.com/romkatv/powerlevel10k.git ~/powerlevel10k
	echo 'source ~/powerlevel10k/powerlevel10k.zsh-theme' >> ~/.zshrc
	exec zsh
	p10k configure

pyenv:
	sudo zypper install gcc automake bzip2 libbz2-devel xz xz-devel openssl-devel ncurses-devel \
		readline-devel zlib-devel tk-devel libffi-devel sqlite3-devel
	curl https://pyenv.run | zsh
	echo '# pyenv commands' >> ~/.zshrc
	echo 'export PYENV_ROOT="$HOME/.pyenv"' >> ~/.zshrc
	echo 'command -v pyenv >/dev/null || export PATH="$PYENV_ROOT/bin:$PATH"' >> ~/.zshrc
	echo 'eval "$(pyenv init -)"' >> ~/.zshrc
	echo 'eval "$(pyenv virtualenv-init -)"' >> ~/.zshrc
	source ~/.zshrc

poetry:
	curl -sSL https://raw.githubusercontent.com/python-poetry/poetry/master/get-poetry.py | python3 -
	source $HOME/.poetry/env

py-libs:
	sudo zypper in python3-pip
	sudo pip install numpy pandas matplotlib pipenv ipython jupyter notebook jupyterlab

install-v:
	cd
	git clone https://github.com/vlang/v
	cd v
	make
	sudo ln -sf ~/v/v /usr/local/bin/v
	# Download VLS and put it in the v installation directory
	# https://github.com/vlang/vls/releases/tag/latest

install-vscode:
	sudo rpm --import https://packages.microsoft.com/keys/microsoft.asc
	sudo sh -c 'echo -e "[code]\nname=Visual Studio Code\nbaseurl=https://packages.microsoft.com/yumrepos/vscode\nenabled=1\ntype=rpm-md\ngpgcheck=1\ngpgkey=https://packages.microsoft.com/keys/microsoft.asc" > /etc/zypp/repos.d/vscode.repo'
	sudo zypper refresh
	sudo zypper install code

change-hostname:
	echo 'Open /etc/hostname and change the name by yours'
	echo '$ sudo vim /etc/hostname'
	echo 'Open /etc/hosts and change any ocurrence of the computer name'
	echo 'with yours'

