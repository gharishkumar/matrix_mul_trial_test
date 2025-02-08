`timescale 1ns / 1ps

module tb_pe();

    // Parameters
    parameter DATA_TYPE = 3'b011; // Example: int 8

    // Inputs
    reg clk;
    reg rst;
    reg [31:0] row_in;
    reg [31:0] col_in;

    // Outputs
    wire [31:0] col_out;
    wire [31:0] row_out;
    wire [64:0] pe_result;

    // Instantiate the PE module
    pe #(DATA_TYPE) uut (
        .clk(clk),
        .rst(rst),
        .row_in(row_in),
        .col_in(col_in),
        .col_out(col_out),
        .row_out(row_out),
        .pe_result(pe_result)
    );

    // Clock generation
    initial begin
        clk = 0;
        forever #5 clk = ~clk; // 10ns clock period
    end

    // Test sequence
    initial begin
        // Initialize inputs
        rst = 1;
        row_in = 0;
        col_in = 0;

        // Apply reset
        #40;
        rst = 0;
        
        // Test case 1: Simple multiplication
        row_in = 32'h00000002; // 2
        col_in = 32'h00000003; // 3
        #200; // Wait for computation

        // Test case 2: Larger values
        row_in = 32'h0000000A; // 10
        col_in = 32'h0000000B; // 11
        #200; // Wait for computation

        // Test case 2: Larger values
        row_in = 32'h00000007; // 10
        col_in = 32'h00000008; // 11
        #200; // Wait for computation

        // Test case 2: Larger values
        row_in = 32'h00000005; // 10
        col_in = 32'h00000006; // 11
        #200; // Wait for computation

        // Test case 3: Edge case with zeros
        row_in = 32'h00000000; // 0
        col_in = 32'h0000000F; // 15
        #200; // Wait for computation

        // Test case 4: Edge case with maximum values
        row_in = 32'hFFFFFFFF; // Maximum 32-bit value
        col_in = 32'hFFFFFFFF; // Maximum 32-bit value
        #200; // Wait for computation

        // End simulation
        $display("Simulation complete.");
        $finish;
    end

    // Monitor outputs
    initial begin
        $monitor("Time: %0t | row_in: %h | col_in: %h | row_out: %h | col_out: %h | pe_result: %h",
                 $time, row_in, col_in, row_out, col_out, pe_result);
    end

endmodule