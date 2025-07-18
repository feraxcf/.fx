#!/bin/bash

# Para probar el script ejecutar en docker: 
# docker run --rm -v ~/.fx:/root/.fx -it fedora:40 bash
# /root/.fx/config.fedora

IS_WIN=false
if [[ "$(uname -s)" == *MINGW* ]]; then
    IS_WIN=true
fi

HAS_DNF=false
if command -v dnf &>/dev/null; then
    HAS_DNF=true
fi

HAS_APT=false
if command -v apt &>/dev/null; then
    HAS_APT=true
fi

echo "$IS_WIN $HAS_APT $HAS_DNF"
