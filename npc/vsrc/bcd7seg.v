module	bcd7seg(
	input		[3:0]	bcd,
	output		[6:0]	hex	
);

reg	[6:0]	hex_reg;
assign	hex = ~hex_reg;

always @(*)begin
	case(bcd)
			4'b0000:	hex_reg = 7'b0111111;
			4'b0001:	hex_reg = 7'b0000110;
			4'b0010:	hex_reg = 7'b1011011;
			4'b0011:	hex_reg = 7'b1001111;
			4'b0100:	hex_reg = 7'b1100110;
			4'b0101:	hex_reg = 7'b1101101;
			4'b0110:	hex_reg = 7'b1111101;
			4'b0111:	hex_reg = 7'b0000111;
			4'b1000:	hex_reg = 7'b1111111;
			4'b1001:	hex_reg = 7'b1110111;
			default:	hex_reg = 7'b0000000;
	endcase
end
endmodule
