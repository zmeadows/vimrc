command -v vim >/dev/null 2>&1 || { echo "Vim is not installed yet. Aborting." >&2; exit 1; }

echo "############################"
echo "### DOWNLOADING VIMRC... ###"
echo "############################"

wget https://raw.githubusercontent.com/zmeadows/vimrc/master/vimrc -O ~/.vimrc

echo "##########################################"
echo "### DOWNLOADING/CONFIGURING PLUGINS... ###"
echo "##########################################"

curl -fLo ~/.vim/autoload/plug.vim --create-dirs \
    https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim

vim -c PlugInstall

