#!/bin/bash
export PATH=$PATH:~/bin
source $(which virtualenvwrapper.sh)

# Let's always run inside of a virtualenv
if [ ! -d ~/.virtualenvs/worker ]; then
    mkvirtualenv worker
fi
workon worker

# Start the X server
Xvfb :0 -nolisten tcp -screen 0 1600x1200x24 \
       > ~/artifacts/public/xvfb.log 2>&1 &

$@
