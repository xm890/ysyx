module lfsr
(
    input								sys_clk			,
	input								sys_rst_n       ,
	output				[7:0]			lfsr_out		 
);	               
reg			[7:0]				shift_reg		; 
wire							x8				; 
assign	lfsr_out = shift_reg;
assign x8 = shift_reg[0]^shift_reg[2]^shift_reg[3]^shift_reg[4];
always @(posedge sys_clk or negedge sys_rst_n) begin
    if(!sys_rst_n) begin
		shift_reg <= 8'b0000_0001;   
    end else begin
		shift_reg <= {x8,shift_reg[7:1]};
    end
end


endmodule
