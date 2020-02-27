module more1023(
	input wire [9:0] DATA_READ,
	input wire [7:0] subred,
	input wire [9:0] blue,
	output reg [9:0] Y,
	output reg [9:0] CB,
	output reg [9:0] CR);	

always @* begin
// Синий
if (DATA_READ < 240)  begin
	Y[9:1] = DATA_READ[8:0];
	Y[0] = 1;
	CB = 10'h205;
	CR = 10'h200+DATA_READ[9:0];
end
// Красный
//else if ((DATA_READ >= 10'h200)&&(DATA_READ <= 10'h2FF))  begin 
//	Y[9] = 0;
//	Y[0] = 0;
//	Y[8:1] = DATA_READ;
//	CB = 10'h300;
//	CR = 10'h200;
//end
//Желтый
else begin
	Y = DATA_READ[9:0]; 
	CB = blue;
	CR = 255;	
end;
end
endmodule