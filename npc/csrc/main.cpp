#include<stdio.h>
#include<stdlib.h>
#include<assert.h>
#include<nvboard.h>

#include"Vtop.h"  
#include"verilated.h"
#include"verilated_vcd_c.h"

void nvboard_bind_all_pins(Vtop* top);
void single_cycle(Vtop* top){
	top->clk=0;top->eval();
	top->clk=1;top->eval();
}
void reset(Vtop* top,int n){
	top->rst = 1;
	while(n-- > 0) 
		single_cycle(top);
	top->rst = 0;
}
int main(int argc, char** argv) {
    VerilatedContext* contextp = new VerilatedContext;
    contextp->traceEverOn(true);
    contextp->commandArgs(argc, argv);

    Vtop* top = new Vtop{contextp};

    nvboard_bind_all_pins(top);  
    nvboard_init();

    VerilatedVcdC* m_trace = new VerilatedVcdC; 
    top->trace(m_trace, 99);  
    m_trace->open("wave.vcd");  
    
	reset(top,10);
    while (!contextp->gotFinish()) {
		nvboard_update();
        contextp->timeInc(1);
		single_cycle(top);
        m_trace->dump(contextp->time()); 
    }
    m_trace->close();
    delete top;
    delete contextp;
    return 0;
}

