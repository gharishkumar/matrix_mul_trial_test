// DATA_TYPE SELECTION
// 000 - fpu 754
// 001 - bfloat 8
// 001 - bfloat 16
// 011 - int 8
// 100 - int 16
// 101 - int 32

// similar pe structure for bfloat data types

module pe_int #(parameter DATA_TYPE = 3'b011 )
( 
	input             clk,
	input             rst,
	input             load_in,
	input [31:0]      mat1, // parameter for datawidth to be added accordingly
	input [31:0]      mat2, 
	output reg [31:0] outp_col, 
	output reg [31:0] outp_row, 
	output reg [63:0] pe_result
);
	
	vedic32x32 inst_vedic32x32 (.a(a), .b(b), .clk(clk), .reset(reset), .result(result), .valid_out(valid_out));

	reg [31:0] a_in_reg;
	reg [31:0] b_in_reg;

	assign a = a_in_reg;
	assign b = b_in_reg;

	always_ff @(posedge clk) begin 
		if(rst) begin
			a_in_reg <= 0;
			b_in_reg <= 0;
		end else begin
			if (load_in) begin
				a_in_reg <= mat1;
				b_in_reg <= mat2;
			end else begin
				if(valid_out) begin
					pe_result <= pe_result + result;
					outp_row  <= mat1;
					outp_col  <= mat2;
				end else begin
					pe_result <= pe_result;
				end
			end
		end
	end
	
endmodule



