// Остановка MOSI
module htpa_mosi(
	input wire [5:0] in,
	input wire rd,
	input wire [7:0] adr,
	input wire eeprom_cs,
	output reg stop_mosi
	);

always @ (in,rd,eeprom_cs) begin
	stop_mosi=0;
	if (eeprom_cs == 0) begin //Матрица
		if ((rd == 1)&&(in == 8)) 
			stop_mosi = 1;
		else if ((rd == 0)&&(in==16)) 
			stop_mosi = 1;	
	end
	else begin //Чтение данных EEPROM по адресу (8-инструкция, 16 адрес)
		if (rd == 1) begin
			if ((adr==5)&&(in==8)) 
				stop_mosi = 1;	
			else if (in==24)
				stop_mosi = 1;	
		end
		else begin //Запись в EEPROM
			if(((adr==6)||(adr==4)||(adr==5))&&(in==8)) 
				stop_mosi = 1;			
			else if (in==40)
				stop_mosi = 1;
		end
	end	
end
endmodule	