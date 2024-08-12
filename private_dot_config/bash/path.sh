#!/bin/bash

if ! [[ "$PATH" =~ "$HOME/.local/bin:$HOME/bin:" ]]; then
    PATH="$HOME/.local/bin:$HOME/bin:$PATH"
fi

# REZ
export PATH=$PATH:/home/andres.mendez/sandbox/rez/bin/rez

#GOLANG
export PATH=$PATH:/usr/local/go/bin

if [ $(hostname) == "rocky.servet" ]; then
    export PATH=$PATH:/opt/blender/4.1.1/
fi
# Pythonpaths modifications
# export PYTHONPATH=$PYTHONPATH:$HOME/work/tools/studio/stickers/release/maya/scripts
# Maya Module Path modifications
#export MAYA_MODULE_PATH=$MAYA_MODULE_PATH:$HOME/repos/antaruxa/tools/studio/anta_stickers/release/maya
