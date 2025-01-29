
module adder4(a, b, clk, sum);
    input [3:0] a, b;
    input clk;
    output reg [3:0] sum;
  
  	always @(posedge clk) begin
        	sum <= a + b;
    end
endmodule