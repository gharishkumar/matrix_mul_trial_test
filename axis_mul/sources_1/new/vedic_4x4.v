`timescale 1ns / 1ps

module vedic4x4(a, b, clk, result);
    input  [3:0] a, b;
    input clk;
    output [7:0] result;
  
  reg [7:0] op = 8'b0;
  
    wire [3:0] t1, t2, t3, t6, t7;
    wire [5:0] t4, t5;
  	

    vedic_2x2 V1(a[1:0], b[1:0], clk, t1);
    vedic_2x2 V2(a[3:2], b[1:0], clk, t2);
    vedic_2x2 V3(a[1:0], b[3:2], clk, t3);

  adder6 A1({2'b00, t3}, {2'b00, t2}, clk, t4);
  adder6 A2(t4, {4'b0000, t1[3:2]}, clk, t5);

    vedic_2x2 V4(a[3:2], b[3:2], clk, t6);
    adder4 A3(t6, t5[5:2], clk, t7);

  	always @(posedge clk) begin
      		op [1:0] <= t1[1:0];
        	op [3:2] <= t5[1:0];
        	op [7:4] <= t7;
    end
  assign result [7:0] = op [7:0];
endmodule