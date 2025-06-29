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
module alu_top
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
	output				[3:0]			result			, 
	output								zero			, 
	output								overflow	    , 
	output								carry	     
);





alu_4bit alu_4bit_inst(
	.a_data			(sw[3:0]	),
	.b_data			(sw[7:4]	),
	.opmode			(btn[2:0]	),
	.result			(result		),
	.zero			(zero		),
	.overflow		(overflow	),
	.carry			(carry		)

);
	

endmodule



