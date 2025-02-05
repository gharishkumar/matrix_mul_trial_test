// DATA_TYPE SELECTION
// 000 - fpu 754
// 001 - bfloat 8
// 001 - bfloat 16
// 011 - int 8
// 100 - int 16
// 101 - int 32

// similar pe structure for bfloat data types

module pe #(parameter DATA_TYPE = 3'b00 )
( 
	input             clk,
	input             rst,
	input             load_in,
	input [31:0]      mat1, 
	input [31:0]      mat2, 
	output reg [31:0] outp_col, 
	output reg [31:0] outp_row, 
	output reg [63:0] pe_result,
	output            done
);
	
	assign done = (state == DONE) ? 1'b1 : 1'b0;
	

	//placeholder for multiplier module and signals FPU

	reg [31:0] a_in_mul_reg;
	reg [31:0] b_in_mul_reg;

	reg input_mul_start_reg;

	assign input_mul_start = input_mul_start_reg;

		fpu_multiplier inst_multiplier (
			.input_a          (input_a_mul),
			.input_b          (input_b_mul),
			.input_mul_start  (input_mul_start), // start signal
			.clk              (clk),
			.rst              (rst),
			.output_mul       (output_mul),
			.output_done      (output_done_mul),
		);



	//placeholder for adder module ans signal

	reg [31:0]  result_mul_reg;
	reg [31:0]  pe_result_reg;

	assign input_a_add = result_mul_reg;
	assign input_b_add = pe_result_reg;

	reg input_add_start_reg;
	assign input_add_start = input_add_start_reg;

		fpu_adder inst_adder  (
			.input_a          (input_a_add),
			.input_b          (input_b_add),
			.input_mul_start  (input_add_start), // start signal
			.clk              (clk),
			.rst              (rst),
			.output_mul       (output_add),
			.output_done      (output_done_add),
		);
 

	parameter IDLE     = 2'b00,
			  MUL_START = 2'b01,
			  DONE     = 2'b10;

	reg [1:0] state;


	always @(posedge rst or posedge clk) begin 
		if(rst) begin 
			pe_result <= 0; 
			outp_row  <= 0; 
			outp_col  <= 0; 
			input_mul_start_reg <= 0;
			state     <= IDLE;
			pe_result_reg <= 0;
			result_mul_reg <= 0;
			// done           <= 0;
		end else begin 
			case (state)
				IDLE :  begin
					    if(load_in) begin
					    	a_in_mul_reg <= mat1;
					    	b_in_mul_reg <= mat2;
					    	input_mul_start_reg <= 1'b1;
					    	state        <= MUL_START
					    end
				end
				MUL_START : begin
							if(output_done_mul) begin
								result_mul_reg <= output_mul;
								pe_result_reg  <= pe_result;
								input_mul_start_reg <= 1'b0;
								input_add_start_reg <= 1'b1;
								state          <= DONE;
							end
				end
				DONE : begin
					   if (output_done_add) begin
					   	    input_add_start_reg <= 1'b0;
					   		pe_result <= output_add;
					   		outp_col  <= mat1;
					   		outp_row  <= mat2;
					   		// done      <= 1'b1;
					   		state     <= IDLE;
					   end
				end
				default : state <= IDLE;
			endcase
		end 
	end 

endmodule



