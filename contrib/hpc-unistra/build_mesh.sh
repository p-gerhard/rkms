#!/bin/bash
#
# Description:
# This script show how to build a mesh using gmsh
#
# Reference:
#   https://github.com/p-gerhard/rkms
#
# Usage:
# Execute the script using the following command: bash build_mesh.sh
#
set -e

# MESH_NX=100
# MESH_NY=100
# MESH_NZ=100

MESH_NX=65
MESH_NY=65
MESH_NZ=65

MESH_DIM=3
MESH_GEO_FILE="/home2020/home/di/gerhard/rkms/data/geo/cuboid.geo"
MESH_MSH_DIR="/home2020/home/di/gerhard/rkms/examples/meshes"
MESH_BASE_NAME="unit_cube"

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
    module load slurm
    module load gmsh
fi

# WARNING: Patch was for module gmsh/gmsh-4.3.0.i18 (DEPRECATED)
# gmsh was not able to finding libjpeg.so.x and libgmp.so
# ln -sf /usr/lib64/libjpeg.so "libjpeg.so.9"
# ln -sf /usr/lib64/libgmp.so "libgmp.so.3"

# OLD_LD_LIBRARY_PATH=$LD_LIBRARY_PATH
# NEW_LD_LIBRARY_PATH=""
# NEW_LD_LIBRARY_PATH="$(pwd):$LD_LIBRARY_PATH"
# export LD_LIBRARY_PATH="$NEW_LD_LIBRARY_PATH"

rm -rf

if [ "$MESH_DIM" = 2 ]; then
    mesh_msh_file="$MESH_MSH_DIR/${MESH_BASE_NAME}_nx${MESH_NX}_ny${MESH_NY}.msh"
    rm -rf "$mesh_msh_file"

    gmsh -2 "$MESH_GEO_FILE" \
        -o "$mesh_msh_file" \
        -format msh22 \
        -setnumber nx "$MESH_NX" \
        -setnumber ny "$MESH_NY"
else

    mesh_msh_file="$MESH_MSH_DIR/${MESH_BASE_NAME}_nx${MESH_NX}_ny${MESH_NY}_nz${MESH_NZ}.msh"
    rm -rf "$mesh_msh_file"

    gmsh -3 "$MESH_GEO_FILE" \
        -o "$mesh_msh_file" \
        -format msh22 \
        -setnumber nx "$MESH_NX" \
        -setnumber ny "$MESH_NY" \
        -setnumber nz "$MESH_NX"
fi

# WARNING: Patch was for gmsh/gmsh-4.3.0.i18 (DEPRECATED)
# export LD_LIBRARY_PATH=$OLD_LD_LIBRARY_PATH
# rm -f "libjpeg.so.9"
# rm -f "libgmp.so.3"
