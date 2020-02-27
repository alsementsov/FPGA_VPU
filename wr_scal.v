module WR_SCAL(
	input wire clk,
	input wire start,
	input wire ack,
	input wire WIP,
	input wire start_ust,
	input wire reset,
	output reg GO = 0,
	output reg write_cal = 0,
	output reg [7:0] instr = 6,
	output reg [15:0] adr = 16'h5800,
	output reg [13:0] Npix = 13'd0,
	output reg RD =0,
	output reg ust_mode
	);
reg cal_end;
reg ust_end; 

always @(posedge clk) begin
if (reset==1)
	adr = 16'd0;
if (GO==1)
	GO <= 0;
if ((start==1)||(start_ust==1)) begin
	write_cal <= 1;
	Npix <= 13'h0000;
	instr <= 6;
	GO <=1;
	if (start==1) begin
		adr=16'h5800;
		ust_mode <= 0;
	end
	else begin
		adr=16'h00D0;
		ust_mode <= 1;
	end
	RD<=0;
end	
else if (write_cal==1) begin
	if (ack==1) begin 
	   // флаг конца калибровки
		if ((Npix==5119)&&(ust_mode==0))
			cal_end = 1;
		else
			cal_end = 0;
		// флаг конца юстировки
		if ((Npix==4)&&(ust_mode==1))
			ust_end = 1;
		else
			ust_end = 0;
		// ОСНОВНОЕ
		if (instr==6) // Уже была разблокировка (сейчас 6)
			instr<=2;
		else if (instr==2) begin // сейчас 2 - делаем первый запрос к WIP (статус записи)
			if (ust_end==1) // это конец!!!
				instr <= 4;
			else begin
				instr<=5; // Инструкция чтения регистра
				RD<=1;
			end
		end
		else if ((instr==5)&&(WIP==0)) begin // Инкремент адреса Npix
			Npix <= Npix+1;
			adr = adr + 2;
			RD<=0;
			if (Npix>=5118)
				instr<=4;
			else
				instr <= 6;
		end
		if ((((Npix>=5119)||(adr<16'h5800))&&(ust_mode==0))||(((Npix>=4)||(adr<16'h00D0))&&(ust_mode==1))) begin
			write_cal<=0;
			Npix <= 13'h0000;
		end
		else
			GO <= 1;
	end;
end;
end
endmodule