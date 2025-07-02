module	bcd7seg(
	input		[3:0]	bcd,
	output reg	[6:0]	hex	
);
reg			[6:0]		hex_reg		; 

//assign	hex = hex_reg;
integer i;
always @(*)begin
	for(i=0;i<7;i=i+1)begin
		hex[i] = hex_reg[6-i];
	end
end
always @(*)begin
	case(bcd)
			4'b0000:	hex_reg = 7'b1000000;
			4'b0001:	hex_reg = 7'b1111001;
			4'b0010:	hex_reg = 7'b0100100;
			4'b0011:	hex_reg = 7'b0110000;
			4'b0100:	hex_reg = 7'b0011001;
			4'b0101:	hex_reg = 7'b0010010;
			4'b0110:	hex_reg = 7'b0000010;
			4'b0111:	hex_reg = 7'b1111000;//7
			4'b1000:	hex_reg = 7'b0000000;//8
			4'b1001:	hex_reg = 7'b0011000;
			4'b1010:	hex_reg = 7'b0001000;
			4'b1011:	hex_reg = 7'b0000011;
			4'b1100:	hex_reg = 7'b1000110;
			4'b1101:	hex_reg = 7'b0100001;
			4'b1110:	hex_reg = 7'b0000110;
			4'b1111:	hex_reg = 7'b0001110;
			default:	hex_reg = 7'b0000000;
	endcase
end
endmodule
