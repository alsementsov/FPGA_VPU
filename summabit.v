module summabit(
	input wire [WIDTH:0] DATA,
	output wire summa);
	parameter unsigned WIDTH = 5'd14;
	
	assign summa = |DATA;
	
endmodule