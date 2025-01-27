module adder8(a, b, clk, sum);
    input [7:0] a, b;
    input clk;
    output reg [7:0] sum;
  
  	always @(posedge clk) begin
        	sum <= a + b;
    end
endmodule