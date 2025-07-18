# ~/.bashrc

if command -v starship &> /dev/null; then
    export STARSHIP_CONFIG=~/.fx/themes/starship.toml
    eval "$(starship init bash)"

elif command -v oh-my-posh &> /dev/null; then
    eval "$(oh-my-posh init bash --config $HOME'/.fx/themes/ferax.omp.json')"

else
    echo "Oops! It seems Starship or Oh My Posh are not installed or are not accessible in your PATH."
    echo "Your shell prompt might not look as expected. Please install them or check your PATH configuration."

fi
