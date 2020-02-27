
module HTPA_XY_PLUS(
	input wire [6:0]xo,
	input wire [6:0]xn,
	input wire [5:0]yo,
	input wire [5:0]yn,
	
	input wire [8:0] dcross,
	output reg  [6:0] XO_PLUS,
	output reg  [5:0] YO_PLUS, 
	output reg  [6:0] XN_PLUS,  
	output reg  [5:0] YN_PLUS 
	);


reg [1:0] gap;

always @*
	begin
		// Зона поиска
		if (dcross[8]==1)
			gap = 2'd0;
		else 	
			gap = dcross[1:0];	
		
		// Расширение границ
		if (gap <= yo)
			YO_PLUS = yo - gap;
		else
			YO_PLUS = 0;
		
		if (yn > 60)	
			YN_PLUS = 63;
		else
			YN_PLUS = yn + gap;
			
		if (gap<=xo)
			XO_PLUS = xo - gap;
		else
			XO_PLUS = 0;

		XN_PLUS = xn + gap;	
	end 
	
endmodule




