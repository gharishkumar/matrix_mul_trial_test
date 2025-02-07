`timescale 1ns/1ps

module systolic_2x2_tb;

    // Inputs
    reg clk;
    reg rst;
    reg load_in;
    reg [31:0] row_in_row0, row_in_row1;
    reg [31:0] col_in_col0, col_in_col1;

    // Outputs
    wire [63:0] result_row00, result_row01, result_row10, result_row11;
    wire carry_00, carry_01, carry_10, carry_11;
     wire done;

    // Instantiate the Unit Under Test (UUT)
    systolic_2x2 #(.DATA_TYPE(3'b011)) uut (
        .clk(clk),
        .rst(rst),
        .load_in(load_in),
        .row_in_row0(row_in_row0),
        .row_in_row1(row_in_row1),
        .col_in_col0(col_in_col0),
        .col_in_col1(col_in_col1),
        .result_row00(result_row00),
        .result_row01(result_row01),
        .result_row10(result_row10),
        .result_row11(result_row11),
        .carry_00(carry_00),
        .carry_01(carry_01),
        .carry_10(carry_10),
        .carry_11(carry_11),
        .done(done)
    );

    // Clock generation
    initial begin
        clk = 0;
        forever #5 clk = ~clk; // 10ns period clock
    end

    // Test sequence
    initial begin
        // Initialize inputs
        rst = 1;
        load_in = 0;
        row_in_row0 = 0;
        row_in_row1 = 0;
        col_in_col0 = 0;
        col_in_col1 = 0;

        // Apply reset
        #20;
        rst = 0;

        // Load first set of data
        #100;
        load_in = 1;
        row_in_row0 = 32'd2; //
        row_in_row1 = 32'h0; 

        col_in_col0 = 32'h2; 
        col_in_col1 = 32'h0; 
 
        #10 load_in = 0;

        // Wait for done signal
        // wait(done == 1);
        #200;

        // 2nd set of data
        load_in = 1;
        row_in_row0 = 32'h2; 
        row_in_row1 = 32'h2; 

        col_in_col0 = 32'h2; 
        col_in_col1 = 32'h2; 

        #10 load_in = 0;

        // // Wait for done signal
        // wait(done == 1);

        #200;
        load_in = 1;
        row_in_row0 = 32'h0; 
        row_in_row1 = 32'h2; 

        col_in_col0 = 32'h0; 
        col_in_col1 = 32'h2; 

        #10 load_in = 0;

        //Wait for done signal
        // wait(done == 1);

        #200;
        load_in = 1;
        row_in_row0 = 32'h0; 
        row_in_row1 = 32'h0; 

        col_in_col0 = 32'h0; 
        col_in_col1 = 32'h0; 

        #10 load_in = 0;

        // Wait for done signal
        // wait(done == 1);
        // #10;
        // load_in = 1;

        

        // End simulation
        #200;
        $finish;
    end

    // Monitor outputs
    // initial begin
    //     $monitor("Time: %0t | Done: %b | Result Row00: %h | Result Row01: %h | Result Row10: %h | Result Row11: %h",
    //              $time, done, result_row00, result_row01, result_row10, result_row11);
    // end

endmodule