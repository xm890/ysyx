//=======================================================================
// Company            : 
// Filename           : .v
// Author             : Lewen
// Created On         : 2025-06-29 19:03
// Last Modified      : 
// Description        : 
//                      
//                      
//=======================================================================
module lfsr_top
(
	input								sys_clk			,          
	input								sys_rst_n		,          
	input				[4:0]			btn				, 
	input				[15:0]			sw				, 
	input								ps2_clk			,          
	input								ps2_data		,          
	input								uart_rx			,          
	output								uart_tx			, //
	output				[15:0]			ledr			, 
	output								VGA_HSYNC	    , 
	output								VGA_VSYNC	    , 
	output								VGA_BLANK_N	    , 
	output				[7:0]			VGA_R			, 
	output				[7:0]			VGA_G			, 
	output				[7:0]			VGA_B			, 
	output				[7:0]			seg0			, 
	output				[7:0]			seg1			, 
	output				[7:0]			seg2			, 
	output				[7:0]			seg3			, 
	output				[7:0]			seg4			, 
	output				[7:0]			seg5			, 
	output				[7:0]			seg6			, 
	output				[7:0]			seg7			,
	output				[3:0]			lfsr_out1		, 
	output				[3:0]			lfsr_out2		 
);

bcd7seg	bcd7seg1_inst(
	.bcd			(lfsr_out1),
	.hex			(seg0[7:1])
);

bcd7seg	bcd7seg2_inst(
	.bcd			(lfsr_out2),
	.hex			(seg1[7:1])
);
lfsr	lfsr_inst(
	.sys_clk		(btn[0]),
	.sys_rst_n		(sw[0]),
	.lfsr_out		({lfsr_out2,lfsr_out1})
);
	

endmodule



