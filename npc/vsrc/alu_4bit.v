module alu_4bit
(
	input				[3:0]			a_data			, 
	input				[3:0]			b_data			, 
	input				[2:0]			opmode			, 
	output	reg			[3:0]			result			,
	output	reg							zero			,
	output	reg							overflow		,
	output	reg							carry			
);	               




assign	zero = ~(|result);


always @(*)begin
	carry = 0;
	result = 0;
	overflow = 0;
	case(opmode)
		3'b000:begin
			{carry,result} = a_data + b_data;
			overflow = (a_data[3] == b_data[3]) && (a_data[3] !=result[3]);
		end
		3'b001:begin
			{carry,result} = a_data-b_data;
			overflow = ((a_data[3] == b_data[3]) && (a_data[3] != result[3]));
		end
		3'b010:begin
			result = ~a_data;
		end
		3'b100:begin
			result = a_data | b_data;
		end
		3'b101:begin
			result = a_data^b_data;
		end
		3'b110:begin
			if(a_data < b_data)
				result = 1;
			else
				result = 0;
		end
		3'b111:begin
			if(a_data == b_data)
				result = 1;
			else 
				result = 0;
		end	
		default:begin
			result = 0;
			carry = 0;
		end
	endcase
end


endmodule
