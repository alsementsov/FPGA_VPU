module SRAM_WINDOW_SCAN(
	input wire clk,
	input wire START,
	input wire [43:0] window,
	output reg [10:0] x,
	output reg [10:0] y,
	output reg set
	);
		
always @(posedge clk) 
begin
	//Запуск
	if (START==1) begin
		x = window[43:33];
		y <= window[32:22];
		set<=1;
	end
	// основной цикл
	else if (set == 1) begin
		x=x+1;
		// сканируем поэлементно матрицу 
		if (x >= window[21:11]) begin
			if (y == window[10:0]) begin
				set<=0;
				y<=0;
				x=0;
			end
			else begin
				y<=y+1;
				x=window[43:33];
			end;
		end
	end
end
endmodule