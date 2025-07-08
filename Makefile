# Makefile for QuestaSim simulation with coverage and waveform dump

RTL = ../rtl/shift_register.v
TB1 = ../test/top.sv
LIB = work

COVOP = -coveropt 3 +cover +acc
VSIMOPT = -coverage -vopt work.top
VSIMDO = log -r /*; coverage save -onexit -codeAll workcov; run -all; quit
VSIMBATCH = -c -do " $(VSIMDO) "

# Target to create work library
lib:
	vlib $(LIB)
	vmap $(LIB) $(LIB)

# Compile and simulate testbench 1
run_tb1:
	vlog -work $(LIB) $(COVOP) $(RTL) $(TB1)
	vsim $(VSIMOPT) $(VSIMBATCH)

# Generate HTML coverage report
report:
	vcover report -details -codeAll -html workcov

# Open coverage report in browser
html:
	firefox covhtmlreport/index.html &

# Clean simulation-generated files
clean:
	rm -rf modelsim.ini transcript cov* workcov vsim.wlf
	rm -rf $(LIB)
	clear

# Full run: clean, build, simulate, generate report, and open HTML
run1: clean lib run_tb1 report html

# Help menu
help:
	@echo ====================================================================================================
	@echo " clean     =>  Clean earlier log and intermediate files."
	@echo " lib       =>  Create library and logical mapping."
	@echo " run_tb1   =>  Compile RTL & TB, simulate with coverage and waveform logging."
	@echo " run1      =>  Clean, build, simulate, generate coverage report and open it."
	@echo " report    =>  Generate HTML coverage report."
	@echo " html      =>  Open HTML coverage report in Firefox."
	@echo ====================================================================================================
