module mux_serial(
	input wire [5:0] in,
	input wire [39:0] data,
	output reg out
	);

always @*

	begin
		 case(in)
			0: out=data[0];
			1: out=data[1];
			2: out=data[2];
			3: out=data[3];
			4: out=data[4];
			5: out=data[5];
			6: out=data[6];
			7: out=data[7];
			8: out=data[8];
			9: out=data[9];
			10: out=data[10];
			11: out=data[11];
			12: out=data[12];
			13: out=data[13];
			14: out=data[14];
			15: out=data[15];
			16: out=data[16];
			17: out=data[17];
			18: out=data[18];
			19: out=data[19];
			20: out=data[20];
			21: out=data[21];
			22: out=data[22];
			23: out=data[23];
			24: out=data[24];
			25: out=data[25];
			26: out=data[26];
			27: out=data[27];
			28: out=data[28];
			29: out=data[29];
			30: out=data[30];
			31: out=data[31];
			32: out=data[32];
			33: out=data[33];
			34: out=data[34];
			35: out=data[35];
			36: out=data[36];
			37: out=data[37];
			38: out=data[38];
			39: out=data[39];
		endcase
	end

endmodule	