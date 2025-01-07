module adder34(a, b, clk, sum);
    input [33:0] a, b;
    input clk;
    output reg [33:0] sum;

    always @(posedge clk) begin
        sum <= a + b;
    end
endmodule