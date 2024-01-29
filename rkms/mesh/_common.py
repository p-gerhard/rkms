from __future__ import annotations

import logging
import numpy as np

logger = logging.getLogger(__name__)
logger.setLevel(logging.INFO)

MESH_INT_DTYPE = np.int64
MESH_FLOAT_DTYPE = np.float64
MESH_TOL = 1e-14
