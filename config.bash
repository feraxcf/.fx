#!/bin/bash

# Para probar el script ejecutar en docker: 
# docker run --rm -v ~/.fx:/root/.fx -it fedora:40 bash
# /root/.fx/config.fedora

IS_WIN=false
if command -v winget &>/dev/null; then IS_WIN=true; fi

HAS_DNF=false
if command -v dnf &>/dev/null; then HAS_DNF=true; fi

HAS_APT=false
if command -v apt &>/dev/null; then HAS_APT=true; fi

if "$IS_WIN"; then
    echo "🔥 using winget."
    
elif "$HAS_DNF"; then
    echo "🔥 using dnf."
    
elif "$HAS_APT"; then
    echo "🔥 using apt."
    
else
    echo "💥 Error: the current package manager is not supported."
fi
