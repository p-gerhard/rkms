#!/bin/bash
#
# Description: 
# This script facilitates the download and installation of RKMS within a Python
# virtual environment (venv).
#
# Reference:
#   https://github.com/p-gerhard/rkms
#
# Usage: 
# Execute the script using the following command: bash install.sh
#
#

set -e

GIT_PULL=true
GIT_BRANCH="main"

VENV_NAME="venv-rkms"

CURRENT_DIR="$(pwd)"

echo_i() {
    message="$1"
    echo -e "\e[1;32m[installer] [INFO]\e[0m $message"
}

echo_e() {
    message="$1"
    echo -e "\e[1;31m[installer] [ERROR]\e[0m $message" 
}

git_root=$(git rev-parse --show-toplevel 2>/dev/null) || true

if [ -z "$git_root" ]; then
  echo_e "Git root directory not found. Please ensure you are somwhere within RKMS Git repository. Aborting..."
  exit 1
fi

cd "$git_root" || exit 1
echo_i "Moved to $git_root..."

if command -v "module" >/dev/null 2>&1; then
    echo_i "Loading environment modules..."
    module load gmsh
    module load gcc
    module load cmake
    module load python
fi

if [ "$GIT_PULL" = true ]; then
    echo_i "Pulling git changes..."
    git checkout "$GIT_BRANCH"
    git pull
fi

if [ ! -d "$VENV_NAME" ]; then
    echo_i "Creating venv '$VENV_NAME'..."
    python3 -m venv "$VENV_NAME"
fi

echo_i "Loading venv '$VENV_NAME'..."
source "$VENV_NAME/bin/activate"

# WARNING: _skbuild is remove to avoid cmake rebuild issue when datetime are
# wrong. Can be commented out.
rm -rf _skbuild

echo_i "Installing RKMS..."
pip3 install .

# WARNING: If you want to perform a full reinstall of dep use --force-reinstall
# pip install . --force-reinstall

echo_i "Installed successfully!"

cd "$CURRENT_DIR" || exit 1
