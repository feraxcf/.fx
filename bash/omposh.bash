
omp() {
    eval "$(oh-my-posh init bash --config $HOME'/.fx/themes/ferax.omp.json')"
}

if command -v oh-my-posh &> /dev/null; then
    omp
else
    echo "oh-my-posh is not instaled or is not in your PATH"
fi
