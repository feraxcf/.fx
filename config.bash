#!/bin/bash

# Para probar el script ejecutar en docker: 
# docker run --rm -v ~/.fx:/root/.fx -it fedora:43 bash
# /root/.fx/config.fedora

echo "adding bash config ..."
bash -c "~/.fx/cfgs/bashrc.bash"
echo ""

echo "adding folder structure ..."
mkdir -p ~/projects/{p,t,j}projects
echo ""

echo "adding git config ..."
~/.fx/cfgs/git.bash
echo ""

echo "checking package manager ..."
HAS_WINGET=false
if command -v winget &>/dev/null; then HAS_WINGET=true; fi

HAS_DNF=false
if command -v dnf &>/dev/null; then HAS_DNF=true; fi

HAS_APT=false
if command -v apt &>/dev/null; then HAS_APT=true; fi

if [[ "$1" == "-n" ]]; then
    echo "♐ Skiping ..."
elif "$HAS_WINGET"; then
    echo "🔥 using winget."
    ~/.fx/cfgs/winget.bash
elif "$HAS_DNF"; then
    echo "🔥 using dnf."
    ~/.fx/cfgs/dnf.bash
elif "$HAS_APT"; then
    echo "🔥 using apt."
    ~/.fx/cfgs/apt.bash
else
    echo "💥 Error: the current package manager is not supported."
fi

echo -e "done.\n"
echo "run the following command to apply the changes:"
echo -e "source ~/.bashrc\n"
echo "or restart the terminal."
