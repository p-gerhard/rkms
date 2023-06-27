import pytest
from rkms.simulation import *

def test_builder():
    p3d3 = P3D3()
    foo = Simulation(model=p3d3, tmax=1, cfl=1., input_mesh_file="foo")

            # Fill global simulation dictionary with all the parameters
    
