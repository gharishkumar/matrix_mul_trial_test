`timescale 1ns / 1ps

module vedic8x8(
    input clk,
    input  [7:0] a, b,
    output reg [15:0] result
);
    wire [15:0] result_w;
    wire       result_pad;

    wire [7:0] t1, t2, t3, t6;
    wire [7:0] t1_buff_1, t1_buff_2;
    wire [7:0] t6_buff_1, t6_buff_2;
    wire [10:0] t4, t5;

    vedic4x4 M1(clk, a[3:0], b[3:0], t1);
    vedic4x4 M2(clk, a[7:4], b[3:0], t2);
    vedic4x4 M3(clk, a[3:0], b[7:4], t3);

    adder #(10) A1(clk, {2'b00, t2}, {2'b00, t3}, t4);
    buffer #(8)B1(clk, t1, t1_buff_1);
    adder #(10) A2(clk, t4[9:0], {6'b000000, t1_buff_1[7:4]}, t5);

    vedic4x4 M4(clk, a[7:4], b[7:4], t6);    
    buffer #(8)B2(clk, t6, t6_buff_1);
    buffer #(8)B3(clk, t6_buff_1, t6_buff_2);
    adder #(8) A3(clk, t6_buff_2, {2'b00, t5[9:4]}, {result_pad, result_w[15:8]});
    buffer #(8)B4(clk, t1_buff_1, t1_buff_2);
    buffer #(4)B6(clk, t1_buff_2[3:0], result_w [3:0]);
    
    buffer #(4)B5(clk, t5[3:0], result_w [7:4]);

    always @(posedge clk) begin 
        result <= result_w;
    end
endmodule






