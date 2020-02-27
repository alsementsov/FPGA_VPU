module HTPA_RAM_SCAN_stable(
	input wire clk,
	input wire START,
	output reg [6:0] x,
	output reg [5:0] y,
	output reg set,
	output reg hsync,
	output reg non_active
	);
		
always @(posedge clk) 
begin
	//Запуск
	if (START==1) begin
		x = 0;
		y <= 0;
		set<=1;
		non_active <=0;
	end
	// основной цикл
	else if (set == 1) begin
		// сканируем поэлементно матрицу 
		x=x+1;
		case (x)
			82: non_active <=1;
			84: begin 
				if (y==63) begin // конец кадра
					set<=0;
					y<=0;
					x=0;
				end
				else
					hsync<=1;
					y <= y+1;
			end
			85: hsync<=0;
			86: begin 
				non_active <=0;
				x=0;
			end
		endcase;
	end
end
endmodule