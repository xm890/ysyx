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
module ps2_keyboard_top
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
	output				[7:0]			seg7			
);

wire			[7:0]			data			; 
wire			[7:0]			ascii_data		; 
wire			[7:0]			key_count		; 

assign seg2 = 8'b1111_1111;
assign seg5 = 8'b1111_1111;

bcd7seg	bcd7seg1_inst(
	.bcd			(data[3:0]),
	.hex			(seg0[7:1])
);

bcd7seg	bcd7seg2_inst(
	.bcd			(data[7:4]),
	.hex			(seg1[7:1])
);



bcd7seg	bcd7seg4_inst(
	.bcd			(ascii_data[3:0]),
	.hex			(seg3[7:1])
);
	
bcd7seg	bcd7seg5_inst(
	.bcd			(ascii_data[7:4]),
	.hex			(seg4[7:1])
);

bcd7seg	bcd7seg7_inst(
	.bcd			(key_count[3:0]),
	.hex			(seg6[7:1])
);

bcd7seg	bcd7seg8_inst(
	.bcd			(key_count[7:4]),
	.hex			(seg7[7:1])
);
ps2_keyboard	ps2_keyboard_inst
(
    .sys_clk	(sys_clk)		,
	.sys_rst_n  (sys_rst_n)     ,
	.ps2_clk	(ps2_clk)		,          
	.ps2_data	(ps2_data)		,          
	.data		(data)			, 
	.ascii_code	(ascii_data)	, 
	.ready		(ledr[0])		,
	.overflow	(ledr[1])		,
	.key_count	(key_count)    
);	               
endmodule



