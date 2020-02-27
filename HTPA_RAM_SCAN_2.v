module HTPA_RAM_SCAN_2(
	input wire clk,
	input wire START,
	input wire [25:0] window,
	output reg [6:0] x,
	output reg [5:0] y,
	output reg set
	);
		
always @(posedge clk) 
begin
	//Запуск
	if (START==1) begin
		x = window[25:19];
		y <= window[18:13];
		set<=1;
	end
	// основной цикл
	else if (set == 1) begin
		x=x+1;
		// сканируем поэлементно матрицу 
		if (x >= window[12:6]) begin
			if (y == window[5:0]) begin
				set<=0;
				y<=0;
				x=0;
			end
			else begin
				y<=y+1;
				x=window[25:19];
			end;
		end
	end
end
endmodule