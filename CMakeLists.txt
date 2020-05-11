cmake_minimum_required(VERSION 2.8)

# Make PROJECT_SOURCE_DIR, PROJECT_BINARY_DIR, and PROJECT_NAME available.
set(PROJECT_NAME project1)
project(${PROJECT_NAME})
include(gtest.cmake)

SET(COVERAGE OFF CACHE BOOL "Coverage")

set(CMAKE_CXX_FLAGS "-g -Wall")

# If you want your own include/ directory, set this, and then you can do
# include_directories(${COMMON_INCLUDES}) in other CMakeLists.txt files.
# set(COMMON_INCLUDES ${PROJECT_SOURCE_DIR}/include)

#----------------------------------------------------------------------------
# Define project sources and includes
#----------------------------------------------------------------------------
set(COMMON_INCLUDES ${PROJECT_SOURCE_DIR}/include)
include_directories(${COMMON_INCLUDES})
file(GLOB SRC_FILES ${PROJECT_SOURCE_DIR}/src/*.cpp)
file(GLOB TEST_SRC_FILES ${PROJECT_SOURCE_DIR}/test/*.cpp)
list(REMOVE_ITEM SRC_FILES ${PROJECT_SOURCE_DIR}/src/main.cpp)

set(CMAKE_CXX_STANDARD 11)

set(O0_COMPILER_FLAGS "-o0"
    CACHE INTERNAL "")

function(append_no_optimization_compiler_flags)
    set(CMAKE_C_FLAGS "${CMAKE_C_FLAGS} ${O0_COMPILER_FLAGS}" PARENT_SCOPE)
    set(CMAKE_CXX_FLAGS "${CMAKE_CXX_FLAGS} ${O0_COMPILER_FLAGS}" PARENT_SCOPE)
    set(CMAKE_Fortran_FLAGS "${CMAKE_Fortran_FLAGS} ${O0_COMPILER_FLAGS}" PARENT_SCOPE)
    message(STATUS "Appending no optimization compiler flags: ${O0_COMPILER_FLAGS}")
endfunction() # append_no_optimization_compiler_flags

################################
# Normal Libraries & Executables
################################
add_library(project1_lib ${SRC_FILES})

# Key idea: SEPARATE OUT your main() function into its own file so it can be its
# own executable. Separating out main() means you can add this library to be
# used elsewhere (e.g linking to the test executable).
#add_executable(project1 ${PROJECT_SOURCE_DIR}/src/main.cpp)

#target_link_libraries(project1 project1_lib)

################################
# Testing
################################

# Options. Turn on with 'cmake -Dmyvarname=ON'.
option(BUILD_TESTS "Build all tests." OFF) # Makes boolean 'test' available.

if (BUILD_TESTS)

  enable_testing()
	

  ##############
  # Unit Tests
  ##############
  add_executable(runUnitTests ${TEST_SRC_FILES})

  if(CMAKE_COMPILER_IS_GNUCXX)
  LIST(APPEND CMAKE_MODULE_PATH "${PROJECT_SOURCE_DIR}/cmake_modules")
  include(CodeCoverage)
  APPEND_NO_OPTIMIZATION_COMPILER_FLAGS()
  APPEND_COVERAGE_COMPILER_FLAGS()
  # this is optional if you want to exclude some directory from the report
  #set(COVERAGE_LCOV_EXCLUDES 'dir1/*' 'dir2/*')
  # Both setups - SETUP_TARGET_FOR_COVERAGE_LCOV and SETUP_TARGET_FOR_COVERAGE_LCOV must be after the add_executable
  SETUP_TARGET_FOR_COVERAGE_LCOV(NAME generate_coverage
                                EXECUTABLE runUnitTests
                                DEPENDENCIES runUnitTests)
  SETUP_TARGET_FOR_COVERAGE_GCOVR_XML( NAME generate_gcovr
                                     EXECUTABLE runUnitTests
                                     DEPENDENCIES runUnitTests)
  endif()

  # Standard linking to gtest stuff.
  target_link_libraries(runUnitTests gtest pthread)

  # Extra linking for the project.
  target_link_libraries(runUnitTests project1_lib)

  # This is so you can do 'make test' to see all your tests run, instead of
  # manually running the executable runUnitTests to see those specific tests.
  add_test(UnitTests runUnitTests)

endif()
