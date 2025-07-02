module ps2_keyboard
(
    input								sys_clk			,
	input								sys_rst_n       ,
	input								ps2_clk			,          
	input								ps2_data		,          
	output				[7:0]			data			, 
	output	reg			[7:0]			ascii_code	    ,
	output	reg							ready			,
	output	reg							overflow		,
	output	reg			[7:0]			key_count	    
);	               

//========================================================================\
// =========== Define Parameter and Internal signals =========== 
//========================================================================/
reg								nextdata_n		; 
reg			[9:0]				buffer			; 
reg			[7:0]				fifo [7:0]		; 
reg			[2:0]				w_ptr			; 
reg			[2:0]				r_ptr			; 
reg			[3:0]				count			; 
reg			[2:0]				ps2_clk_sync	; 
wire							sampling		; 

//=========================================================================
//**************    Main Code   **************
//=========================================================================

always @(posedge sys_clk)begin
	ps2_clk_sync <= {ps2_clk_sync[1:0],ps2_clk};
end
assign	sampling = ps2_clk_sync[2] & ~ps2_clk_sync[1];
always @(posedge sys_clk or negedge sys_rst_n) begin
    if(!sys_rst_n) begin
        count <= 'd0;
        w_ptr <= 'd0;
        r_ptr <= 'd0;
        overflow <= 'd0;
        ready <= 'd0;
    end else begin
		//if(ready)begin
		//	if(nextdata_n == 1'b0)begin
		//		r_ptr <= r_ptr + 1'b1;
		//		if(w_ptr == (r_ptr + 1))
		//			ready <= 1'b0;
		//	end
		//end
		if(sampling)begin
			if(count == 4'd10)begin
				if((buffer[0] == 0)&&(ps2_data)&&(^buffer[9:1]))begin
					fifo[w_ptr] <= buffer[8:1];
					w_ptr <= w_ptr + 1'b1;
					ready <= 1'b1;
					overflow <= overflow | (r_ptr == (w_ptr + 1'b1));
				end
				count <= 0;
			end else begin
				ready <= 1'b0;
				buffer[count] <= ps2_data;
				count <= count + 1'b1;
			end
		end
    end
end
assign data = fifo[r_ptr];
always @(*) begin
    case (data)
        8'h1C: ascii_code = 8'h41; // A
        8'h32: ascii_code = 8'h42; // B
        8'h21: ascii_code = 8'h43; // C
        8'h23: ascii_code = 8'h44; // D
        8'h24: ascii_code = 8'h45; // E
        8'h2B: ascii_code = 8'h46; // F
        8'h34: ascii_code = 8'h47; // G
        8'h33: ascii_code = 8'h48; // H
        8'h43: ascii_code = 8'h49; // I
        8'h3B: ascii_code = 8'h4A; // J
        8'h42: ascii_code = 8'h4B; // K
        8'h4B: ascii_code = 8'h4C; // L
        8'h3A: ascii_code = 8'h4D; // M
        8'h31: ascii_code = 8'h4E; // N
        8'h44: ascii_code = 8'h4F; // O
        8'h4D: ascii_code = 8'h50; // P
        8'h15: ascii_code = 8'h51; // Q
        8'h2D: ascii_code = 8'h52; // R
        8'h1B: ascii_code = 8'h53; // S
        8'h2C: ascii_code = 8'h54; // T
        8'h3C: ascii_code = 8'h55; // U
        8'h2A: ascii_code = 8'h56; // V
        8'h1D: ascii_code = 8'h57; // W
        8'h22: ascii_code = 8'h58; // X
        8'h35: ascii_code = 8'h59; // Y
        8'h1A: ascii_code = 8'h5A; // Z

        8'h45: ascii_code = 8'h30; // 0 
        8'h70: ascii_code = 8'h30; // 0 
        8'h16: ascii_code = 8'h31; // 1 
        8'h69: ascii_code = 8'h31; // 1 
        8'h1E: ascii_code = 8'h32; // 2 
        8'h72: ascii_code = 8'h32; // 2 
        8'h26: ascii_code = 8'h33; // 3 
        8'h7A: ascii_code = 8'h33; // 3 
        8'h25: ascii_code = 8'h34; // 4 
        8'h6B: ascii_code = 8'h34; // 4 
        8'h2E: ascii_code = 8'h35; // 5 
        8'h73: ascii_code = 8'h35; // 5 
        8'h36: ascii_code = 8'h36; // 6 
        8'h74: ascii_code = 8'h36; // 6 
        8'h3D: ascii_code = 8'h37; // 7 
        8'h6C: ascii_code = 8'h37; // 7 
        8'h3E: ascii_code = 8'h38; // 8 
        8'h75: ascii_code = 8'h38; // 8 
        8'h46: ascii_code = 8'h39; // 9 
        8'h7D: ascii_code = 8'h39; // 9 
        default: ascii_code = 8'h00; // 
    endcase
end
always @(posedge sys_clk or negedge sys_rst_n) begin
    if(!sys_rst_n) begin
        key_count <= 'd0;
    end else if(count == 'd10) begin
		key_count <= key_count + 1'b1;    
    end
end

endmodule 

