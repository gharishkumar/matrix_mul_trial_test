`timescale 1ns / 1ps

module vedic32x32(a, b, clk, result, valid_out);
    input  [31:0] a, b;
    input clk;
    output [63:0] result;
    output valid_out;

    reg [63:0] op = 64'b0;
    reg [63:0] pre_op = 64'b0;

    wire [31:0] t1, t2, t3, t6, t7;
    wire [35:0] t4, t5;

    vedic16x16 M1(a[15:0], b[15:0], clk, t1);
    vedic16x16 M2(a[31:16], b[15:0], clk, t2);
    vedic16x16 M3(a[15:0], b[31:16], clk, t3);

    adder34 A1({2'b0, t2}, {2'b0, t3}, clk, t4[33:0]);
    adder34 A2(t4[33:0], {18'b0, t1[31:16]}, clk, t5[33:0]);

    vedic16x16 M4(a[31:16], b[31:16], clk, t6);
    adder32 A3(t6, {{14'b0}, t5[33:16]}, clk, t7);

    always @(posedge clk) begin
        op[15:0]  <= t1[15:0];
        op[31:16] <= t5[15:0];
        op[63:32] <= t7;
        pre_op <= op;
    end

    assign result = op;
    assign valid_out = (pre_op == op)?1'b1:1'b0;
endmodule