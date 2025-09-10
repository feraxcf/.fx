sudo apt update && sudo apt install -y \
zip \
unzip \
btop \
bat \
gpg

# Install starship
echo "🚀 Installing starship"
curl -sS https://starship.rs/install.sh | sh

# Install eza
sudo mkdir -p /etc/apt/keyrings
wget -qO- https://raw.githubusercontent.com/eza-community/eza/main/deb.asc | sudo gpg --dearmor -o /etc/apt/keyrings/gierens.gpg
echo "deb [signed-by=/etc/apt/keyrings/gierens.gpg] http://deb.gierens.de stable main" | sudo tee /etc/apt/sources.list.d/gierens.list
sudo chmod 644 /etc/apt/keyrings/gierens.gpg /etc/apt/sources.list.d/gierens.list
sudo apt update
sudo apt install -y eza


if ! command -v cargo &> /dev/null; then
    sudo apt install -y rust-all
fi

echo "-> Installing grp"
version_name=$(curl -s "https://api.github.com/repos/feraxhp/grp/releases/latest" | jq -r '.name')
nversion=$(echo "$version_name" | cut -d'v' -f2)

wget "https://github.com/feraxhp/grp/releases/download/$version_name/grp-${nversion}-1_amd64.deb"
sudo dpkg -i "grp-${nversion}-1_amd64.deb"
sudo apt-get install -f

echo "-> Installing cim"
version_name=$(curl -s "https://api.github.com/repos/feraxhp/cim/releases/latest" | jq -r '.name')
nversion=$(echo "$version_name" | cut -d'v' -f2)

wget "https://github.com/feraxhp/cim/releases/download/$version_name/cim-${nversion}-1_amd64.deb"
sudo dpkg -i "cim-${nversion}-1_amd64.deb"
sudo apt-get install -f