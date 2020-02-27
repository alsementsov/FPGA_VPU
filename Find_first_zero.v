module Find_first_zero(
  input wire [19:0] p,
	input wire [4:0] decode_in,
  output wire [4:0] R_out,
	output wire [19:0] decode_out);
  reg [4:0] r;
  reg [20:0] selector;
	
 always @ (p) begin
	r= 5'd0;
  if (~p[0])       r = 1;
  else if (~p[1])  r = 2;
  else if (~p[2])  r = 3;
  else if (~p[3])  r = 4;
  else if (~p[4])  r = 5;
  else if (~p[5])  r = 6;
  else if (~p[6])  r = 7;
  else if (~p[7])  r = 8;
  else if (~p[8])  r = 9;
  else if (~p[9])  r = 10;
  else if (~p[10]) r = 11;
  else if (~p[11]) r = 12;
  else if (~p[12]) r = 13;
  else if (~p[13]) r = 14;
  else if (~p[14]) r = 15;
	else if (~p[15]) r = 16;
  else if (~p[16]) r = 17;
  else if (~p[17]) r = 18;
  else if (~p[18]) r = 19;
  else if (~p[19]) r = 20;
 end
 
always @ (decode_in) begin
 selector = 21'd1 << decode_in;
end
 
assign R_out = r;
assign decode_out = selector[20:1];
 
 endmodule 
