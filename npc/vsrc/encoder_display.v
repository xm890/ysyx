module	encoder_display(
	input			sw0,
	input			sw1,
	input			sw2,
	input			sw3,
	input			sw4,
	input			sw5,
	input			sw6,
	input			sw7,
	input			en,
	output	[2:0]	led,
	output			led_flag,
	output	[6:0]	display
);

wire	[3:0]	encoder_data;
assign	led = encoder_data[2:0];
encoder encoder_inst(
	.input_data({sw7,sw6,sw5,sw4,sw3,sw2,sw1,sw0}),
	.encoder_en(en),
	.data_flag(led_flag),
	.encoder_data(encoder_data)
);
bcd7seg bcd7seq_inst(
	.bcd(encoder_data),
	.hex(display)

);
endmodule

