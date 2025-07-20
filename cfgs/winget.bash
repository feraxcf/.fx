
winget install  \
Starship.Starship \
glzr-io.glazewm \
glzr-io.zebar   \
Seafile.Seafile \
feraxhp.grp     \
feraxhp.cim     \
GnuWin32.Zip    \
aristocratos.btop4win \
eza-community.eza \
sharkdp.bat

shell="/c/Apps/Shell"
wshell="c:\\Apps\\Shell"
mkdir -p $shell

echo "\"C:\Program Files (x86)\GnuWin32\bin\zip.exe\" \"$@\"" >> "$shell/zip" 

echo -e "\e[31m>> \e[32mAdd \e[0;3m$wshell \e[0;32mto your PATH environment variable\e[0m"
