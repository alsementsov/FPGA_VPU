module RESET_CPU(
	input wire [3:0] LOSS,
	input wire [4:0] CROSSd,
	input wire [5:0] subc_low,
	input wire [12:0] S,
	output reg reset
	);
		
always @* 
begin

	if ((S==1) &&((LOSS == 5)|| (subc_low == 30)))
		reset <= 1;
	else	if ((LOSS == 7)|| (CROSSd ==30) || (subc_low == 25))
			reset <= 1;
	else
		reset <= 0;
end
endmodule