
module vedic_2x2(a, b, clk, result);
    input [1:0] a, b;
    input clk;
    output [3:0] result;

  wire w0, w1, w2, w3, w4, w5;  
  wire w2_buf_1; 
  wire w5_buf_1; 
  
  halfAdder H0(w0, w1, clk, w4, w3);
  buffer #(1)B0(clk, w4, result[1]);
  buffer #(1)B1(clk, w2, w2_buf_1);

  halfAdder H1(w2_buf_1, w3, clk, result[2], result[3]);
  buffer #(1)B2(clk, w5, w5_buf_1);
  buffer #(1)B3(clk, w5_buf_1, result[0]);

  assign w0 = a[0] & b[1];
  assign w1 = a[1] & b[0];
  assign w2 = a[1] & b[1];
  assign w5 = a[0] & b[0];
  
endmodule
