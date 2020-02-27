module Dead_Compare(
	input wire clk,
	input wire WR,
	input wire [6:0] x_in,
	input wire [5:0] y_in,
	input wire [4:0] Number,
	input wire [6:0] x_read,
	input wire [5:0] y_read,
	input wire strobe_rd,
	output reg Pix_dead
	);
reg [6:0] deadPix0_x = 7'd100;
reg [6:0]deadPix1_x = 7'd100;
reg [6:0]deadPix2_x = 7'd100;
reg [6:0]deadPix3_x = 7'd100;
reg [6:0]deadPix4_x = 7'd100;
reg [6:0]deadPix5_x = 7'd100;
reg [6:0]deadPix6_x = 7'd100;
reg [6:0]deadPix7_x = 7'd100;
reg [6:0]deadPix8_x = 7'd100;
reg [6:0]deadPix9_x = 7'd100;
reg [6:0]deadPix10_x = 7'd100;
reg [6:0]deadPix11_x = 7'd100;
reg [6:0]deadPix12_x = 7'd100;
reg [6:0]deadPix13_x = 7'd100;
reg [6:0]deadPix14_x = 7'd100;
reg [6:0]deadPix15_x = 7'd100;
reg [6:0]deadPix16_x = 7'd100;
reg [6:0]deadPix17_x = 7'd100;
reg [6:0]deadPix18_x = 7'd100;
reg [6:0]deadPix19_x = 7'd100;
reg [6:0]deadPix20_x = 7'd100;
reg [6:0]deadPix21_x = 7'd100;
reg [6:0]deadPix22_x = 7'd100;
reg [6:0]deadPix23_x = 7'd100;
reg [6:0]deadPix0_y = 6'd0;
reg [6:0]deadPix1_y = 6'd0;
reg [6:0]deadPix2_y = 6'd0;
reg [6:0]deadPix3_y = 6'd0;
reg [6:0]deadPix4_y = 6'd0;
reg [6:0]deadPix5_y = 6'd0;
reg [6:0]deadPix6_y = 6'd0;
reg [6:0]deadPix7_y = 6'd0;
reg [6:0]deadPix8_y = 6'd0;
reg [6:0]deadPix9_y = 6'd0;
reg [6:0]deadPix10_y = 6'd0;
reg [6:0]deadPix11_y = 6'd0;
reg [6:0]deadPix12_y = 6'd0;
reg [6:0]deadPix13_y = 6'd0;
reg [6:0]deadPix14_y = 6'd0;
reg [6:0]deadPix15_y = 6'd0;
reg [6:0]deadPix16_y = 6'd0;
reg [6:0]deadPix17_y = 6'd0;
reg [6:0]deadPix18_y = 6'd0;
reg [6:0]deadPix19_y = 6'd0;
reg [6:0]deadPix20_y = 6'd0;
reg [6:0]deadPix21_y = 6'd0;
reg [6:0]deadPix22_y = 6'd0;
reg [6:0]deadPix23_y = 6'd0;
reg [6:0] compare_x = 7'd90;
reg [5:0] compare_y = 6'd0;
reg [5:0] Num = 0;
	
always @(posedge clk) begin
if (WR==1) begin
	Num <= Number;
	Pix_dead <=0;
	end
else begin
	if (strobe_rd==1) begin
		Pix_dead <=0;
		Num <= 0;
	end
	else
		Num<=Num+1;
end;		

