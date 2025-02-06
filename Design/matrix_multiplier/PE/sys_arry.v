`timescale 1ns/1ps

module systolic_2x2 #(parameter DATA_TYPE = 3'b011) (
    input clk,
    input rst,
    input load_in,
    input [31:0] mat1_row0, mat1_row1, // Matrix A inputs (2 rows)
    input [31:0] mat2_col0, mat2_col1, // Matrix B inputs (2 columns)
    output [63:0] result_row00, result_row01, result_row10, result_row11,// Output matrix C (2 rows)
    output carry_00, carry_01, carry_10, carry_11
    // output done
);

    // Internal wires for PE communication
    wire [31:0] pe00_outp_row, pe00_outp_col;
    wire [31:0] pe01_outp_row, pe01_outp_col;
    wire [31:0] pe10_outp_row, pe10_outp_col;
    wire [31:0] pe11_outp_row, pe11_outp_col;

    wire [64:0] pe00_result, pe01_result, pe10_result, pe11_result;

    // assign done = pe00_done & pe01_done & pe10_done & pe11_done;

    // Instantiate PE for (0,0)
    pe #(DATA_TYPE) pe00 (
        .clk(clk),
        .rst(rst),
        .load_in(load_in),
        .mat1(mat1_row0),
        .mat2(mat2_col0),
        .outp_row(pe00_outp_row),
        .outp_col(pe00_outp_col),
        .pe_result(pe00_result)
        // .done_pe(pe00_done)
    );

    // Instantiate PE for (0,1)
    pe #(DATA_TYPE) pe01 (
        .clk(clk),
        .rst(rst),
        .load_in(load_in),
        .mat1(pe00_outp_row), // Pass row output from PE00
        .mat2(mat2_col1),
        .outp_row(pe01_outp_row),
        .outp_col(pe01_outp_col),
        .pe_result(pe01_result)
        // .done_pe(pe01_done)
    );

    // Instantiate PE for (1,0)
    pe #(DATA_TYPE) pe10 (
        .clk(clk),
        .rst(rst),
        .load_in(load_in),
        .mat1(mat1_row1),
        .mat2(pe00_outp_col), // Pass column output from PE00
        .outp_row(pe10_outp_row),
        .outp_col(pe10_outp_col),
        .pe_result(pe10_result)
        // .done_pe(pe10_done)
    );

    // Instantiate PE for (1,1)
    pe #(DATA_TYPE) pe11 (
        .clk(clk),
        .rst(rst),
        .load_in(load_in),
        .mat1(pe10_outp_row), // Pass row output from PE10
        .mat2(pe01_outp_col), // Pass column output from PE01
        .outp_row(pe11_outp_row),
        .outp_col(pe11_outp_col),
        .pe_result(pe11_result)
        // .done_pe(pe11_done)
    );

    // Assign final results

    assign {carry_00, result_row00} = pe00_result;
    assign {carry_01, result_row01} = pe01_result;
    assign {carry_10, result_row10} = pe10_result;
    assign {carry_11, result_row11} = pe11_result;
   

endmodule