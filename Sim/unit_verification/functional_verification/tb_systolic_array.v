`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 08.02.2025 10:13:31
// Design Name: 
// Module Name: tb_systolic_array
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


module tb_systolic_array;

    // Inputs
    reg clk;
    reg rst;
    reg load_in;
    reg [31:0] mat1_row0, mat1_row1;
    reg [31:0] mat2_col0, mat2_col1;
    
    // Outputs
    wire [31:0] result_row00, result_row01, result_row10, result_row11;
    // wire done;

    reg [31:0] a11, a12;
    reg [31:0] a21, a22;
    reg [31:0] b11, b12;
    reg [31:0] b21, b22;
    
    // Instantiate the Unit Under Test (UUT)
        sys_array_fpu inst_sys_array_fpu
        (
            .clk          (clk),
            .rst          (rst),
            .load_in      (load_in),
            .row_in_row0  (mat1_row0),
            .row_in_row1  (mat1_row1),
            .col_in_col0  (mat2_col0),
            .col_in_col1  (mat2_col1),
            .result_row00 (result_row00),
            .result_row01 (result_row01),
            .result_row10 (result_row10),
            .result_row11 (result_row11),
            .done         (done)
        );

    // Clock generation
    initial begin
        clk = 0;
        forever #5 clk = ~clk; // 10ns period clock
    end

    // Test sequence
    initial begin
        // Initialize inputs
        a11 = 32'h400ccccd;        a12 = 32'h400ccccd;
        a21 = 32'h400ccccd;        a22 = 32'h400ccccd;

        b11 = 32'h400ccccd;        b12 = 32'h400ccccd;
        b21 = 32'h400ccccd;        b22 = 32'h400ccccd;
        

        // c11 = 32'd7;        c12 = 32'd10;
        // c21 = 32'd15;        c22 = 32'd22;
        
        // a11 = 32'd4;        a12 = 32'd2;
        // a21 = 32'd1;        a22 = 32'd8;

        // b11 = 32'd8;        b12 = 32'd2;
        // b21 = 32'd1;        b22 = 32'd4;
        
        rst = 1;
        load_in = 0;
        mat1_row0 = 0;
        mat1_row1 = 0;
        mat2_col0 = 0;
        mat2_col1 = 0;

        // Apply reset
        #190;
        rst = 0;

        // Load first set of data
        #150;
        load_in = 1;

        mat1_row0 = a12; 
        mat1_row1 = 32'h0; 

        mat2_col0 = b21; 
        mat2_col1 = 32'h0; 
 
        // #60

        #30 load_in = 0;

        // Wait for done signal
        wait(done == 1);
        #500;
        // #1000;

        // 2nd set of data

        load_in = 1;
        mat1_row0 = a11; 
        mat1_row1 = a22; 

        mat2_col0 = b11; 
        mat2_col1 = b22; 

        // #60

        #30 load_in = 0;

        // // Wait for done signal
        wait(done == 1);

        // #3500;
        #500;
        load_in = 1;
        mat1_row0 = 32'h0; 
        mat1_row1 = a21; 

        mat2_col0 = 32'h0; 
        mat2_col1 = b12; 

        // #60


        #30 load_in = 0;

        wait(done == 1);
        #500;
        // #3000;
        mat1_row0 = 32'h0; 
        mat1_row1 = 32'h0; 

        mat2_col0 = 32'h0; 
        mat2_col1 = 32'h0; 

        // #60
        load_in = 1;

        #30 load_in = 0;

        


        // Wait for done signal
        // wait(done == 1);
        // #10;
        // load_in = 1;

        

        // End simulation
        // #300;
        // if(((a11*b11 + a12*b21) == result_row00 )&&( (a11*b12 + a12*b22) == result_row10 )&&( (a21*b11 + a22*b21) == result_row01)&&( (a21*b12 + a22*b22) == result_row11)) begin
        //     $display("Test passed");
        // end else begin
        //     $display("Test failed");
        // end
        // $finish;
    end

endmodule
