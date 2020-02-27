
`timescale 1 ns / 1 ns

module Full
          (
           R,
           G,
           B,
           Full
          );

  input   [7:0] R;  // uint8
  input   [7:0] G;  // uint8
  input   [7:0] B;  // uint8
  output  Full;

  reg  Full_1;
  reg signed [7:0] dRG_1;  // int8
  reg [7:0] dRGdBR_1;  // uint8
  reg [7:0] dRB_1;  // uint8
  reg [15:0] X_2;  // uint16
  reg [15:0] Y_2;  // uint16
  reg [15:0] Z_1;  // uint16
  reg [7:0] dRG_tmp_1;  // uint8
  reg [7:0] dRB_tmp_1;  // uint8
  reg [7:0] dRGdBR_tmp_1;  // uint8
  reg [15:0] y_3;  // uint16
  reg [15:0] y_0_1;  // uint16
  reg [15:0] y_1_1;  // uint16
  reg [15:0] x_3;  // uint16
  reg [15:0] x_0_1;  // uint16
  reg [15:0] x_1_1;  // uint16
  reg [15:0] div_temp_2;  // ufix16
  reg [15:0] div_temp_0_1;  // ufix16
  reg [15:0] div_temp_1_1;  // ufix16
  reg signed [8:0] sub_temp_1;  // sfix9
  reg signed [8:0] sub_temp_0_1;  // sfix9
  reg [8:0] add_temp_1;  // ufix9
  reg [23:0] mul_temp_1;  // ufix24
  reg [15:0] sub_cast_2;  // uint16
  reg [23:0] mul_temp_0_1;  // ufix24
  reg [15:0] sub_cast_0_1;  // uint16
  reg [15:0] sub_cast_1_1;  // uint16

  always @(R, G, B) begin
    Full_1 = 1'b0;
    //--------------------RG
    if (G > 230) begin //235
      dRG_1 = -8;
      dRGdBR_1 = 50;
    end
    else if (G > 220) begin
      dRG_1 = 10;
      dRGdBR_1 = 80;
    end
    else if (G > 185) begin
      dRG_1 = 35;
      dRGdBR_1 = 80;
    end
    else if (G > 160) begin
      dRG_1 = 40;
      dRGdBR_1 = 110;
    end
    else if (G > 120) begin
      dRG_1 = 48;
      dRGdBR_1 = 115;
    end
    else begin
      dRG_1 = 75;
      dRGdBR_1 = 115;
    end
    //--------------------RG
    //--------------------RB
    if (B > 190) begin
      dRB_1 = 50;
    end
    else if (B > 175) begin
      dRB_1 = 60;
    end
    else if (B > 145) begin
      dRB_1 = 62;
    end
    else begin
      dRB_1 = 67;
    end
    //--------------------RB
    if ((R >= 125) && (G >= 43)) begin //Было 130_45
      sub_temp_1 = R - G;
      if (sub_temp_1[8] == 1'b1) begin
        dRG_tmp_1 = 0;
      end
      else begin
        dRG_tmp_1 = sub_temp_1[7:0];
      end
       sub_temp_0_1 = R - B;
      if (sub_temp_0_1[8] == 1'b1) begin
        dRB_tmp_1 = 0;
      end
      else begin
        dRB_tmp_1 = sub_temp_0_1[7:0];
      end
       add_temp_1 = dRG_tmp_1 + dRB_tmp_1;
      if (add_temp_1[8] != 1'b0) begin
        dRGdBR_tmp_1 = 255;
      end
      else begin
        dRGdBR_tmp_1 = add_temp_1[7:0];
      end
       if ((($signed({1'b0, dRG_tmp_1}) >= dRG_1) && (dRB_tmp_1 >= dRB_1)) && (dRGdBR_tmp_1 >= dRGdBR_1)) begin
        y_3 = 50 * $signed({1'b0, G});
        if (R == 0) begin
          div_temp_2 = 65535;
        end
        else begin
          div_temp_2 = y_3 / R;
        end
        X_2 = div_temp_2;
        mul_temp_1 = X_2 * R;
        sub_cast_2 = mul_temp_1;
        x_3 = y_3 - sub_cast_2;
        if ((x_3 > 0) && ($signed({1'b0, x_3}) >= ((R >> 1) + (R & 1)))) begin
          X_2 = X_2 + 1;
        end
        y_0_1 = 50 * $signed({1'b0, B});
        if (R == 0) begin
          div_temp_0_1 = 65535;
        end
        else begin
          div_temp_0_1 = y_0_1 / R;
        end
        Y_2 = div_temp_0_1;
        mul_temp_0_1 = Y_2 * R;
        sub_cast_0_1 = mul_temp_0_1;
        x_0_1 = y_0_1 - sub_cast_0_1;
        if ((x_0_1 > 0) && ($signed({1'b0, x_0_1}) >= ((R >> 1) + (R & 1)))) begin
          Y_2 = Y_2 + 1;
        end
        y_1_1 = 50 * $signed({1'b0, B});
        if (G == 0) begin
          div_temp_1_1 = 65535;
        end
        else begin
          div_temp_1_1 = y_1_1 / G;
        end
        Z_1 = div_temp_1_1;
        sub_cast_1_1 = Z_1 * G;
        x_1_1 = y_1_1 - sub_cast_1_1;
        if ((x_1_1 > 0) && ($signed({1'b0, x_1_1}) >= ((G >> 1) + (G & 1)))) begin
          Z_1 = Z_1 + 1;
        end
        if ((((X_2 >= 14) && (X_2 <= 52)) && (Y_2 <= 40)) && (Z_1 <= 46)) begin
          Full_1 = 1'b1;
        end
      end
      else if ((((R >= 248) && (G >= 250)) && (B > 195)) && (B < 230)) begin
        Full_1 = 1'b1;
      end
    end
  end

  assign Full = Full_1;

endmodule  // MATLAB_Function

