module vedic16x16(a, b, clk, result);
    input  [15:0] a, b;
    input clk;
    output [31:0] result;
    reg [31:0] op = 32'b0;

    wire [15:0] t1, t2, t3, t6, t7;
    wire [17:0] t4, t5;

    vedic8x8 M1(a[7:0], b[7:0], clk, t1);
    vedic8x8 M2(a[15:8], b[7:0], clk, t2);
    vedic8x8 M3(a[7:0], b[15:8], clk, t3);

    adder18 A1({2'b00, t2}, {2'b00, t3}, clk, t4);
    adder18 A2(t4, {10'b0, t1[15:8]}, clk, t5);

    vedic8x8 M4(a[15:8], b[15:8], clk, t6);
    adder16 A3(t6, {6'b000000,t5[17:8]}, clk, t7);

    always @(posedge clk) begin
        op[7:0]   <= t1[7:0];
        op[15:8]  <= t5[7:0];
        op[31:16] <= t7;
    end

    assign result = op;
endmodule