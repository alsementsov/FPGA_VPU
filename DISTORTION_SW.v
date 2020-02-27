// Остановка MOSI
module DISTORTION_SW(
	input wire [6:0] XC,
	input wire [6:0] XD,
	input wire [6:0] YC,
	input wire [6:0] YD,
	input wire [6:0] Wext,
	input wire [6:0] Hext,	
	input wire distortion_mode,
	output reg [6:0] Xnumer,
	output reg [6:0] Xdenom,
	output reg [6:0] Ynumer,
	output reg [6:0] Ydenom
	);

always @* begin
	if (distortion_mode) begin
		Xnumer<=XD;
		Xdenom<=80+Wext;
		Ynumer<=YD;
		Ydenom<=64+Hext;
	end
	else begin
		Xnumer<=XC;
		Xdenom<=80;
		Ynumer<=YC;
		Ydenom<=64;
	end
end	
endmodule	