case(Num)
	// Запись данных EEPROM в регистры для расчета температуры по формулам 
	0: begin 
		if (WR==1) begin 
			deadPix0_x = x_in;
			deadPix0_y = y_in; 
		end;
		compare_x = deadPix0_x;
		compare_y = deadPix0_y;
	end
	1: begin 
		if (WR==1) begin 
			deadPix1_x <= x_in;
			deadPix1_y<=y_in; 
		end;
		compare_x = deadPix1_x;
		compare_y = deadPix1_y;
	end
	2: begin 
		if (WR==1) begin 
			deadPix2_x <= x_in;
			deadPix2_y<=y_in; 
		end;
		compare_x = deadPix2_x;
		compare_y = deadPix2_y;
	end	
	3: begin 
		if (WR==1) begin 
			deadPix3_x <= x_in;
			deadPix3_y<=y_in; 
		end;
		compare_x = deadPix3_x;
		compare_y = deadPix3_y;
	end	
	4: begin 
		if (WR==1) begin 
			deadPix4_x <= x_in;
			deadPix4_y<=y_in; 
		end;
		compare_x = deadPix4_x;
		compare_y = deadPix4_y;
	end	
	5: begin 
		if (WR==1) begin 
			deadPix5_x <= x_in;
			deadPix5_y<=y_in; 
		end;
		compare_x = deadPix5_x;
		compare_y = deadPix5_y;
	end	
	6: begin 
		if (WR==1) begin 
			deadPix6_x <= x_in;
			deadPix6_y<=y_in; 
		end;
		compare_x = deadPix6_x;
		compare_y = deadPix6_y;
	end	
	7: begin 
		if (WR==1) begin 
			deadPix7_x <= x_in;
			deadPix7_y<=y_in; 
		end;
		compare_x = deadPix7_x;
		compare_y = deadPix7_y;
	end	
	8: begin 
		if (WR==1) begin 
			deadPix8_x <= x_in;
			deadPix8_y<=y_in; 
		end;
		compare_x = deadPix8_x;
		compare_y = deadPix8_y;
	end	
	9: begin 
		if (WR==1) begin 
			deadPix9_x <= x_in;
			deadPix9_y<=y_in; 
		end;
		compare_x = deadPix9_x;
		compare_y = deadPix9_y;
	end	
	10: begin 
		if (WR==1) begin 
			deadPix10_x <= x_in;
			deadPix10_y<=y_in; 
		end;
		compare_x = deadPix10_x;
		compare_y = deadPix10_y;
	end	
	10: begin 
		if (WR==1) begin 
			deadPix10_x <= x_in;
			deadPix10_y<=y_in; 
		end;
		compare_x = deadPix10_x;
		compare_y = deadPix10_y;
	end
	11: begin 
		if (WR==1) begin 
			deadPix11_x <= x_in;
			deadPix11_y<=y_in; 
		end;
		compare_x = deadPix11_x;
		compare_y = deadPix11_y;
	end	
	12: begin 
		if (WR==1) begin 
			deadPix12_x <= x_in;
			deadPix12_y<=y_in; 
		end;
		compare_x = deadPix12_x;
		compare_y = deadPix12_y;
	end	
	13: begin 
		if (WR==1) begin 
			deadPix13_x <= x_in;
			deadPix13_y<=y_in; 
		end;
		compare_x = deadPix13_x;
		compare_y = deadPix13_y;
	end	
	14: begin 
		if (WR==1) begin 
			deadPix14_x <= x_in;
			deadPix14_y<=y_in; 
		end;
		compare_x = deadPix14_x;
		compare_y = deadPix14_y;
	end	
	15: begin 
		if (WR==1) begin 
			deadPix15_x <= x_in;
			deadPix15_y<=y_in; 
		end;
		compare_x = deadPix15_x;
		compare_y = deadPix15_y;
	end	
	16: begin 
		if (WR==1) begin 
			deadPix16_x <= x_in;
			deadPix16_y<=y_in; 
		end;
		compare_x = deadPix16_x;
		compare_y = deadPix16_y;
	end
	17: begin 
		if (WR==1) begin 
			deadPix17_x <= x_in;
			deadPix17_y<=y_in; 
		end;
		compare_x = deadPix17_x;
		compare_y = deadPix17_y;
	end
	18: begin 
		if (WR==1) begin 
			deadPix18_x <= x_in;
			deadPix18_y<=y_in; 
		end;
		compare_x = deadPix18_x;
		compare_y = deadPix18_y;
	end	
	19: begin 
		if (WR==1) begin 
			deadPix19_x <= x_in;
			deadPix19_y<=y_in; 
		end;
		compare_x = deadPix19_x;
		compare_y = deadPix19_y;
	end	
	20: begin 
		if (WR==1) begin 
			deadPix20_x <= x_in;
			deadPix20_y<=y_in; 
		end;
		compare_x = deadPix20_x;
		compare_y = deadPix20_y;
	end
	21: begin 
		if (WR==1) begin 
			deadPix21_x <= x_in;
			deadPix21_y<=y_in; 
		end;
		compare_x = deadPix21_x;
		compare_y = deadPix21_y;
	end	
	22: begin 
		if (WR==1) begin 
			deadPix22_x <= x_in;
			deadPix22_y<=y_in; 
		end;
		compare_x = deadPix22_x;
		compare_y = deadPix22_y;
	end	
	23: begin 
		if (WR==1) begin 
			deadPix23_x <= x_in;
			deadPix23_y<=y_in; 
		end;
		compare_x = deadPix23_x;
		compare_y = deadPix23_y;
	end	
endcase;
if ((compare_x == x_read) && (compare_y == y_read))
	Pix_dead <=1;

end
endmodule