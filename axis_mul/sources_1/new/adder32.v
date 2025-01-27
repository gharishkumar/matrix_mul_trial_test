module adder32(a, b, clk, sum);
    input [31:0] a, b;
    input clk;
    output reg [31:0] sum;

    always @(posedge clk) begin
        sum <= a + b;
    end
endmodule