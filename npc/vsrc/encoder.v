module	encoder
(
	input		[7:0]	input_data,
	input				encoder_en,
	output				data_flag,
	output	reg	[3:0]	encoder_data
);
integer i;
assign data_flag = |input_data;

always @(*)begin
	if(encoder_en)begin
		encoder_data = 0;
		for(i=0;i<8;i=i+1)begin
			if(input_data[i] == 1) 
				encoder_data = i[3:0];
		end
	end else 
		encoder_data = 0;
end
endmodule
