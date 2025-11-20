sudo dnf install -y \
zip \
btop \
eza \
bat \
jq

echo "-> Installing starship"
curl -sS https://starship.rs/install.sh | sh

# Install cargo if not available for additional tools
if ! command -v cargo &> /dev/null; then
    sudo dnf install -y rust cargo
fi

echo "-> Installing grp"
version_name=$(curl -s "https://api.github.com/repos/feraxhp/grp/releases/latest" | jq -r '.name')
nversion=$(echo "$version_name" | cut -d'v' -f2)

sudo dnf install -y "https://github.com/feraxhp/grp/releases/download/$version_name/grp-$nversion-1.x86_64.rpm"


echo "-> Installing cim"
version_name=$(curl -s "https://api.github.com/repos/feraxhp/cim/releases/latest" | jq -r '.name')
nversion=$(echo "$version_name" | cut -d'v' -f2)

sudo dnf install -y "https://github.com/feraxhp/cim/releases/download/$version_name/cim-$nversion-1.x86_64.rpm"
