
.PHONY: obj all

PRJ_NAME := hello
SHARED_LIB_NAME := libhello.so

CC := gcc
C_FLAGS := -fPIC -c

CUR_DIR := .
INC_DIR := $(CUR_DIR)/inc
SRC_DIR := $(CUR_DIR)/src
OBJ_DIR := $(CUR_DIR)/obj
BIN_DIR := $(CUR_DIR)/bin

LIB_DIR := $(CUR_DIR)/lib
LIB_SHARED_DIR := $(LIB_DIR)/shared


# Create object file
obj:
	$(CC) $(C_FLAGS) $(CUR_DIR)/main.c -o $(OBJ_DIR)/main.o -I $(INC_DIR)
	$(CC) $(C_FLAGS) $(SRC_DIR)/hello_world.c -o $(OBJ_DIR)/hello_world.o -I $(INC_DIR)
	$(CC) $(C_FLAGS) $(SRC_DIR)/hello_cuong.c -o $(OBJ_DIR)/hello_cuong.o -I $(INC_DIR)


# Create shared lib

shared:
	$(CC) -shared -o $(LIB_SHARED_DIR)/$(SHARED_LIB_NAME) $(OBJ_DIR)/*

install:
	install $(LIB_SHARED_DIR)/$(SHARED_LIB_NAME) /usr/lib

# Embedded shared lib path into executable file
all: obj shared
	$(CC) -L$(LIB_SHARED_DIR) -Wl,-rpath=$(LIB_SHARED_DIR) -lhello -o $(BIN_DIR)/$(PRJ_NAME) $(OBJ_DIR)/main.o

# coppy shared lib into /user/lib using 'install' commandline and in linker find libhello.so (because of using -lhello) in /user/lib by default
#all: obj shared install
#	$(CC) -lhello -o $(BIN_DIR)/$(PRJ_NAME) $(OBJ_DIR)/main.o

# using Enviroment variable --> not recommend

clean:
	rm -rf $(OBJ_DIR)/*
	rm -rf $(LIB_SHARED_DIR)/*
	rm -rf $(BIN_DIR)/*


