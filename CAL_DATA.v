module CAL_DATA(
	input wire clk,
	input wire EN,
	input wire [7:0] DATA,
	input wire [7:0] DATA_DFF,
	input wire [14:0] ADR,
	
	output reg [31:0] PixCmin,
	output reg [31:0] PixCmax,
	output reg [7:0] gradScale,
	output reg [7:0] epsilone,
	output reg [7:0] MBIT_cal,
	output reg [7:0] BIAS_cal,
	output reg [7:0] CLK_cal,
	output reg [7:0] BPA_cal,
	output reg [7:0] PU_cal,
	output reg [7:0] Arraytype,
	output reg [15:0] VddCalib,
	output reg [31:0] PTAT_gradient,
	output reg [31:0] PTAT_offset,
	output reg [7:0] VddScGrad,
	output reg [7:0] VddScOff,
	output reg [7:0] GloballOff,
	output reg [15:0] GlobalGain,
	output reg [15:0] DeviceID,
	output reg [7:0] NrOfDefPix,
	output reg [14:0] Adr_cal = 0,
	output reg [15:0] Data_cal,
	output reg ThGrad_en,
	output reg ThOffset_en,
	output reg P_en,
	output reg VddCompGrad_en,
	output reg VddCompOff,
	output reg DeadPix_en,
	output reg [15:0] XO = 294,
	output reg [15:0] W = 1406,
	output reg [15:0] YO = 0,
	output reg [15:0] H = 1080
	);

reg [14:0] adr_temp = 15'h0000;
reg [14:0] shift = 15'h0000;
	
always @(posedge clk) begin
if (EN==1) begin	
	case(ADR)
		// Запись данных EEPROM в регистры для расчета температуры по формулам 
		15'h0000: PixCmin[7:0] <= DATA;
		15'h0001: PixCmin[15:8] <= DATA;
		15'h0002: PixCmin[23:16] <= DATA;
		15'h0003: PixCmin[31:24] <= DATA;
		15'h0004: PixCmax[7:0] <= DATA;
		15'h0005: PixCmax[15:8] <= DATA;
		15'h0006: PixCmax[23:16] <= DATA;
		15'h0007: PixCmax[31:24] <= DATA;
		15'h0008: gradScale <= DATA;
		15'h000D: epsilone <= DATA;
		15'h001A: MBIT_cal <= DATA;
		15'h001B: BIAS_cal <= DATA;
		15'h001C: CLK_cal <= DATA;
		15'h001D: BPA_cal <= DATA;
		15'h001E: PU_cal <= DATA;
		15'h0026: VddCalib[7:0] <= DATA;
		15'h0027: VddCalib[15:8] <= DATA;
		15'h0034: PTAT_gradient[7:0] <= DATA;
		15'h0035: PTAT_gradient[15:8] <= DATA;
		15'h0036: PTAT_gradient[23:16] <= DATA;
		15'h0037: PTAT_gradient[31:24] <= DATA;
		15'h0038: PTAT_offset[7:0] <= DATA;
		15'h0039: PTAT_offset[15:8] <= DATA;
		15'h003A: PTAT_offset[23:16] <= DATA;
		15'h003B: PTAT_offset[31:24] <= DATA;
		15'h004E: VddScGrad <= DATA;
		15'h004F: VddScOff <= DATA;
		15'h0054: GloballOff <= DATA;
		15'h0055: GlobalGain[7:0] <= DATA;
		15'h0056: GlobalGain[15:8] <= DATA;
		15'h0074: DeviceID [7:0] <= DATA;
		15'h0075: DeviceID [15:8] <= DATA;
		15'h007F: begin NrOfDefPix <= DATA; Adr_cal<=0;end
		15'h00D0: XO[7:0] <= DATA;
		15'h00D1: XO[15:8] <= DATA;
		15'h00D2: W [7:0] <= DATA;
		15'h00D3: W [15:8] <= DATA;
		15'h00D4: YO[7:0] <= DATA;
		15'h00D5: YO[15:8] <= DATA;
		15'h00D6: H [7:0] <= DATA;
		15'h00D7: H [15:8] <= DATA;
		default: begin // Запись матричных данных калибровки в ОЗУ 
			if ((ADR>=15'h1C00)&&(ADR<15'h3000)) begin
				ThGrad_en <=1;
				ThOffset_en <=0;
				P_en <= 0;
				VddCompGrad_en <= 0;
				VddCompOff <= 0;
				DeadPix_en <=0;
				Adr_cal <= ADR - 15'h1C00;
				Data_cal[7:0] <= DATA;
			end
			else begin
				ThGrad_en <=0;
				// Битые пикселы
				if ((ADR >= 15'h0080)&&(ADR < 15'h00AF)&&(Adr_cal < NrOfDefPix)) begin
					ThOffset_en <=0;
					P_en <= 0;
					VddCompGrad_en <= 0;
					VddCompOff <= 0;
					DeadPix_en <=1;
					shift = 15'h0080;
				end
				// Р(i,j)
				else if (ADR>=15'h5800) begin
					ThOffset_en <=0;
					P_en <= 1;
					VddCompGrad_en <= 0;
					VddCompOff <= 0;
					DeadPix_en <=0;
					shift = 15'h5800;
				end
				else if (ADR>=15'h3000) begin
					ThOffset_en <=1;
					P_en <= 0;
					VddCompGrad_en <= 0;
					VddCompOff <= 0;
					DeadPix_en <=0;
					shift = 15'h3000;
				end
				else if (ADR>=15'h1200) begin
					ThOffset_en <=0;
					P_en <= 0;
					VddCompGrad_en <= 0;
					VddCompOff <= 1;
					DeadPix_en <=0;
					shift = 15'h1200;
				end
				else if (ADR>=15'h0800) begin
					ThOffset_en <=0;
					P_en <= 0;
					VddCompGrad_en <= 1;
					VddCompOff <= 0;
					DeadPix_en <=0;
					shift = 15'h0800;
				end			
				else begin
					ThOffset_en <=0;
					P_en <= 0;
					VddCompGrad_en <= 0;
					VddCompOff <= 0;
					DeadPix_en <=0;
				end;
				adr_temp = ADR - shift;
				Adr_cal[13:0] <= adr_temp[14:1];
				Data_cal[15:8] <= DATA;
				Data_cal[7:0] <= DATA_DFF;
			end
		end
	endcase;
end
else begin
	ThGrad_en <=0;
	ThOffset_en <=0;
	P_en <= 0;
	VddCompGrad_en <= 0;
	VddCompOff <= 0;
if (Adr_cal >= NrOfDefPix)
	DeadPix_en<=0;
end
end
endmodule