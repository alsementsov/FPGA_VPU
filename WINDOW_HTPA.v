module WINDOW_HTPA(
	input wire [10:0] X,
	input wire [10:0] Y,
	input wire [10:0] XO,
	input wire [10:0] XN,	
	input wire [10:0] YO,
	input wire [10:0] YN,
	output reg windows
	);

always @*	begin
	if ((X >= XO)&&(X <= XN)&&(Y >= YO)&&(Y < YN))
		windows = 1;
	else
		windows = 0;
end

endmodule	