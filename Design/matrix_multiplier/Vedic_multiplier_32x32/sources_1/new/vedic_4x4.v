`timescale 1ns / 1ps

module vedic4x4(a, b, clk, result);
    input  [3:0] a, b;
    input clk;
    output reg [7:0] result;

    wire [7:0] result_w;

    wire [3:0] t1, t2, t3, t6;
    wire [3:0] t1_buff_1, t1_buff_2;
    wire [3:0] t6_buff_1, t6_buff_2;
    wire [5:0] t4, t5;  	

    vedic_2x2 V1(a[1:0], b[1:0], clk, t1);
    vedic_2x2 V2(a[3:2], b[1:0], clk, t2);
    vedic_2x2 V3(a[1:0], b[3:2], clk, t3);

    adder6 A1({2'b00, t3}, {2'b00, t2}, clk, t4);
    buffer #(4)B1(clk, t1, t1_buff_1);
    adder6 A2(t4, {4'b0000, t1_buff_1[3:2]}, clk, t5);
    
    vedic_2x2 V4(a[3:2], b[3:2], clk, t6);
    buffer #(4)B2(clk, t6, t6_buff_1);
    buffer #(4)B3(clk, t6_buff_1, t6_buff_2);
    adder4 A3(t6_buff_2, t5[5:2], clk, result_w [7:4]);
    buffer #(4)B4(clk, t1_buff_1, t1_buff_2);
    buffer #(2)B6(clk, t1_buff_2[1:0], result_w [1:0]);
    
    buffer #(2)B5(clk, t5[1:0], result_w [3:2]);

    always @(posedge clk) begin 
        result <= result_w;
    end
endmodule