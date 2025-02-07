`timescale 1ns / 1ps

module vedic32x32(
    input  [31:0] a, b,
    input clk,
    input reset,
    output [63:0] result,
    output reg valid_out
);
    wire [31:0] t1, t2, t3, t6;
    wire [31:0] t1_buff_1, t1_buff_2;
    wire [31:0] t6_buff_1, t6_buff_2;
    wire [34:0] t4, t5;
    reg [64:0] result_pre;
    wire       result_pad;

    vedic16x16 M1(clk, a[15:0], b[15:0], t1);
    vedic16x16 M2(clk, a[31:16], b[15:0], t2);
    vedic16x16 M3(clk, a[15:0], b[31:16], t3);

    adder #(34) A1(clk, {2'b0, t2}, {2'b0, t3}, t4);    
    buffer #(32)B1(clk, t1, t1_buff_1);
    adder #(34) A2(clk, t4[33:0], {18'b0, t1_buff_1[31:16]}, t5);

    vedic16x16 M4(clk, a[31:16], b[31:16], t6);
    
    buffer #(32)B2(clk, t6, t6_buff_1);
    buffer #(32)B3(clk, t6_buff_1, t6_buff_2);
    adder #(32) A3(clk, t6_buff_2, {{14'b0}, t5[33:16]}, {result_pad, result[63:32]});

 
    buffer #(32)B4(clk, t1_buff_1, t1_buff_2);
    buffer #(16)B6(clk, t1_buff_2[15:0], result [15:0]);
    
    buffer #(16)B5(clk, t5[15:0], result [31:16]);
    
    always @(posedge clk) begin
        if (reset) begin
            result_pre <= 0;
            valid_out  <= 0;
        end else begin 
            result_pre <= result;
            if (result == result_pre) begin
                valid_out <= 1'b0;
            end else begin
                valid_out <= 1'b1;
            end
        end
    end
endmodule