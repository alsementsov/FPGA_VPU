module udecoder(
  input wire [4:0] dec_in,
	output reg [22:0] dec_out);
	
	
always @* begin
 dec_out = 23'd1 << dec_in;
end
 
endmodule 
