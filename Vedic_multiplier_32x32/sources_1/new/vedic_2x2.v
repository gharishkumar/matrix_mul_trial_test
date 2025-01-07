
module vedic_2x2(a, b, clk, result);
    input [1:0] a, b;
    input clk;
    output [3:0] result;

  reg res;
  wire [3:0] w;
  //wire [3:0] resul;
  
  
	always @(posedge clk) begin
        res <= a[0] & b[0];
    end

	assign result[0] = res;
  	assign w[0] = a[1] & b[0];
   assign w[1] = a[0] & b[1];
  	assign w[2] = a[1] & b[1];
  halfAdder H0(w[0], w[1], clk, result[1], w[3]);
  halfAdder H1(w[2], w[3], clk, result[2], result[3]);
endmodule
