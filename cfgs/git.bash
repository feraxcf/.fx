echo -e "[user]\n	email = feraxhp+gh@gmail.com\n	name = feraxhp" >> ~/.gitconfig

if command -v msedit >/dev/null 2>&1; then
    echo -e "[core]\n	editor = msedit" >> ~/.gitconfig
elif command -v edit >/dev/null 2>&1; then
    echo -e "[core]\n	editor = edit" >> ~/.gitconfig
fi

echo -e "[init]\n	defaultBranch = main" >> ~/.gitconfig