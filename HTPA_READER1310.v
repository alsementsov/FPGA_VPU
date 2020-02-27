module HTPA_READER1310(
	input wire clk,
	input wire reset,
	input wire START,
	input wire ACK,
	input wire [7:0] DATA_READ,
	input HSYNC,
	input wire [7:0] BIAS_TRIM,
	input wire [7:0] BPA_TRIM,
	input wire [7:0] CLK_TRIM,
	input wire [9:0] Tdelay,
	input wire [15:0] Nbytes,
	output reg GO,
	output reg [7:0]ADR_HTPA,
	output reg RD,
	output reg [3:0]WRITE_DATA_L,
	output reg [3:0]WRITE_DATA_H,
	output reg [15:0]BYTES,
	output reg complete,
	output reg mirror,
	output reg offset = 0,
	output reg wait_htpa = 0,
	output reg [3:0] BLOCK,
	output reg frame_ready = 0
	);
reg read;	
reg [3:0] cnt = 0;	
reg [3:0] cnt_buf = 0;	
reg [3:0] CONFIG = 4'b1011;
reg [9:0] wait_cnt = 0;

		
always @(posedge clk) begin
if(reset==1) begin	
	GO <= 0;
	ADR_HTPA <= 8'd1;
	WRITE_DATA_L <= 4'd0;
	WRITE_DATA_H <= 4'd0;
	RD <= 1;
	BYTES <= 16'd1;
	BLOCK = 4'd0;
	cnt=0;
	cnt_buf = 0;
	CONFIG = 4'b1011;
	read <= 0;
	complete <= 0;
	wait_cnt <= 0;
	offset = 0;
	wait_htpa <= 0;
	frame_ready <= 0;
	mirror <=0;
end
else begin
	if (frame_ready == 1)
		frame_ready <= 0;
	if (GO==1) 
		GO <=0;
	if (complete==1) 
		complete <=0;
	// ВКЛЮЧАЕМ HTPA //
	if (START == 1) begin
		ADR_HTPA <= 8'h01;
		WRITE_DATA_L <= 4'b0001;
		WRITE_DATA_H <= 4'b0000;
		RD <= 0;
		BYTES <= 16'd1;
		cnt_buf = 0;
		GO <= 1;
	end;
	// Запись регистров в HTPA //
	if (read==0) begin
		if ((cnt>0) && (cnt_buf > 4'd11)) begin  
			ADR_HTPA[7:4] <= 4'd0;
			ADR_HTPA[3:0] <= cnt+4'd3;
			if (cnt < 3) begin				
				WRITE_DATA_L <= BIAS_TRIM[3:0];
				WRITE_DATA_H <= BIAS_TRIM[7:4];

			end
			else if (cnt==3) begin
				WRITE_DATA_L <= CLK_TRIM[3:0];
				WRITE_DATA_H <= CLK_TRIM[7:4];

			end
			else begin
				WRITE_DATA_L <= BPA_TRIM[3:0];
				WRITE_DATA_H <= BPA_TRIM[7:4];
			end
			RD <= 0;
			BYTES <= 16'd1;
			cnt_buf = 0;
			GO <= 1;
		end
	end
	//// ЧТЕНИЕ HTPA в цикле ////
	else begin 
		if (cnt_buf > 4'd11) begin
			mirror <= 0;	
			case(cnt)
				// 1 - Включение N-го блока
				1: begin 
					ADR_HTPA <= 8'h01;
					WRITE_DATA_L <= CONFIG;
					WRITE_DATA_H <= BLOCK;
					RD <= 0;
					BYTES <= 16'd1;
					wait_htpa<=1;
				end
				// 2 - чтение блока #0 TOP HALF 
				2: begin
					ADR_HTPA <= 8'h0A;
					WRITE_DATA_L <= 4'd0;
					WRITE_DATA_H <= 4'd0;
					RD <= 1;
					BYTES <= Nbytes;
				end
				// 3 - чтение блока #0 Bottom HALF 
				3: begin
					ADR_HTPA <= 8'h0B;
					WRITE_DATA_L <= 4'd0;
					WRITE_DATA_H <= 4'd0;
					RD <= 1;
					BYTES <= Nbytes;
					mirror <= 1;
				end
				// 4 - ВЫКЛЮЧЕНИЕ БЛОКА
				4: begin
					ADR_HTPA <= 8'h01;
					WRITE_DATA_L <= 4'b0001;
					WRITE_DATA_H <= BLOCK;
					RD <= 0;
					BYTES <= 16'd1;
				end
			endcase;
			cnt_buf = 0;
			GO <= 1;
		end
	end //конец цикла чтения

	// Если Конец транзакции	
	if (ACK == 1) begin
		if (read==1) begin
			if (cnt > 3'd1) begin
				cnt_buf = 1; // старт задержки транзакций
				cnt=cnt+1; // счетчик транзакций	
				//////для Чтения//////////
				// переключение блоков - выставляем запись и ждем 
				if (cnt > 4)  begin 
					cnt=1;
					if (offset == 1) begin // если оffset начинаем опять с 0 блока, но со сброшенным оффсетом
						BLOCK = 4'd0;
						offset <= 0;
						CONFIG = 4'b1001;
					end
					else begin
						BLOCK = BLOCK+1;
						if (BLOCK > 4'd0) begin
							if (BLOCK >= 4'd4) begin 
							// ЗАПУСК ПО НОВОМУ ЦИКЛУ !!!!!!!
								cnt=1;
								offset <= 1; // Начинаем с Offset!
								mirror <= 0;
								CONFIG = 4'b1111; // Читаем не PTAT, а VDD
								wait_cnt <= 0;
								complete <=1;
								wait_htpa <=0;
								BLOCK =4'd0;
								frame_ready <= 1; // Сигнал готовности кадра
							end
							else begin // обычный проход
								CONFIG = 4'b1001;
								offset <= 0;	// offset read
							end;
						end;
					end;
				end
			end
		end
		///// Выключение ЗАПИСИ регистров///////////////
		else begin
			cnt_buf = 1; // старт задержки транзакций
			cnt=cnt+1;
			if (cnt==6) begin
				read<=1;
				cnt=1;
				offset <= 1;
				mirror <= 0;
				CONFIG = 4'b1011;
				wait_cnt <= 0;
				BLOCK = 4'd0;
			end
		end
	end;
	// Ждем считывания матрицы
	if (wait_htpa==1) begin
		if (HSYNC==1) 
			wait_cnt <= wait_cnt+1;
		if (wait_cnt >= Tdelay) begin //432
			wait_htpa <= 0;
			wait_cnt <= 0;
			cnt=2;
			cnt_buf = 12;
		end;
	end;
	// Задержка транзакций
	if (cnt_buf > 0)
		cnt_buf=cnt_buf+1; 
	end
end
endmodule