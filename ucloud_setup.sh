read -p "Install base requirements from UCloud and reboot? [Y/n]" input

if [ "$input" = "Y" ]; then
    echo "Proceeding..."
    sudo apt update
    sudo apt full-upgrade -y
    sudo apt install nvidia-driver-525 nvidia-utils-525 -y
    sudo reboot
else
  echo "Aborted."
fi


LAZYGIT_VERSION=$(curl -s "https://api.github.com/repos/jesseduffield/lazygit/releases/latest" | grep -Po '"tag_name": "v\K[^"]*')
curl -Lo lazygit.tar.gz "https://github.com/jesseduffield/lazygit/releases/latest/download/lazygit_${LAZYGIT_VERSION}_Linux_x86_64.tar.gz"
tar xf lazygit.tar.gz lazygit
sudo install lazygit /usr/local/bin

if [ ! -d "data" ]; then
    wget https://people.compute.dtu.dk/rapa/cats/MissingDataOpenData.zip
    sudo apt-get install unzip
    unzip MissingDataOpenData
    mv MissingDataOpenData data
    rm -rf MissingDataOpenData.zip
fi

git clone https://github.com/MartinBernstorff/MissingDataChallenge code

git config --global user.email "ryqiem@gmail"
git config --global user.name "Martin Bernstorff"