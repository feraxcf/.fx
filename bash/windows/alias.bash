alias sm='powershell.exe -Command "Add-Type -AssemblyName System.Windows.Forms; [System.Windows.Forms.SendKeys]::SendWait('\'^{ESC}\'')"'

pws() { powershell.exe -Command "$@"; }
cmd() { cmd.exe "/C $@"; }