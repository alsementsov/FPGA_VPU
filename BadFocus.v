module BadFocus(
	input wire hz,
	input wire [8:0] Sigma,
	input wire [7:0] Imean,
	input wire clock,
	output reg focus_bad);
reg [3:0] cnt =0;
reg [2:0] porog =4;

always @(posedge clock) begin
	// Когда грязно
	if (hz==1) begin   	   
		if (Imean<50) 
			porog=5;
		else
			porog =4;
		if (Sigma <= porog) begin
			if (cnt<15)
				cnt=cnt+1;
		end
		else
			cnt=0;
	end;
	if (cnt == 15)
		focus_bad = 1;
	else
		focus_bad = 0;	
end

endmodule