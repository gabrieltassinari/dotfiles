#!/bin/bash

[[ -z $1 ]] && echo "Usage: source jupy_venv.sh [FILE]" && return

# Setup virtual environment
[[ ! -d ".venv" ]] && \
	python -m venv .venv && source .venv/bin/activate && \
	pip install jupyter_ascending && \
	python -m jupyter nbextension    install jupyter_ascending --sys-prefix --py && \
	python -m jupyter nbextension     enable jupyter_ascending --sys-prefix --py && \
	python -m jupyter serverextension enable jupyter_ascending --sys-prefix --py && \
	deactivate
source .venv/bin/activate

# Create the file if doesn't exists.
[[ ! -f "$1.sync.ipynb" ]] && python -m jupyter_ascending.scripts.make_pair --base $1

# Attach to a tmux session
tmux new-session $0 \; send-keys "jupyter notebook $1.sync.ipynb &>/dev/null &" Enter
