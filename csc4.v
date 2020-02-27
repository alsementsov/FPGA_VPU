//---------------------------------------------------------------------------
`timescale 1ps/1ps

module csc4 (
	    y,
	    cb,
	    cr,

	    r,
	    g,
	    b
	    );

  input [7:0] y;
  input [7:0] cb;
  input [7:0] cr;

  output [7:0] r;
  output [7:0] g;
  output [7:0] b;

  //---------------------------------------------------------------------------
  // Equations for YCbCr to RGB
  //
  // R = 1.164(Y-16) + 1.596(Cr-128)
  // G = 1.164(Y-16) - 0.813(Cr-128) - 0.392(Cb-128)
  // B = 1.164(Y-16) + 1.017(Cb-128) + (Cb-128)
  //
  //---------------------------------------------------------------------------
  wire [15:0] mul1 = y * 8'b10010101;	// Y*1.164
  wire [15:0] mul2 = cr * 8'b11001100;	// Cr*1.596
  wire [15:0] mul3 = cr * 8'b01101000;	// Cr*0.813
  wire [15:0] mul4 = cb * 8'b00110010;	// Cb*0.392
  wire [15:0] mul5 = cb * 8'b10000010;	// Cb*1.017

  wire [17:0] red = (mul1 + mul2) - {10'd223, 7'b0};
  wire [17:0] green = (mul1 + {10'd136, 7'b0}) - (mul3 + mul4);
  wire [17:0] blue = (mul1 + mul5) - ({10'd277, 7'b0} - {cb, 7'b0});

  wire [10:0] red_int = red[17:7];
  wire [10:0] green_int = green[17:7];
  wire [10:0] blue_int = blue[17:7];

  wire [7:0]  r = red_int[10] ? 8'b0 : ((|red_int[9:8]) ? 8'hff : red_int[7:0]);
  wire [7:0]  g = green_int[10] ? 8'b0 : ((|green_int[9:8]) ? 8'hff : green_int[7:0]);
  wire [7:0]  b = blue_int[10] ? 8'b0 : ((|blue_int[9:8]) ? 8'hff : blue_int[7:0]);
  
endmodule