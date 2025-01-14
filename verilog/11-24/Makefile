MEMORY_FILES  := $(wildcard memory/*.v)           
PROCESSOR_FILES := $(wildcard processor/*.v)      
DEVICE_FILES := $(wildcard devices/*.v)      
INTERFACE_FILES := $(wildcard interfaces/*/*.v)
ASSEMBLER := assembler/assemble.py
FIRMWARE_FILE := assembler/firmware.s
EPROM_DUMP := memory/dumps/eprom_data.dat
SRC_FILES     := computer.v $(MEMORY_FILES) $(PROCESSOR_FILES) $(DEVICE_FILES) $(INTERFACE_FILES)
BENCH_FILE    := tests/computer_bench.v           
OUTPUT_FILE   := tests/computer                   
VVP_EXEC      := computer                         
TEST_DIR      := tests                            

all: assemble compile run

assemble: 
	python ${ASSEMBLER} ${FIRMWARE_FILE} ${EPROM_DUMP}

compile: $(BENCH_FILE) $(SRC_FILES)
	iverilog -o $(OUTPUT_FILE) $(BENCH_FILE) $(SRC_FILES)

run: $(OUTPUT_FILE)
	cd $(TEST_DIR) && vvp $(VVP_EXEC)
