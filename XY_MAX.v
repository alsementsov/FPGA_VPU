module XY_MAX(
	input wire [25:0] BCROSS,
	input wire [25:0] BCROSS_OLD,
	input wire cross,
	output reg [25:0] BCROSS_OUT
	);
	
always @* 
begin

	// XO
	if ((BCROSS[25:19] > BCROSS_OLD[25:19])||(cross==0))
		BCROSS_OUT[25:19]<= BCROSS_OLD[25:19];
	else
		BCROSS_OUT[25:19]<= BCROSS[25:19];
	
	// YO
	if ((BCROSS[18:13] > BCROSS_OLD[18:13])||(cross==0)) 
		BCROSS_OUT[18:13]<= BCROSS_OLD[18:13];
	else
		BCROSS_OUT[18:13]<= BCROSS[18:13];		
	
	// XN
	if ((BCROSS[12:6] < BCROSS_OLD[12:6])||(cross==0)) 
		BCROSS_OUT[12:6]<= BCROSS_OLD[12:6];
	else
		BCROSS_OUT[12:6]<= BCROSS[12:6];
	
	// YN
	if ((BCROSS[5:0] < BCROSS_OLD[5:0])||(cross==0))
		BCROSS_OUT[5:0]<= BCROSS_OLD[5:0];
	else
		BCROSS_OUT[5:0]<= BCROSS[5:0];		

end
endmodule