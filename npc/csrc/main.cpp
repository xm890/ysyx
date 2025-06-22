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

#include"Vmux21.h"  
#include"verilated.h"
#include"verilated_vcd_c.h"


VerilatedContext* contextp = NULL;
VerilatedVcdC* tfp = NULL;
static Vmux21* top;
void step_and_dump_wave(){
	top->eval();
	contextp->timeInc(1);
	tfp->dump(contextp->time());
}
void sim_init(){
	contextp = new VerilatedContext;
	tfp = new VerilatedVcdC;
	top = new Vmux21(contextp);
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

//    nvboard_bind_all_pins(top);  
    nvboard_init();

	int n = 100;    
    while (n-- > 0) {
		nvboard_update();
		int a = rand() &1;
		int b = rand() &1;
		if(n>50)
			top->s = 0;
		else 
			top->s = 1;
		top->a = a;
		top->b = b;
		step_and_dump_wave();
		printf("a=%d,b=%d,s=%d,y=%d\n",a,b,top->s,top->y);
		assert(top->y == (~top->s&a)|(top->s&b));
    }
	sim_exit();
    delete top;
    delete contextp;
    return 0;
}

