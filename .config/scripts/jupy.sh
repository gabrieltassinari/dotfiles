#!/bin/bash
#
# Dependencies: 
# Bash, perl and python
#

NAME=$(basename $0)
VERSION=v0.2

usage() {
	cat << EOF
Usage: $(basename $0) [OPTION] [FILE]

Arguments supported.
  -h, --help                Show helps and exit
  -v, --version             Show the version of the script
  -n, --new-file FILE       Create a '.sync.ipynb' file
  -i, --install             Install jupyter notebook/ascending
  -o, --open FILE           Open a '.sync.ipynb' file in a notebook
  -c, --convert FILE        Convert .ipynb FILE to .sync.py

Note: Some options are only supported in a virtual environment.
EOF
exit 2
}

install() {
	if [[ -z $(pip list | grep jupyter) ]]; then
		pip install notebook jupyter_ascending

		python -m jupyter nbextension    install jupyter_ascending --sys-prefix --py
		python -m jupyter nbextension     enable jupyter_ascending --sys-prefix --py
		python -m jupyter serverextension enable jupyter_ascending --sys-prefix --py
	fi
}

new_file() {
	[[ -z $1 ]] && usage
	[[ -f "$1.sync.ipynb" ]] && echo "$NAME: file '$1' already exists." && exit 2

	python -m jupyter_ascending.scripts.make_pair --base $1
}

open_notebook() {
	[[ $1 != *.sync.ipynb ]] && echo "$NAME: file '$1' doesn't have '.sync.ipynb' extension." && exit 2
	jupyter notebook $1 &>/dev/null &
}

convert() {
	[[ $1 != *.ipynb ]] && echo "$NAME: file '$1' doesn't have '.ipynb' extension." && exit 2

	file=$(basename $1 .ipynb)
	mv $1 $file.sync.ipynb

	jupyter nbconvert $file.sync.ipynb --to python
	perl -0777 -pi -e 's/In\[.\]:\n\n/%%/g' $file.sync.py
}

case $1 in
	-h | --help)
		usage
		;;
	-v | --version)
		echo $VERSION
		;;
	-n | --new-file)
		new_file $2
		;;
	-i | --install)
		install
		;;
	-o | --open)
		open_notebook $2
		;;
	-c | --convert)
		convert $2
		;;
	*)
		usage
		;;
esac
