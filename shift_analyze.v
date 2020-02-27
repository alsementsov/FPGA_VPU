module shift_analyze(
	input wire [4:0]dxo_cnt,
	input wire [4:0]dxn_cnt,
	input wire [4:0]dyo_cnt,
	input wire [4:0]dyn_cnt,
	input wire x_same,
	input wire y_same,
	output reg shift
	);	
	 
parameter [4:0] shift_same = 5'd9;
parameter [4:0] shift_x_big = 5'd13;
parameter [4:0] shift_y_big = 5'd15;

always @* begin
	if (((dxo_cnt[4:0]>shift_same)&&(dxn_cnt[4:0]>shift_same)&&(x_same==1))||((dyo_cnt[4:0]>shift_same)&&(dyn_cnt[4:0]>shift_same)&&(y_same==1))||
		 (dxo_cnt[4:0]>shift_x_big)||(dxn_cnt[4:0]>shift_x_big)||(dyo_cnt[4:0]>shift_y_big)||(dyn_cnt[4:0]>shift_y_big))
		shift = 1;
	else 
		shift = 0;
end
endmodule

