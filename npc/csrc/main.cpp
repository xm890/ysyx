#include <stdio.h>
#include <stdlib.h>
#include <assert.h>
#include <verilated.h>
#include <verilated_vcd_c.h>
#include "Vtop.h"
int main(int argc,char ** argv, char ** env) {
	VerilatedContext* contextp = new VerilatedContext;
	contextp->commandArgs(argc,argv);
	Vtop *top=new Vtop;
	int i=10;

	VerilatedVcdC *tfp=new VerilatedVcdC;
	contextp->traceEverOn(true);
	top->trace(tfp,0);
	tfp->open("wave.vcd");
	while(i--){
		int a = rand()&1;
		int b = rand()&1;
		top->a = a;
		top->b = b;
		top->eval();	
  	printf("a=%d,b=%d,f=%d\n",a,b,top->f);
		tfp->dump(contextp->time());
		contextp->timeInc(1);
		assert(top->f==(a^b));
	}
	delete top;
	tfp->close();
	delete contextp;
  return 0;
}
