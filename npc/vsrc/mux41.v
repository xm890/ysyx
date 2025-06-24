module mux41(
	input		[1:0]		key	,
	input		[1:0]		x1	,	
	input		[1:0]		x2	,	
	input		[1:0]		x3	,	
	input		[1:0]		x4	,	
	output		[1:0]		out
);

MuxKeyInternal #(
	.NR_KEY			(4),
	.KEY_LEN		(2),
	.DATA_LEN		(2),
	.HAS_DEFAULT	(0)
)
MuxKeyInternal_inst(
	.key				(key),
	.default_out		(),
	.lut				({{2'b11,x4},{2'b10,x3},{2'b01,x2},{2'b00,x1}}),
	.out				(out)
);


endmodule
