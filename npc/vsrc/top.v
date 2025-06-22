module top(  // 这里名字要与Makefile中的TOPNAME和cpp文件中的#include "Vtop.h"相同
	input a,
	input b,
	output f
);
assign f = a^b;
endmodule

