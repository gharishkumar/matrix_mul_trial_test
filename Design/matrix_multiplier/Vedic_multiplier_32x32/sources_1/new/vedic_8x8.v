`timescale 1ns / 1ps

module vedic8x8(a, b, clk, result);
    input  [7:0] a, b;
    input clk;
    output [15:0] result;
  reg [15:0] op = 16'b0;
  
  
    wire [7:0] t1, t2, t3, t6, t7;
    wire [9:0] t4, t5;

    vedic4x4 M1(a[3:0], b[3:0], clk, t1);
    vedic4x4 M2(a[7:4], b[3:0], clk, t2);
    vedic4x4 M3(a[3:0], b[7:4], clk, t3);

    adder10 A1({2'b00, t2}, {2'b00, t3}, clk, t4);
    adder10 A2(t4, {6'b000000, t1[7:4]}, clk, t5);

    vedic4x4 M4(a[7:4], b[7:4], clk, t6);
    adder8 A3(t6, {2'b00, t5[9:4]}, clk, t7);

  always @(posedge clk) begin
    op[3:0] <= t1[3:0];
    op[7:4] <= t5[3:0];
    op[15:8] <= t7;
    end
  assign result [15:0] = op [15:0];
endmodule







