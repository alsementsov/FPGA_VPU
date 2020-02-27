module bmp_DRAW(
	input wire [10:0] xo,
	input wire [11:0] yfire,
	input wire [10:0] ylogo,
	input wire en_fire,
	input wire [3:0] fire,
	input wire [3:0] logo,
	input wire clk,
	output reg [3:0] draw
	);

	
always @ (posedge clk) begin

	if ((en_fire==1) && (xo[10:0]<=89) && (yfire[10:0]<=127)&&(yfire[11]==0))
		draw <= fire;
	else if ((xo[10:0]<=109) && (ylogo[10:0]<=127))
		draw <= logo;
	else
		draw <= 0;
end
endmodule