// DATA_TYPE SELECTION
// 000 - fpu 754
// 001 - bfloat 8
// 001 - bfloat 16
// 011 - int 8
// 100 - int 16
// 101 - int 32

// similar pe structure for bfloat data types

module pe #(parameter DATA_TYPE = 3'b011 )
( 
    input             clk,
    input             rst,
    input             load_in,
    input [31:0]      mat1, // parameter for datawidth to be added accordingly
    input [31:0]      mat2, 
    output reg [31:0] outp_col, 
    output reg [31:0] outp_row, 
    output reg [64:0] pe_result
    // output reg        done_pe
);
    

wire [31:0] a;
wire [31:0] b;
wire [63:0] result;

reg [31:0] a_in_reg;
reg [31:0] b_in_reg;

assign a = a_in_reg;
assign b = b_in_reg;

vedic32x32 inst_vedic32x32 (.a(a), .b(b), .clk(clk), .reset(rst), .result(result), .valid_out(valid_out));

    always @(posedge clk) begin 
        if(rst) begin
            a_in_reg <= 0;
            b_in_reg <= 0;
            pe_result <= 0;
            outp_col <= 0;
            outp_row <= 0;
            // done_pe   <= 1'b0;
        end else begin
            if (load_in) begin
                a_in_reg <= mat1;
                b_in_reg <= mat2;
                // done_pe   <= 1'b0;
            end else begin
                if(valid_out) begin
                    pe_result <= pe_result + result;
                    // done_pe   <= 1'b1;
                    outp_row  <= a_in_reg;
                    outp_col  <= b_in_reg;
                end else begin
                    pe_result <= pe_result;
                    // done_pe   <= 1'b0;
                end
            end
        end
    end
    
endmodule



