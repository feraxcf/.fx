# ~/.bashrc
if command -v starship &> /dev/null; then
    export STARSHIP_CONFIG=~/.fx/ship/starship.toml
    eval "$(starship init bash)"
elif command -v oh-my-posh &> /dev/null; then
    eval "$(oh-my-posh init bash --config $HOME'/.fx/themes/ferax.omp.json')"
else
    echo "starship / oh-my-posh are not instaled or are not in your PATH"
fi
