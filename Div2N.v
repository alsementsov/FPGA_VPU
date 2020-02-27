module Div2N(
	input wire [31:0] DATA,
	input wire [5:0] N,
	output wire [31:0] out);

	assign out = DATA >> N;
	
endmodule