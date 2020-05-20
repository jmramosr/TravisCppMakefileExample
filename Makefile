CC           = gcc
CPP          = gcc
CPPFLAGSD    = -g -Wall -pedantic -ftest-coverage -fprofile-arcs --coverage -O0
CPPFLAGS98D  = $(CPPFLAGSD) -std=gnu++98
CPPFLAGS11D  = $(CPPFLAGSD) -std=gnu++11
CFLAGS99D    = $(CPPFLAGSD) -std=c99
CPPFLAGS     = -Wall
CPPFLAGS98   = $(CFLAGS) -std=gnu++98
CPPFLAGS11   = $(CFLAGS) -std=gnu++11
CFLAGS99     = $(CFLAGS) -std=c99
CPPFLAGST    = -g -Wall -pedantic
CPPFLAGS11T  = -g -Wall -pedantic -std=gnu++11
CDEF         =
LOADOPTS     =
BIN_DIR      = bin/
OBJ_DIR      = obj/
SRC_DIR      = src/
TEST_DIR     = test/
HTML_DIR     = html/
XML_DIR      = xml/
LIB_DIR      = lib/
INC_DIR      = include/
EXTRAS_DIR   = extras/
INC_BASE     = -I./$(INC_DIR)
INC_SOURCE   = -I./$(SRC_DIR)
INC_ALL      = $(INC_BASE) $(INC_SOURCE)
# Libraries packed in macros
LIB_BASE     = -L./$(LIB_DIR)
LIB_MATH     = -lm
# Colors!
cccyan       = $(shell echo -e "\033[30;48;5;114m")
ccorange     = $(shell echo -e "\033[30;48;5;130m")
ccgreenie    = $(shell echo -e "\033[30;48;5;66m")
ccpinky      = $(shell echo -e "\033[30;48;5;168m")
ccend        = $(shell echo -e "\033[0m")

# --- User can edit this part. Be careful ---#
# Must be the first part. Don't move any other initializer upper all!
all: \
     create_directories \
     execute_tests

# The obvious: which name will have the program.
PROGRAM_NAME_01   = RunUnitTests
# The files we need to output. The extension says us which version we want to compile
TESTING_FILES_01  = $(OBJ_DIR)project1.o11d
TESTING_FILES_01 += $(OBJ_DIR)test_project1.o11dt
# Special include directories (gtest-based)
INC_PROGRAM_TEST_01 = $(INC_ALL) -I./include/gtest -I./include/gmock
# Libraries needed by the different programs and their respective names
LIB_PROGRAM_TEST_01 = $(LIB_BASE) $(LIB_MATH) -lgtest_main -lgtest -lrt -lgcov -lstdc++

$(PROGRAM_NAME_01): $(TESTING_FILES_01)
	# $(ccorange)--- Linking $< ---$(ccend)
	$(CPP) $(CDEF) $^ -o $(BIN_DIR)$@ $(INC_PROGRAM_TEST_01) $(LIB_PROGRAM_TEST_01)

execute_01: $(PROGRAM_NAME_01)
	# --- Execute $< ---
	./$(BIN_DIR)$<

execute_tests: $(PROGRAM_NAME_01)
	# $(ccgreenie)--- Executing tests and making output $< ---$(ccend)
	./$(BIN_DIR)$< --gtest_output=xml:$(XML_DIR)report.xml

execute_all_tests:  execute_01
	# --- Executing all tests ---

# --- User may not edit beyond this point. Must be even more careful ---#

create_directories:
	if [ ! -d ./$(LIB_DIR)  ]; then mkdir -p ./$(LIB_DIR) ;fi
	if [ ! -d ./$(BIN_DIR)  ]; then mkdir -p ./$(BIN_DIR) ;fi
	if [ ! -d ./$(TEST_DIR) ]; then mkdir -p ./$(TEST_DIR);fi
	if [ ! -d ./$(OBJ_DIR)  ]; then mkdir -p ./$(OBJ_DIR) ;fi
	if [ ! -d ./$(HTML_DIR) ]; then mkdir -p ./$(HTML_DIR);fi
	if [ ! -d ./$(XML_DIR)  ]; then mkdir -p ./$(XML_DIR) ;fi

$(OBJ_DIR)%.o11: $(SRC_DIR)%.cpp
	# $(cccyan)--- [RELEASE C++11] Compiling $< ---$(ccend)
	$(CPP) $(CFLAGS11) $(INC_ALL) -c $< -o $@

$(OBJ_DIR)%.o11d: $(SRC_DIR)%.cpp
	# $(cccyan)--- [DEBUG C++11] Compiling $< ---$(ccend)
	$(CPP) $(CPPFLAGS11D) $(INC_ALL) -c $< -o $@

$(OBJ_DIR)%.o11dt: $(TEST_DIR)%.cpp
	# $(ccpinky)--- [DEBUG TESTING C++11] Compiling $< ---$(ccend)
	$(CPP) $(CPPFLAGS11T) $(INC_ALL) -c $< -o $@

$(OBJ_DIR)%.o: $(SRC_DIR)%.cpp
	# $(cccyan)--- [RELEASE C++] Compiling $< ---$(ccend)
	$(CPP) $(CPPFLAGS) $(INC_ALL) -c $< -o $@

$(OBJ_DIR)%.od: $(SRC_DIR)%.cpp
	# $(cccyan)--- [DEBUG C++] Compiling $< ---$(ccend)
	$(CPP) $(CPPFLAGSD) $(INC_ALL) -c $< -o $@

$(OBJ_DIR)%.odt: $(TEST_DIR)%.cpp
	# $(ccpinky)--- [DEBUG TESTING C++] Compiling $< ---$(ccend)
	$(CPP) $(CPPFLAGST) $(INC_ALL) -c $< -o $@

$(OBJ_DIR)%.o98: $(SRC_DIR)%.cpp
	# --- [RELEASE C++98] Compiling $< ---
	$(CPP) $(CFLAGS98) $(INC_ALL) -c $< -o $@

$(OBJ_DIR)%.o98d: $(SRC_DIR)%.cpp
	# --- [DEBUG C++98] Compiling $< ---
	$(CPP) $(CFLAGS98D) $(INC_ALL) -c $< -o $@

$(OBJ_DIR)%.oc99: $(SRC_DIR)%.c
	# --- [RELEASE C99] Compiling $< ---
	$(CPP) $(CFLAGS) $(INC_ALL) -c $< -o $@

$(OBJ_DIR)%.oc99d: $(SRC_DIR)%.c
	# --- [DEBUG C99] Compiling $< ---
	$(CPP) $(CFLAGS99D) $(INC_ALL) -c $< -o $@

cleanobj:
	# --- Clean all objects ---
	rm -f $(OBJ_DIR)*.o

clean:
	# --- Clean all objects ---
	rm -rf $(OBJ_DIR)

allc: all \
     cleanobj

Debug: all

Release: all

default: all