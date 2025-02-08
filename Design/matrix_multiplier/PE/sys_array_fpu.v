`timescale 1ns/1ps

module sys_array_fpu (
    input clk,
    input rst,
    input load_in,
    input [31:0] row_in_row0, row_in_row1, // Matrix A inputs (2 rows)
    input [31:0] col_in_col0, col_in_col1, // Matrix B inputs (2 columns)
    output [31:0] result_row00, result_row01, result_row10, result_row11,// Output matrix C (2 rows)
    output reg done
);

    // Internal wires for PE communication
    wire [31:0] pe00_row_out, pe00_col_out;
    wire [31:0] pe01_row_out, pe01_col_out;
    wire [31:0] pe10_row_out, pe10_col_out;
    wire [31:0] pe11_row_out, pe11_col_out;

    wire [31:0] pe00_result, pe01_result, pe10_result, pe11_result;

    // Instantiate PE for (0,0)
    pe_fpu pe00 (
        .clk(clk),
        .rst(rst),
        .load_in(load_in),
        .row_in(row_in_row0),
        .col_in(col_in_col0),
        .row_out(pe00_row_out),
        .col_out(pe00_col_out),
        .pe_result(pe00_result),
        .done_pe(pe00_done)
    );

    // Instantiate PE for (0,1)
    pe_fpu pe01 (
        .clk(clk),
        .rst(rst),
        .load_in(load_in),
        .row_in(pe00_row_out), // Pass row output from PE00
        .col_in(col_in_col1),
        .row_out(pe01_row_out),
        .col_out(pe01_col_out),
        .pe_result(pe01_result),
        .done_pe(pe01_done)
    );

    // Instantiate PE for (1,0)
    pe_fpu pe10 (
        .clk(clk),
        .rst(rst),
        .load_in(load_in),
        .row_in(row_in_row1),
        .col_in(pe00_col_out), // Pass column output from PE00
        .row_out(pe10_row_out),
        .col_out(pe10_col_out),
        .pe_result(pe10_result),
        .done_pe(pe10_done)
    );

    // Instantiate PE for (1,1)
        pe_fpu pe11 (
            .clk       (clk),
            .rst       (rst),
            .load_in   (load_in),
            .row_in    (pe10_row_out),
            .col_in    (pe01_col_out),
            .col_out   (pe11_col_out),
            .row_out   (pe11_row_out),
            .pe_result (pe11_result),
            .done_pe   (pe11_done)
        );

    // Assign final results

    assign result_row00 = pe00_result;
    assign result_row01 = pe01_result;
    assign result_row10 = pe10_result;
    assign result_row11 = pe11_result;

    // reg [2:0] count; 

    // always @(posedge clk) begin 
    //     if(rst) begin
    //         count <= 0;
    //         done  <= 0;
    //     end else begin
    //         if (pe00_done || pe01_done || pe10_done || pe11_done) begin
    //             count <= count + 1;
    //             done  <= 0;
    //         end else if (count == 3'b100) begin
    //             done  <= 1'b1;
    //             count <= 3'b000;
    //         end else begin
    //             done  <= 0;
    //             count <= count;
    //         end
    //     end
    // end

   

endmodule