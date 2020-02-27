module CHOISE (
input wire		[4:0] LUT_INDEX,
output reg		[2:0] DATA
);

always
begin
	case(LUT_INDEX)
	11 : 	DATA	<=	3'd1; //
	12	:	DATA	<=	3'd1; //
	
	14	:	DATA	<=	3'd2; //
	15 :	DATA	<=	3'd2; //
	
	17	:	DATA	<=	3'd3; // 
	18	:	DATA	<=	3'd3; // 
	
	20	:	DATA	<=	3'd4; // 
	21	:	DATA	<=	3'd4; // 
	
	default : begin
		DATA	<=	3'd0;
	end
	endcase

end
////////////////////////////////////////////////////////////////////
endmodule