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

#include"Valu_top.h"  
#include"verilated.h"
#include"verilated_vcd_c.h"
static TOP_NAME alu_top;
VerilatedContext* contextp = NULL;
VerilatedVcdC* tfp = NULL;
static Valu_top* top;
void nvboard_bind_all_pins(TOP_NAME* top);
void step_and_dump_wave(){
	top->eval();
	contextp->timeInc(1);
	tfp->dump(contextp->time());
}
void sim_init(){
	contextp = new VerilatedContext;
	tfp = new VerilatedVcdC;
	top = new Valu_top(contextp);
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
		nvboard_update();
		step_and_dump_wave();
		printf("a_data=%d,b_data=%d,opmode=%d,result=%d,zero=%d,overflow=%d,carry=%d\n",top->sw & 0x0f,(top->sw>>4)&0x0f,top->btn&0x07,top->result,top->zero,top->overflow,top->carry);
    }
	sim_exit();
    delete top;
    delete contextp;
    return 0;
}

