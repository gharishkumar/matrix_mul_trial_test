
module vedic2x2(
    input clk,
    input [1:0] a, b,
    output reg [3:0] result
);
  wire w0, w1, w2, w3, w4, w5;  
  wire w2_buf_1; 
  wire w5_buf_1; 
  wire [3:0] result_w;

  assign w0 = a[0] & b[1];
  assign w1 = a[1] & b[0];
  assign w2 = a[1] & b[1];
  assign w5 = a[0] & b[0];
  
  adder #(1)H0(clk, w0, w1, {w3, w4});
  buffer #(1)B0(clk, w4, result_w[1]);
  buffer #(1)B1(clk, w2, w2_buf_1);

  buffer #(1)B2(clk, w5, w5_buf_1);
  buffer #(1)B3(clk, w5_buf_1, result_w[0]);
  adder #(1)H1(clk, w2_buf_1, w3, result_w[3:2]);
  
  always @(posedge clk) begin 
    result <= result_w;
  end
  
endmodule