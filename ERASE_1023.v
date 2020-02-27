module ERASE_1023(
	input wire [15:0] DATA_READ,
	input wire [6:0] x,
	input wire [5:0] y,
	input wire [9:0] data_dff,
	input wire dead_pix,
	input wire test,
	input wire frame_imp,
	output reg [9:0] OUT_DATA);	
	
	reg [9:0] out_A;
	reg [9:0] out_B;
	reg [9:0] cntF;
	
always @ (posedge frame_imp) begin
		if (cntF>=1000)
			cntF<=250;
		else
			cntF<=cntF+50;
end

always @* begin
	// Overload
	if (DATA_READ >= 16'd2045)
		out_A = 10'd1022;
	else
		out_A = DATA_READ[10:1];

	// DEAD pixel
	if (dead_pix==1)
		out_B = data_dff;
	else
		out_B = out_A;
		
	// Test plus
	if (test==1) begin
		if ((x>=39)&&(x<=40)&&(y>=31)&&(y<=32))
			OUT_DATA = cntF;
		else
			OUT_DATA = 10;
	end
	else
		OUT_DATA = out_B;
end
endmodule