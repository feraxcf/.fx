
echo "Installing Zed"

if command -v zed &> /dev/null; then
    echo "Zed is already installed"
    exit
fi

#Comprobar dependencias ['git', 'curl', 'which']
if ! command -v git &> /dev/null; then
    echo "git is not installed, please install it"
    exit
fi

if ! command -v curl &> /dev/null; then
    echo "curl is not installed, please install it"
    exit
fi

if ! command -v which &> /dev/null; then
    echo "which is not installed, please install it"
    exit
fi

echo "Downloading Zed"
cd ~
curl https://zed.dev/install.sh | sh

echo "Downloading zed configuration"
mkdir -p ~/.config
cd ~/.config
rm -rf zed
git clone https://github.com/feraxhp/zed

echo "Zed installed"
