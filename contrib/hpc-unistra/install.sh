#!/bin/bash
#
# Description:
# This script downloads, and install RKMS in a python venv.
# 
# Reference:
# https://github.com/p-gerhard/rkms
#
set -e

USE_MODULES=false

GIT_PULL=true
GIT_BRANCH="main"

VENV_NAME="venv-rkms"

CURRENT_DIR="$(pwd)"

echo_t() {
    message="$1"
    current_datetime=$(date "+%Y-%m-%d %H:%M:%S")
    echo -e "\e[1;32m[installer] [$current_datetime]\e[0m $message"
}

if [ "$USE_MODULES_USE" = true ]; then
    echo_t "Loading environment modules..."
    module load gmsh
    module load gcc
    module load cmake
    module load python
fi

git_root=$(git rev-parse --show-toplevel 2>/dev/null)
cd "$git_root" || exit 1
echo_t "Moved to $git_root..."

if [ "$GIT_PULL" = true ]; then
    echo_t "Pulling git changes..."
    git checkout "$GIT_BRANCH"
    git pull
fi

if [ "$VENV_USE" = true ]; then
    if [ ! -d "$$VENV_NAME" ]; then
        echo_t "Creating venv '$$VENV_NAME'..."
        python3 -m venv "$VENV_NAME"
    fi

    echo_t "Loading venv '$$VENV_NAME'..."
    source "$VENV_NAME/bin/activate"
fi

# WARNING: _skbuild is remove to avoid cmake rebuild issue when datetime are
# wrong. Can be commented out.
rm -rf _skbuild

echo_t "Installing RKMS..."
pip install .

# WARNING: If you want to perform a full reinstall of dep use --force-reinstall
# pip install . --force-reinstall

echo_t "Installed successfully!"

cd "$CURRENT_DIR" || exit 1
