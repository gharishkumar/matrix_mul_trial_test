// DATA_TYPE SELECTION
// 000 - fpu 754
// 001 - bfloat 8
// 001 - bfloat 16
// 011 - int 8
// 100 - int 16
// 101 - int 32

// similar pe structure for bfloat data types

module pe_fpu #(parameter DATA_TYPE = 3'b00 )
( 
    input             clk,
    input             rst,
    input             load_in,
    input [31:0]      row_in, 
    input [31:0]      col_in, 
    output reg [31:0] col_out, 
    output reg [31:0] row_out, 
    output reg [31:0] pe_result,
    output            done_pe
);
    
    assign done_pe = (state == DONE) ? 1'b1 : 1'b0;
    

    //placeholder for multiplier module and signals FPU

    reg [31:0] a_in_mul_reg;
    reg [31:0] b_in_mul_reg;

    wire [31:0] input_a_mul;
    wire [31:0] input_b_mul;

    wire [31:0] output_fpu_mul;

    wire input_a_stb_mul;
    wire input_b_stb_mul;

    reg input_a_stb_mul_reg;
    reg input_b_stb_mul_reg;

    assign input_a_stb_mul = input_a_stb_mul_reg;
    assign input_b_stb_mul = input_b_stb_mul_reg;

    assign input_a_mul = a_in_mul_reg;
    assign input_b_mul = b_in_mul_reg;


        fpu_multiplier inst_fpu_multiplier (
            .input_a      (input_a_mul),
            .input_b      (input_b_mul),
            .input_a_stb  (input_a_stb_mul),
            .input_b_stb  (input_b_stb_mul),
            .clk          (clk),
            .rst          (rst),
            .output_z     (output_fpu_mul),
            .output_z_stb (output_mul_done)
        );

    //placeholder for adder module ans signal

    wire input_a_stb_add;
    wire input_b_stb_add;

    reg input_a_stb_add_reg;
    reg input_b_stb_add_reg;

    assign input_a_stb_add = input_a_stb_add_reg;
    assign input_b_stb_add = input_b_stb_add_reg;

    reg [31:0]  result_mul_reg;
    reg [31:0]  pe_result_reg;

    wire [31:0] input_a_add;
    wire [31:0] input_b_add;

    assign input_a_add = result_mul_reg;
    assign input_b_add = pe_result_reg;

    wire [31:0] output_add;

    fpu_adder inst_fpu_adder (
            .input_a      (input_a_add),
            .input_b      (input_b_add),
            .input_a_stb  (input_a_stb_add),
            .input_b_stb  (input_b_stb_add),
            .clk          (clk),
            .rst          (rst),
            .output_z     (output_add),
            .output_z_stb (output_done_add)
        );

 

    parameter IDLE     = 2'b00,
              MUL_START = 2'b01,
              DONE     = 2'b10;

    reg [1:0] state;

    reg input_zero;


    always @(posedge rst or posedge clk) begin 
        if(rst) begin 
            pe_result <= 0; 
            row_out  <= 0; 
            col_out  <= 0; 
            input_zero <= 0;
            a_in_mul_reg <= 0;
            b_in_mul_reg <= 0;
            input_a_stb_mul_reg <= 0;
            input_b_stb_mul_reg <= 0;
            input_a_stb_add_reg <= 0;
            input_b_stb_add_reg <= 0;
            state     <= IDLE;
            pe_result_reg <= 0;
            result_mul_reg <= 0;
            // done           <= 0;
        end else begin 
            case (state)
                IDLE :  begin
                        if(load_in) begin
                            a_in_mul_reg <= row_in;                    
                            b_in_mul_reg <= col_in;
                            input_a_stb_mul_reg <= 1'b1;
                            input_b_stb_mul_reg <= 1'b1;
                            state        <= MUL_START;                                
                        end
                end
                MUL_START : begin
                            if(output_mul_done) begin
                                input_a_stb_mul_reg <= 1'b0;
                                input_b_stb_mul_reg <= 1'b0;
                                result_mul_reg <= output_fpu_mul;
                                pe_result_reg  <= pe_result;
                                input_a_stb_add_reg <= 1'b1;
                                input_b_stb_add_reg <= 1'b1;
                                state          <= DONE;
                            end
                end
                DONE : begin
                           if (output_done_add) begin
                               input_a_stb_add_reg <= 1'b0;
                               input_b_stb_add_reg <= 1'b0;
                                pe_result <= output_add;
                                col_out  <= row_in;                    
                                row_out  <= col_in;
                                // done      <= 1'b1;
                                state     <= IDLE;
                           end  
                end
                default : state <= IDLE;
            endcase
        end 
    end 

endmodule



