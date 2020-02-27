module WINDOW_cifra(
	input wire clk,
	input wire [10:0] X,
	input wire [1:0] Xt,
	input wire [1:0] Xtt,
	input wire [1:0] Xttt,
	input wire [10:0] Y,
	input wire [10:0] YO,
	input wire znak,
	input wire [3:0] cifra_XXXX,
	input wire [3:0] cifra_XXX,
	input wire [3:0] cifra_XX,
	input wire [3:0] cifra_X,
	output reg window,
	output reg [3:0] sw,
	output reg [1:0] x_cf
	);
	
parameter [10:0] XO = 1807;
reg [10:0] YN;
reg four;
reg three;
reg two;
reg one;

always @ (posedge clk)	begin
	four = (cifra_XXXX == 0);
	three = (cifra_XXX == 0) && four;
	two = (cifra_XX == 0) && three;
	one = (cifra_X == 0) && two;
	YN = YO+16;
	if ((X >= XO)&&(Y >= YO)&&(Y < YN)) begin
		if (X < 1823) begin
			x_cf <= X[3:2];
			if (znak == 1) begin
				sw <= 10;
				window <= 1;
			end
			else begin
				sw <= 11;
				window <= 0;
			end
		end
		else if (X<1825) begin
			window <= 0;
			sw <= 11;
		end
		else if (X < 1841) begin
			x_cf <= X[3:2];
			if (four==0)
				window <= 1;
			sw <= cifra_XXXX;
		end
		else if (X<1843) begin
			window <= 0;
			sw <= 11;
		end
		else if (X < 1859) begin
			x_cf <= Xt[1:0];
			if (three==0)			
				window <= 1;
			sw <= cifra_XXX;
		end	
		else if (X<1861) begin
			window <= 0;
			sw <= 11;
		end
		else if (X < 1877) begin
			x_cf <= Xtt[1:0];
			if (two == 0)
				window <= 1;
			sw <= cifra_XX;
		end
		else if (X<1879) begin
			window <= 0;
			sw <= 11;
		end
		else if (X < 1895) begin
			x_cf <= Xttt[1:0];
			if (one==0)
				window <= 1;
			sw <= cifra_X;
		end
		else begin
			window <= 0;
			sw <= 11;
		end
	end
	else begin
		window <=0;
		sw <= 11;
	end
end

endmodule	