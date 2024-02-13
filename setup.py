from skbuild import setup
from setuptools import find_packages

setup(
    packages=find_packages(),
    name="rkms",
    version="1.0.1",
    author="Pierre Gerhard",
    author_email="pierre.gerhard@gmail.com",
    url="https://github.com/p-gerhard/reduced-kinetic-models-solver",
    description="A finite volume solver for reduced kinetic models",
    long_description="",
    ext_package="rkms.mesh",
    extras_require={"tests": "pytest"},
    zip_safe=False,
    python_requires=">=3.7",
    include_package_data=True,
    install_requires=[
        "meshio[all]",
        "numpy",
        "pyopencl[test]",
        "matplotlib"
    ],
    package_data={
        "rkms": [
            "solver/cl/**/*.cl",
            "mesh/src/**/*",
        ]
    },
)
