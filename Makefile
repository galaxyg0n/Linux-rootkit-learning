# Compiler
CC = gcc

# Compiler flags
CFLAGS = -Wall -Wextra -g -Iincludes

# Directories
SRC_DIR = src
BUILD_DIR = build
INCLUDE_DIR = includes

# Target executable
TARGET = $(BUILD_DIR)/main

# Source and object files
SRCS = $(wildcard $(SRC_DIR)/*.c)
OBJS = $(patsubst $(SRC_DIR)/%.c,$(BUILD_DIR)/%.o,$(SRCS))

# Default target
all: $(TARGET)

# Link object files to create the executable
$(TARGET): $(OBJS)
	$(CC) $(CFLAGS) -o $@ $^

# Compile .c files into .o files in build/
$(BUILD_DIR)/%.o: $(SRC_DIR)/%.c | $(BUILD_DIR)
	$(CC) $(CFLAGS) -c $< -o $@

# Ensure build directory exists
$(BUILD_DIR):
	mkdir -p $(BUILD_DIR)

# Clean generated files
clean:
	rm -rf $(BUILD_DIR)/*

# Phony targets
.PHONY: all clean
