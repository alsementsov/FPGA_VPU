module HTPA_DRAW_sv(
	input wire [6:0] X,
	input wire [5:0] Y,
	input wire [WIDTH:0] busy,
	input wire [25:0] IN [WIDTH:0],
	input wire [WIDTH:0] firein,
	output logic  draw,
	output logic  fire_draw,
	output logic box_draw,
	output logic fire);

	// WIDTH - numbers of Targets
	parameter  unsigned [4:0] WIDTH =  5'd19;
	integer i;
	wire [6:0] xp;
	wire [5:0] yp;
	wire [6:0] xo [WIDTH:0];
	wire [5:0] yo [WIDTH:0];
	wire [6:0] xn [WIDTH:0];
	wire [5:0] yn [WIDTH:0];
	wire [WIDTH:0] box_draw_tmp;
	wire [WIDTH:0] draw_tmp;
	wire [WIDTH:0] fire_draw_tmp;
	
assign xp = X+7'd2;
assign yp = (Y>6'd61) ? 63 : (Y+6'd2);
//

generate
genvar k;
	for (k=0;k<=WIDTH;k=k+1)
	begin :assi
		assign xo[k]=IN[k][25:19];
		assign yo[k]=IN[k][18:13];
		assign xn[k]=IN[k][12:6];
		assign yn[k]=IN[k][5:0];
	end
endgenerate	
	
always @* begin
	for (i=0;i<=WIDTH;i=i+1) begin
		box_draw_tmp[i] = 0;
		draw_tmp[i]= 0;
		fire_draw_tmp[i] = 0; 
		if ((busy[i]==1)&&(yp>=yo[i])&&(Y<=yn[i])&&(xp>=xo[i])&&(X<=xn[i])) begin
			box_draw_tmp[i] = 1;
			if (firein[i]==1) 
				fire_draw_tmp[i] = 1;
			if ((xo[i]==xp)||(xn[i]==X)||(yo[i]==yp)||(yn[i] ==Y))
				draw_tmp[i]= 1;
		end
	end
	
end

assign box_draw = |box_draw_tmp;
assign draw = |draw_tmp;
assign fire_draw = |fire_draw_tmp;
assign fire = |firein;
endmodule