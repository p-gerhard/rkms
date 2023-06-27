cmake_minimum_required(VERSION 3.15)
set(CMAKE_BUILD_TYPE Release)
project(mesh LANGUAGES CXX)

set(CMAKE_CXX_STANDARD 17)
set(CMAKE_POSITION_INDEPENDENT_CODE TRUE)

set(CMAKE_LIBRARY_OUTPUT_DIRECTORY ${CMAKE_BINARY_DIR})

option(USE_ABSL "USE_ABSL" ON)

set(LIBMESH_SRC_PATH "./rkms/mesh/src")

find_package(OpenMP)
find_package(Python COMPONENTS Interpreter Development)
find_package(pybind11 CONFIG REQUIRED)

if (USE_ABSL)
    find_package(absl QUIET)
    if (absl_FOUND)
        message(STATUS "Abseil library found")
        message(STATUS "Using Abseil 'flat_hash_map' as containers...")

        set(CMAKE_CXX_FLAGS "-D __USE_ABSL__")
    else()
    message(WARNING "Abseil library NOT found")
    endif()
endif()
if (NOT absl_FOUND OR NOT USE_ABSL)
    message(STATUS "Using STD ':map' as containers...")
endif()

add_library(mesh SHARED ${LIBMESH_SRC_PATH}/pybind11_wrappers.cpp
                        ${LIBMESH_SRC_PATH}/mesh_h8_process.cpp
                        ${LIBMESH_SRC_PATH}/mesh_q4_process.cpp)

if (absl_FOUND)
    target_link_libraries(mesh PRIVATE absl::flat_hash_map)
endif()

if(OpenMP_CXX_FOUND)
    target_link_libraries(mesh PUBLIC OpenMP::OpenMP_CXX)
endif()

target_link_libraries(mesh PUBLIC pybind11::module)

target_compile_options(mesh PRIVATE $<$<CXX_COMPILER_ID:GNU>: -Wall -O3>)

install(TARGETS mesh LIBRARY DESTINATION rkms/mesh)