`timescale 1ns/1ps

module unit_adder 
#(
	parameter DATA_WIDTH = 4
 )
 (
	input  wire  				  clk,    // Clock
	input  wire  		          rst_p,  // Synchronous reset active high
	input  wire  [DATA_WIDTH-1:0] a_in,
	input  wire  [DATA_WIDTH-1:0] b_in,
	output logic [DATA_WIDTH-1:0] sum_out,
	output logic				  carry_out
 );

logic [DATA_WIDTH:0] temp_result;

always_ff @ (posedge clk ) begin 
	if (rst_p) begin
		temp_result <= 0;
		sum_out     <= 0;
		carry_out   <= 0;
	end else begin 
		temp_result <= a_in + b_in;
		{carry_out,sum_out} <= {temp_result[DATA_WIDTH],temp_result[DATA_WIDTH-1:0]};
	end
end
endmodule