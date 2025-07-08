#Makefile
RTL = ../rtl/shift_register.v
LIB = work

COVOP = -coveropt 3 +cover +acc
TB1 = ../test/top.sv

VSIMOPT = -coverage -vopt work.top
VSIMCOV = coverage save -onexit -codeAll workcov
VSIMBATCH = -c -coverage -do " $(VSIMCOV);run -all;exit"


lib:
        vlib work
        vmap work work

help:
        @echo ===========================================================================================================================
        @echo " clean           =>  clean the earlier log and intermediate files."
        @echo " lib             =>  Create library and logical mapping."                                                                                @echo " run_tb1         =>  To compile RTL, TB & simulate the RTL using TB in batch mode."
        @echo " run1            =>  To clean, create libray, logical mapping, compile the source codes & simulate the RTL in batch mode."
        @echo " html            =>  To display html report using browser"
        @echo " report          =>  To create the html coverage report from the coverage database file"
        @echo ===========================================================================================================================


run_tb1:
        vlog -work work $(COVOP) $(RTL) $(TB1)
        vsim $(VSIMOPT) $(VSIMBATCH)
report:
        vcover report  -details -codeAll -html workcov

run1:clean lib run_tb1 report html

html:
        firefox covhtmlreport/index.html&

clean:
        rm -rf modelsim.ini transcript cov* workcov
        rm -rf $(LIB)
        clear
                          
