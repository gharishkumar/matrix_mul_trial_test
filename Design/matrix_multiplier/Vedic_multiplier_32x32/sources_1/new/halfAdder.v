module halfAdder(a, b, clk, sum, carry);
    input a, b, clk;
  	output reg sum;
  	output reg carry;

  
	always @(posedge clk) begin
        	sum <= a ^ b;
    		carry <= a & b;
            
    end
endmodule