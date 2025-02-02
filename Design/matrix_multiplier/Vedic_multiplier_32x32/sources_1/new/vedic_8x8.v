`timescale 1ns / 1ps

module vedic8x8(a, b, clk, result);
    input  [7:0] a, b;
    input clk;
    output [15:0] result;

    wire [7:0] t1, t2, t3, t6;
    wire [7:0] t1_buff_1, t1_buff_2;
    wire [7:0] t6_buff_1, t6_buff_2;
    wire [9:0] t4, t5;

    vedic4x4 M1(a[3:0], b[3:0], clk, t1);
    vedic4x4 M2(a[7:4], b[3:0], clk, t2);
    vedic4x4 M3(a[3:0], b[7:4], clk, t3);

    adder10 A1({2'b00, t2}, {2'b00, t3}, clk, t4);
    buffer #(8)B1(clk, t1, t1_buff_1);
    adder10 A2(t4, {6'b000000, t1_buff_1[7:4]}, clk, t5);

    vedic4x4 M4(a[7:4], b[7:4], clk, t6);
    
    buffer #(8)B2(clk, t6, t6_buff_1);
    buffer #(8)B3(clk, t6_buff_1, t6_buff_2);
    adder8 A3(t6_buff_2, {2'b00, t5[9:4]}, clk, result[15:8]);
    buffer #(8)B4(clk, t1_buff_1, t1_buff_2);
    buffer #(4)B6(clk, t1_buff_2[3:0], result [3:0]);
    
    buffer #(4)B5(clk, t5[3:0], result [7:4]);
endmodule







