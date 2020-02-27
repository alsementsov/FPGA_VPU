module syncword_filter_Y(
	input wire [9:0] in,
	output reg [9:0] out
	);

always @*	begin
	if (in == 10'd1023)
		out = 10'd1022;
	else if (in == 10'd0)
		out = 10'd1;
	else
		out = in;
end

endmodule	