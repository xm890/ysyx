//=======================================================================
// Company            : 
// Filename           : .v
// Author             : Lewen
// Created On         : 2025-06-22 20:29
// Last Modified      : 
// Description        : 
//                      
//                      
//=======================================================================
#include<stdio.h>
#include<stdlib.h>
#include<assert.h>
#include<nvboard.h>

#include"Vps2_keyboard_top.h"  
#include"verilated.h"
#include"verilated_vcd_c.h"

static TOP_NAME ps2_keyboard_top;
vluint64_t reset_time = 0;
VerilatedContext* contextp = NULL;
VerilatedVcdC* tfp = NULL;
static Vps2_keyboard_top* top;
void nvboard_bind_all_pins(TOP_NAME* top);
void top_reset(Vps2_keyboard_top *top, vluint64_t &reset_time){
	top->sys_rst_n = 1;
	if(reset_time >= 3 && reset_time <6){
		top->sys_rst_n = 0;	
	}	
}
void step_and_dump_wave(){
	top->eval();
	contextp->timeInc(1);
	tfp->dump(contextp->time());
}
void sim_init(){
	contextp = new VerilatedContext;
	tfp = new VerilatedVcdC;
	top = new Vps2_keyboard_top(contextp);
	contextp->traceEverOn(true);
	top->trace(tfp,0);
	tfp->open("wave.vcd");
}
void sim_exit(){
	step_and_dump_wave();
	tfp->close();
}
int main(int argc, char** argv) {
	sim_init();
    contextp->commandArgs(argc, argv);

    nvboard_bind_all_pins(top);  
    nvboard_init();
    while (!contextp->gotFinish()) {
		top_reset(top,reset_time);
		top->sys_clk ^=1;
		nvboard_update();
		step_and_dump_wave();
		reset_time++;
    }
	sim_exit();
    delete top;
    delete contextp;
    return 0;
}

