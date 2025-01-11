MEMORY_FILES  := $(wildcard memory/*.v)           
PROCESSOR_FILES := $(wildcard processor/*.v)      
SRC_FILES     := computer.v $(MEMORY_FILES) $(PROCESSOR_FILES)  
BENCH_FILE    := tests/computer_bench.v           
OUTPUT_FILE   := tests/computer                   
VVP_EXEC      := computer                         
TEST_DIR      := tests                            

all: compile run

compile: $(BENCH_FILE) $(SRC_FILES)
	iverilog -o $(OUTPUT_FILE) $(BENCH_FILE) $(SRC_FILES)

run: $(OUTPUT_FILE)
	cd $(TEST_DIR) && vvp $(VVP_EXEC)
