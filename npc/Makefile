all:
	@echo "Write this Makefile by your self."

sim:
	$(call git_commit, "sim RTL") # DO NOT REMOVE THIS LINE!!!
	@echo "Write this Makefile by your self."

include ../Makefile
compile:
	verilator -Wall --cc --exe --build --trace ./csrc/main.cpp ./vsrc/top.v

