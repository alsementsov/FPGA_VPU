module Tmax_sv(
	input wire [9:0] T,
	input wire CLK,
	input wire EN,
	input wire RESET,
	input wire [4:0] NUMBER,
	input wire [WIDTH:0] EN_CPU,
	output logic  [9:0] Tout);

	parameter unsigned [4:0] WIDTH = 19;
	
	reg [9:0] TT;
	reg more;
	wire more_t;
	wire [9:0]Ttemp; 
	reg [9:0] Tmax [WIDTH:0];
	
	integer i;
	integer j;

// Триггеры
always_ff @(posedge CLK) begin
	TT<=T;
	more<=more_t;
	for (j=0;j<=WIDTH;j++) begin
		if (EN_CPU[j]) begin
			if (RESET) 
				Tmax[j]<=0;
			else if (more) //update Tmax
				Tmax[j]<=TT;
		end
	end
end
// Мультиплексор+сравнение
always_comb begin
	Ttemp = '0;
	for (i=0;i<=WIDTH;i++) begin 
		if ((i+1)==NUMBER) begin
			Ttemp = Tmax[i]; // mux
			break;
		end
	end
	if ((T>Ttemp)&&(EN==1))
		more_t=1;
	else
		more_t=0;
end

assign Tout = Ttemp;

endmodule