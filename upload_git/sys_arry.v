`timescale 1ns/1ps

module systolic_2x2 #(parameter DATA_TYPE = 3'b011) (
    input clk,
    input rst,
    input load_in,
    input [31:0] row_in_row0, row_in_row1, // Matrix A inputs (2 rows)
    input [31:0] col_in_col0, col_in_col1, // Matrix B inputs (2 columns)
    output [63:0] result_row00, result_row01, result_row10, result_row11,// Output matrix C (2 rows)
    output carry_00, carry_01, carry_10, carry_11,
    output reg done
);

    // Internal wires for PE communication
    wire [31:0] pe00_row_out, pe00_col_out;
    wire [31:0] pe01_row_out, pe01_col_out;
    wire [31:0] pe10_row_out, pe10_col_out;
    wire [31:0] pe11_row_out, pe11_col_out;

    wire [64:0] pe00_result, pe01_result, pe10_result, pe11_result;

    // assign done = pe00_done & pe01_done & pe10_done & pe11_done;

    // Instantiate PE for (0,0)
    pe #(DATA_TYPE) pe00 (
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
    pe #(DATA_TYPE) pe01 (
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
    pe #(DATA_TYPE) pe10 (
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
    pe #(DATA_TYPE) pe11 (
        .clk(clk),
        .rst(rst),
        .load_in(load_in),
        .row_in(pe10_row_out), // Pass row output from PE10
        .col_in(pe01_col_out), // Pass column output from PE01
        .row_out(pe11_row_out),
        .col_out(pe11_col_out),
        .pe_result(pe11_result),
        .done_pe(pe11_done)
    );

    // Assign final results

    assign {carry_00, result_row00} = pe00_result;
    assign {carry_01, result_row01} = pe01_result;
    assign {carry_10, result_row10} = pe10_result;
    assign {carry_11, result_row11} = pe11_result;

    reg [2:0] count;

    always @(posedge clk) begin 
        if(rst) begin
            count <= 0;
            done  <= 0;
        end else begin
            if (pe00_done || pe01_done || pe10_done || pe11_done) begin
                count <= count + 1;
                done  <= 0;
            end else if (count == 3'b100) begin
                done  <= 1'b1;
                count <= 3'b000;
            end else begin
                done  <= 0;
                count <= count;
            end
        end
    end

   

endmodule