

module adder10(a, b, clk, sum);
    input [9:0] a, b;
    input clk;
    output reg [9:0] sum;
  
  always @(posedge clk) begin
        	sum <= a + b;
  end
endmodule