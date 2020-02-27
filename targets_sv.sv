module targets_sv #(parameter unsigned [4:0] WIDTH=19)
(	input  CLK,
	input  LOAD,
	input  [25:0] XY_UPDATE,
	input  RESET,
	input  [WIDTH:0]EN_CPU,
	input  [25:0] XY_CPU,
	input  WR_XY,
	input  FIRE_CPU,
	input  VISIBLE_CPU,
	input  [4:0] SW,
	input  [4:0] VSW,
	output  [25:0] XY_CROSS [WIDTH:0],
	output  [25:0] XY [WIDTH:0],
	output  [WIDTH:0] CROSS,
	output  [WIDTH:0] BUSY,
	output  [WIDTH:0] CROSSd,
	output  [WIDTH:0] FIRE,
	output  [WIDTH:0] VISIBLE,
	output  wire [55:0] SW_OUT='0,
	output  wire [26:0] VSW_OUT='0);

integer i;

generate
genvar k;
	for (k=0;k<=WIDTH;k++)	begin :gentarget
		HTARGET (.LOAD(LOAD),
							.CLK(CLK),
							.EN_CPU(EN_CPU[k]),
							.RESET(RESET),
							.WR_XY(WR_XY),
							.FIRE_CPU(FIRE_CPU),
							.VISIBLE_CPU(VISIBLE_CPU),
							.XY_CPU(XY_CPU),
							.XY_UPDATE(XY_UPDATE),
							.CROSS(CROSS[k]),
							.BUSY(BUSY[k]),
							.CROSSd(CROSSd[k]),
							.FIRE(FIRE[k]),
							.VISIBLE(VISIBLE[k]),
							.XY(XY[k]),
							.XY_CROSS(XY_CROSS[k]));
	end
endgenerate	

always_comb begin
	SW_OUT = '0;
	for (i=1;i<=WIDTH+1;i++) begin 
		if (i==SW) begin
			SW_OUT = {CROSSd[i-1],XY[i-1],CROSS[i-1],BUSY[i-1],XY_CROSS[i-1],FIRE[i-1]};
			break;
		end
	end	
end
always_comb begin
	VSW_OUT = '0;
	for (i=1;i<=WIDTH+1;i++) begin 
		if (i==VSW) begin
			VSW_OUT = {XY[i-1],BUSY[i-1]};
			break;
		end
	end
end
endmodule