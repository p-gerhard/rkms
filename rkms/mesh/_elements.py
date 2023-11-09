# GMSH Quadrangle:
#
#       v
#       ^
#       |
# 3-----------2
# |     |     |
# |     |     |
# |     +---- | --> u
# |           |
# |           |
# 0-----------1

Q4_ELEM = {
    "ELEM_CODE": 3,
    "PHY_DIM": 2,
    "FACE_PER_ELEM": 4,
    "NODE_PER_ELEM": 4,
    "NODE_PER_FACE": 2,
    "FACE_TO_LOC_NODE": [
        [1, 2],  # Right
        [3, 0],  # Left
        [2, 3],  # North
        [0, 1],  # South
    ],
    "GMSH_REF_NODE_COORD": [
        (0.0, 0.0),
        (1.0, 0.0),
        (1.0, 1.0),
        (0.0, 1.0),
    ],
}

# GMSH Order Hexahedron:
#
#        v
# 3----------2
# |\     ^   |\
# | \    |   | \
# |  \   |   |  \
# |   7------+---6
# |   |  +-- |-- | -> u
# 0---+---\--1   |
#  \  |    \  \  |       8
#   \ |     \  \ |
#    \|      w  \|
#     4----------5

H8_ELEM = {
    "ELEM_CODE": 5,
    "PHY_DIM": 3,
    "FACE_PER_ELEM": 6,
    "NODE_PER_ELEM": 8,
    "NODE_PER_FACE": 4,
    "FACE_TO_LOC_NODE": [
        [1, 2, 6, 5],  # Right
        [0, 4, 7, 3],  # Left
        [2, 3, 7, 6],  # Front
        [1, 5, 4, 0],  # Back
        [4, 5, 6, 7],  # North
        [0, 3, 2, 1],  # South
    ],
    "GMSH_REF_NODE_COORD": [
        (0.0, 0.0, 0.0),
        (1.0, 0.0, 0.0),
        (1.0, 1.0, 0.0),
        (0.0, 1.0, 0.0),
        (0.0, 0.0, 1.0),
        (1.0, 0.0, 1.0),
        (1.0, 1.0, 1.0),
        (0.0, 1.0, 1.0),
    ],
}
