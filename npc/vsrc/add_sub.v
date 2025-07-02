module	add_sub(
	input			c_in,
	input	[3:0]	A,
	input	[3:0]	B,
	output	[3:0]	result,
	output			carry,
	output			zero,
	output			overflow
);

wire		[3:0]	xor_B;

assign	xor_B = {n{c_in}}^B;
assign	result = A + xor_B + c_in;
assign	overflow = (A[3] == xor_B[3]) && (result[3] != A[3]);
assign	zero = ~(|result);

endmodule
