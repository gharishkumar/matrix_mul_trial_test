module vedic16x16(a, b, clk, result);
    input  [15:0] a, b;
    input clk;
    output reg [31:0] result;

    wire [31:0] result_w;

    wire [15:0] t1, t2, t3, t6;
    wire [15:0] t1_buff_1, t1_buff_2;
    wire [15:0] t6_buff_1, t6_buff_2;
    wire [17:0] t4, t5;

    vedic8x8 M1(a[7:0], b[7:0], clk, t1);
    vedic8x8 M2(a[15:8], b[7:0], clk, t2);
    vedic8x8 M3(a[7:0], b[15:8], clk, t3);

    adder18 A1({2'b00, t2}, {2'b00, t3}, clk, t4);
    buffer #(16)B1(clk, t1, t1_buff_1);
    adder18 A2(t4, {10'b0, t1_buff_1[15:8]}, clk, t5);

    vedic8x8 M4(a[15:8], b[15:8], clk, t6);
    buffer #(16)B2(clk, t6, t6_buff_1);
    buffer #(16)B3(clk, t6_buff_1, t6_buff_2);
    adder16 A3(t6_buff_2, {6'b000000,t5[17:8]}, clk, result_w[31:16]);
    buffer #(16)B4(clk, t1_buff_1, t1_buff_2);
    buffer #(8)B6(clk, t1_buff_2[7:0], result_w [7:0]);
    
    buffer #(8)B5(clk, t5[7:0], result_w [15:8]);

    always @(posedge clk) begin
        result <= result_w;
    end
endmodule