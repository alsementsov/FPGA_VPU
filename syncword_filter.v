module syncword_filter(
	input wire [9:0] in,
	output reg [9:0] out
	);

always @*	begin
	if (in == 10'd1023)
		out = 10'd1019;
	else if (in == 10'd0)
		out = 10'd4;
	else if (in == 10'd64)
		out = 10'd63;	
	else if (in == 10'd512)
		out = 10'd511;	
	else
		out = in;
end

endmodule	