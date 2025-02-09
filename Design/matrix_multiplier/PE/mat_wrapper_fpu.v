`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 09.02.2025 13:16:00
// Design Name: 
// Module Name: mat_wrapper
// Project Name: 
// Target Devices: 
// Tool Versions: 
// Description: 
// 
// Dependencies: 
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
//////////////////////////////////////////////////////////////////////////////////


module mat_wrapper_fpu(
    input        clk,
    input        rst,
    input        load_in,
    input [31:0]  a11,
    input [31:0]  a12,
    input [31:0]  a21,
    input [31:0]  a22,
    input [31:0]  b11,
    input [31:0]  b12,
    input [31:0]  b21,
    input [31:0]  b22,
    output reg [31:0] result_row00,
    output reg [31:0] result_row01,
    output reg [31:0] result_row10,
    output reg [31:0] result_row11,
    output reg   valid
    );

            sys_array_fpu inst_sys_array_fpu
        (
            .clk          (clk),
            .rst          (rst),
            .load_in      (load_in),
            .row_in_row0  (row_in_row0),
            .row_in_row1  (row_in_row1),
            .col_in_col0  (col_in_col0),
            .col_in_col1  (col_in_col1),
            .result_row00 (result_row00),
            .result_row01 (result_row01),
            .result_row10 (result_row10),
            .result_row11 (result_row11),
            .done         (done),
            .valid_op     (valid_op)
        );


   reg [7:0] a_reg;
   reg [7:0] b_reg;

   // reg load_in_reg = 
   reg load_in_sys_reg;

   reg [31:0] row_in_row0_reg;
   reg [31:0] row_in_row1_reg;
   reg [31:0] col_in_col0_reg;
   reg [31:0] col_in_col1_reg;

   wire [31:0] row_in_row0;
   wire [31:0] row_in_row1;
   wire [31:0] col_in_col0;
   wire [31:0] col_in_col1;

   assign row_in_row0 = row_in_row0_reg;
   assign row_in_row1 = row_in_row1_reg;
   assign col_in_col0 = col_in_col0_reg;
   assign col_in_col1 = col_in_col1_reg;

   assign load_in_sys = load_in_sys_reg;

    reg [31:0] result_row00_sys;
    reg [31:0] result_row01_sys;
    reg [31:0] result_row10_sys;
    reg [31:0] result_row11_sys;

   reg [3:0] state;

   parameter IDLE               = 4'b0000,
             LOAD_SET1          = 4'b0001,
             LOAD_UNSET1        = 4'b0010,
             LOAD_SET2          = 4'b0011,
             LOAD_UNSET2        = 4'b0100,
             LOAD_SET3          = 4'b0101,
             LOAD_UNSET3        = 4'b0110,
             LOAD_SET4          = 4'b0111,
             LOAD_UNSET4        = 4'b1000,
             WAIT_FOR_DONE      = 4'b1001;
             // PUT_RESULT_11      = 4'b0110,
             // PUT_RESULT_12      = 4'b0111,
             // PUT_RESULT_21      = 4'b1000,
             // PUT_RESULT_22_DONE = 4'b1001;

    reg [1:0] count;

    always @(posedge clk) begin 
        if(rst) begin
            state <= IDLE;
            a_reg <= 0;
            b_reg <= 0;
            load_in_sys_reg <= 0;
            valid <= 1'b0;
            count <= 0;
        end else begin
            case (state)
                IDLE    : begin
                         valid <= 1'b0;
                         if (load_in)  begin
                             a_reg <= {a22, a21, a12, a11};
                             b_reg <= {b22, b21, b12, b11};
                             state <= LOAD_SET1;
                         end 
                end 
                LOAD_SET1 : begin
                            load_in_sys_reg <= 1'b1;
                            row_in_row0_reg <= a_reg[3:2];
                            row_in_row1_reg <= 2'b0;
                            col_in_col0_reg <= b_reg[5:4];
                            col_in_col1_reg <= 2'b0;
                            state <= LOAD_UNSET1;
                end
                LOAD_UNSET1 : begin 
                            if (count == 2'b10) begin
                                load_in_sys_reg <= 1'b0;
                                state           <= LOAD_SET2;
                                count <= 0;
                            end else begin
                                count <= count + 1;
                                state <= LOAD_UNSET1;
                            end
                end
                LOAD_SET2 : begin
                    if (done_sys) begin
                            load_in_sys_reg <= 1'b1;
                            row_in_row0_reg <= a_reg[1:0];
                            row_in_row1_reg <= a_reg[7:6];
                            col_in_col0_reg <= b_reg[1:0];
                            col_in_col1_reg <= b_reg[7:6];
                            state <= LOAD_UNSET2;
                    end
                end
                LOAD_UNSET2 : begin 
                            if (count == 2'b10) begin
                                load_in_sys_reg <= 1'b0;
                                state           <= LOAD_SET3;
                                count           <= 0;
                            end else begin
                                count <= count + 1;
                                state <= LOAD_UNSET2;
                            end
                end
                LOAD_SET3 : begin
                    if (done_sys) begin
                            load_in_sys_reg <= 1'b1;
                            row_in_row0_reg <= 2'b0;
                            row_in_row1_reg <= a_reg[5:4];
                            col_in_col0_reg <= 2'b0;
                            col_in_col1_reg <= b_reg[3:2];
                            state <= LOAD_UNSET3;
                    end
                end
                LOAD_UNSET3 : begin 
                            if (count == 2'b10) begin
                                load_in_sys_reg <= 1'b0;
                                state           <= LOAD_SET4;
                                count <= 0;
                            end else begin
                                count <= count + 1;
                                state <= LOAD_UNSET3;
                            end
                end
                LOAD_SET4 : begin
                    if (done_sys) begin
                            load_in_sys_reg <= 1'b1;
                            row_in_row0_reg <= 2'b0;
                            row_in_row1_reg <= 2'b0;
                            col_in_col0_reg <= 2'b0;
                            col_in_col1_reg <= 2'b0;
                            state <= LOAD_UNSET4;
                    end
                end
                LOAD_UNSET4 : begin 
                            if (count == 2'b10) begin
                                load_in_sys_reg <= 1'b0;
                                state           <= WAIT_FOR_DONE;
                                count <= 0;
                            end else begin
                                count <= count + 1;
                                state <= LOAD_UNSET4;
                            end
                end
                WAIT_FOR_DONE :  begin
                    load_in_sys_reg <= 1'b0;
                    if (valid_op) begin
                        result_row00 <= result_row00_sys;
                        result_row01 <= result_row01_sys;
                        result_row10 <= result_row10_sys;
                        result_row11 <= result_row11_sys;
                        state <= IDLE;
                        valid <= 1'b1;
                    end
                end
                default : state <= IDLE;
            endcase
        end
    end

endmodule
