`timescale 1ns/1ps

module tb_halfAdder;

    // Inputs
    reg clk;
    reg rst;
    reg a_in;
    reg b_in;
    reg valid_in;
    reg ready_in;

    // Outputs
    wire ready_out;
    wire sum_out;
    wire carry_out;
    wire valid_out;

    // Instantiate the module under test
    halfAdder inst_halfAdder
        (
            .clk       (clk),
            .rst       (rst),
            .a_in      (a_in),
            .b_in      (b_in),
            .valid_in  (valid_in),
            .ready_out (ready_out),
            .sum_out   (sum_out),
            .carry_out (carry_out),
            .valid_out (valid_out),
            .ready_in  (ready_in)
        );

    // Clock generation
    initial begin
        clk = 1;
        forever #5 clk = ~clk;  // 10ns clock period
    end

    // Test sequence
    initial begin
        // Initialize inputs
        rst = 1;
        a_in = 1'b0;
        b_in = 1'b0;
        valid_in = 0;
        ready_in = 0;

        // Apply reset
        #10;
        rst = 0;

        // Test case 1: Provide valid inputs
        #10;
        a_in = 1'b1;  // Example input data
        b_in = 1'b1;
        valid_in = 1;

        // Wait for ready_out to go high
        wait(ready_out == 1);
        #10;
        valid_in = 0;  // Deassert valid_in after data is captured

        // Wait for valid_out to go high
        wait(valid_out == 1);
        #10;
        ready_in = 1;  // Assert ready_in to accept output data
        #10;
        ready_in = 0;  // Deassert ready_in

        // Test case 2: Provide another set of inputs
        #10;
        a_in = 1'b1;
        b_in = 1'b0;
        valid_in = 1;

        // Wait for ready_out to go high
        wait(ready_out == 1);
        #10;
        valid_in = 0;  // Deassert valid_in after data is captured

        // Wait for valid_out to go high
        wait(valid_out == 1);
        ready_in = 1;  // Assert ready_in to accept output data
        #10;
        ready_in = 0;  // Deassert ready_in



        // Test case 2: Provide another set of inputs
        #10;
        a_in = 1'b1;
        b_in = 1'b0;
        valid_in = 1;

        // Wait for ready_out to go high
        wait(ready_out == 1);
        #10;
        valid_in = 0;  // Deassert valid_in after data is captured

        // Wait for valid_out to go high
        wait(valid_out == 1);
        ready_in = 1;  // Assert ready_in to accept output data
        #10;
        ready_in = 0;  // Deassert ready_in


        // End simulation
        #10;
        $stop;
    end

    // Monitor signals
    initial begin
        $monitor("Time: %0t | clk: %b | rst: %b | a_in: %h | b_in: %h | valid_in: %b | ready_out: %b | sum_out: %h | carry_out: %h | valid_out: %b | ready_in: %b",
                 $time, clk, rst, a_in, b_in, valid_in, ready_out, sum_out, carry_out, valid_out, ready_in);
    end

endmodule