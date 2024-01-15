#!/bin/bash

usage() {
	echo "Usage: jupy_convert.sh [FILE]"
	echo "Convert .ipynb FILE to .sync.py"
	exit 2
}

[[ "$1" != *.ipynb ]] && usage

# Grab filename and rename it
file=$(basename $1 .ipynb)
mv $1 $file.sync.ipynb

# Convert .ipynb to .sync.py
jupyter nbconvert $file.sync.ipynb --to python
perl -0777 -pi -e 's/In\[.\]:\n\n/%%/g' $file.sync.py

# Sync with notebook
python -m jupyter_ascending.requests.sync --filename $file.sync.ipynb

