module Draw_cifra(
	input wire clk,
	input wire [10:0] Y,
	input wire [12:0] PTAT,
	input wire [12:0] YMEAN,
	input wire [12:0] S,
	input wire [12:0] divady,
	input wire [12:0] thfire,
	input wire [12:0] summaall,
	input wire [12:0] subf,
	input wire [12:0] subc,
	input wire [12:0] vsubf,
	input wire [12:0] vsubc,
	input wire [12:0] tmax,
	input wire [12:0] adyo,
	input wire [12:0] yochange,
	input wire [12:0] yomove,
	input wire [13:0] syncdy,
	input wire [13:0] syncdx,
	input wire [12:0] VI,
	input wire [12:0] TFrame,
	input wire [12:0] THmax,
	input wire [12:0] FireAlarm_cnt,
	input wire [12:0] FD_life,
	output reg [12:0] cifra,
	output reg znak,
	output reg [10:0] YO
	);
	reg flag = 0;
	
always @ (posedge clk)	begin
	flag = 1;
	znak =0;
	case(Y) 
		11'h040: begin
			cifra <= PTAT;
		end
		11'h60: begin
			cifra <= YMEAN;
		end
		11'h080: begin
			cifra <= TFrame; 
		end
		//
		11'h0C0: begin
			cifra <= VI; 
		end
		11'h0E0: begin
			cifra <= S;
		end
		//
		11'h120: begin
			cifra <= thfire;
		end
		11'h140: begin
			cifra <= summaall;
		end
		//
		11'h180: begin
			cifra <= tmax;
		end
			11'h1A0: begin
			cifra <= divady;
		end
		//
		11'h1E0: begin
			cifra <= subf;
		end
		11'h200: begin
			cifra <= subc;
		end
		11'h220: begin
			cifra <= vsubf;
		end
		11'h240: begin
			cifra <= vsubc;
		end
		//
		11'h260: begin
			cifra <= syncdy[12:0];
			znak = syncdy[13];
		end
		11'h280: begin
			cifra <= syncdy[12:0];
			znak = syncdy[13];
		end
		11'h2A0: begin
			cifra <= syncdx[12:0];
			znak = syncdx[13];
		end
		11'h2C0: begin
			cifra <= adyo;
		end
		11'h2E0: begin
			cifra <= yomove;
		end
		11'h300: begin
			cifra <= yochange;
		end
		11'h320: begin
			cifra <= THmax;
		end
		11'h340: begin
			cifra <= FireAlarm_cnt;
		end
		 11'h360: begin
			cifra <= FD_life;
		end
		default flag = 0; 
	endcase;
	if (flag == 1)
		YO <= Y;
end

endmodule	