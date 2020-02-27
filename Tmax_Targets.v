module Tmax_Targets(
	input wire [9:0] T,
	input wire clk,
	input wire start_en,
	input wire en,
	input wire end_en,
	input wire reset,
	input wire [3:0] Number,
	input wire BUSY,
	output reg [9:0] Ttemp
	);
reg [9:0]Tmax1_ = 10'd0;
reg [9:0]Tmax2_ = 10'd0;
reg [9:0]Tmax3_ = 10'd0;
reg [9:0]Tmax4_ = 10'd0;
reg [9:0]Tmax5_ = 10'd0;
reg [9:0]Tmax6_ = 10'd0;
reg [9:0]Tmax7_ = 10'd0;
reg [9:0]Tmax8_ = 10'd0;
reg [9:0]Tmax9_ = 10'd0;
reg [9:0]Tmax10_ = 10'd0;
reg [9:0]Tmax11_ = 10'd0;
reg [9:0]Tmax12_ = 10'd0;
reg [9:0]Tmax13_ = 10'd0;
reg [9:0]Tmax14_ = 10'd0;
reg [9:0]Tmax15_ = 10'd0;

reg [9:0] Tcompare;
	
always @(posedge clk) begin
if ((reset==1)) begin
 	case (Number)
		1: Tmax1_ <= 0;
		2: Tmax2_ <= 0;
		3: Tmax3_ <= 0;
		4: Tmax4_ <= 0;
		5: Tmax5_ <= 0;
		6: Tmax6_ <= 0;
		7: Tmax7_ <= 0;
		8: Tmax8_ <= 0;
		9: Tmax9_ <= 0;
		10: Tmax10_ <= 0;
		11: Tmax11_ <= 0;
		12: Tmax12_ <= 0;
		13: Tmax13_ <= 0;
		14: Tmax14_ <= 0;
		15: Tmax15_ <= 0;
	endcase;
end
else begin
// Мультиплексор
 	case (Number)
		1: Ttemp = Tmax1_;
		2: Ttemp = Tmax2_;
		3: Ttemp = Tmax3_;
		4: Ttemp = Tmax4_;		
		5: Ttemp = Tmax5_;
		6: Ttemp = Tmax6_;		
		7: Ttemp = Tmax7_;
		8: Ttemp = Tmax8_;		
		9: Ttemp = Tmax9_;
		10: Ttemp = Tmax10_;		
		11: Ttemp = Tmax11_;
		12: Ttemp = Tmax12_;		
		13: Ttemp = Tmax13_;
		14: Ttemp = Tmax14_;		
		15: Ttemp = Tmax15_;
	endcase;
	//Старт сканирования
	if (start_en==1) 
		Tcompare <= Ttemp;
	// Заполнение при сканировании
	else if ((en==1)&&(T > Tcompare)) 
		Tcompare <= T;
	// конец сканирования
	else if (end_en==1) begin
		case (Number)
			1: Tmax1_ <= Tcompare;
			2: Tmax2_ <= Tcompare;
			3: Tmax3_ <= Tcompare;
			4: Tmax4_ <= Tcompare;
			5: Tmax5_ <= Tcompare;
			6: Tmax6_ <= Tcompare;
			7: Tmax7_ <= Tcompare;
			8: Tmax8_ <= Tcompare;
			9: Tmax9_ <= Tcompare;
			10: Tmax10_ <= Tcompare;
			11: Tmax11_ <= Tcompare;
			12: Tmax12_ <= Tcompare;
			13: Tmax13_ <= Tcompare;
			14: Tmax14_ <= Tcompare;
			15: Tmax15_ <= Tcompare;
		endcase;
	end;
end
end
endmodule