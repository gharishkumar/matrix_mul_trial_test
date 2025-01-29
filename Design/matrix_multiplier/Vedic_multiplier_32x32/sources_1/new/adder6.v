
module adder6(a, b, clk, sum);
    input [5:0] a, b;
    input clk;
    output reg [5:0] sum;

  	always @(posedge clk) begin
        	sum <= a + b;
    end
endmodule