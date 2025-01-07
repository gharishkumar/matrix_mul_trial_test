module adder18(a, b, clk, sum);
    input [17:0] a, b;
    input clk;
    output reg [17:0] sum;

    always @(posedge clk) begin
        sum <= a + b;
    end
endmodule