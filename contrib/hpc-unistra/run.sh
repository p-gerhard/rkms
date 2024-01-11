#!/bin/bash
#
# Description: 
# This script show how to run an RKMS exemple
#
# Reference:
#   https://github.com/p-gerhard/rkms
#
# Usage: 
# Execute the script using the following command: bash install.sh
#
#

set -e

VENV_NAME="venv-rkms"
RKMS_FILE="/home2020/home/di/gerhard/rkms/examples/astro/solve_astro_stromgren_sphere.py"
CURRENT_DIR="$(pwd)"

echo_i() {
    message="$1"
    echo -e "\e[1;32m[installer] [INFO]\e[0m $message"
}

echo_e() {
    message="$1"
    echo -e "\e[1;31m[installer] [ERROR]\e[0m $message" 
}

if command -v "module" >/dev/null 2>&1; then
    echo_i "Loading environment modules..."
    module load gcc
    module load cmake
    module load python
fi

echo_i "Loading venv '$VENV_NAME'..."
source "$VENV_NAME/bin/activate"

dir_name="$(dirname $RKMS_FILE)"
cd "$dir_name" || exit 1
echo_i "Moved to $dir_name"

python3 "$(basename $RKMS_FILE)"

echo_i "Run successfully!"

cd "$CURRENT_DIR" || exit 1
 
