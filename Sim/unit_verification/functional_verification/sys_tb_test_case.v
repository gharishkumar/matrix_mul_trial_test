`timescale 1ns/1ps

module systolic_2x2_tb;

    // Inputs
    reg clk;
    reg rst;
    reg load_in;
    reg [31:0] mat1_row0, mat1_row1;
    reg [31:0] mat2_col0, mat2_col1;
    
    // Outputs
    wire [63:0] result_row00, result_row01, result_row10, result_row11;
    wire carry_00, carry_01, carry_10, carry_11;
    // wire done;

    reg [31:0] a11, a12;
    reg [31:0] a21, a22;
    reg [31:0] b11, b12;
    reg [31:0] b21, b22;
    
    // Instantiate the Unit Under Test (UUT)
    systolic_2x2 #(.DATA_TYPE(3'b011)) uut (
        .clk(clk),
        .rst(rst),
        .load_in(load_in),
        .mat1_row0(mat1_row0),
        .mat1_row1(mat1_row1),
        .mat2_col0(mat2_col0),
        .mat2_col1(mat2_col1),
        .result_row00(result_row00),
        .result_row01(result_row01),
        .result_row10(result_row10),
        .result_row11(result_row11),
        .carry_00(carry_00),
        .carry_01(carry_01),
        .carry_10(carry_10),
        .carry_11(carry_11)
        // .done(done)
    );

    // Clock generation
    initial begin
        clk = 0;
        forever #5 clk = ~clk; // 10ns period clock
    end

    // Test sequence
    initial begin
        // Initialize inputs
        a11 = 32'd1;        a12 = 32'd2;
        a21 = 32'd3;        a22 = 32'd4;

        b11 = 32'd1;        b12 = 32'd2;
        b21 = 32'd3;        b22 = 32'd4;
        

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
        #200;
        load_in = 1;
        mat1_row0 = a11; 
        mat1_row1 = 32'h0; 

        mat2_col0 = b11; 
        mat2_col1 = 32'h0; 
 
        #20 load_in = 0;

        // Wait for done signal
        // wait(done == 1);
        #300;

        // 2nd set of data
        load_in = 1;
        mat1_row0 = a21; 
        mat1_row1 = a12; 

        mat2_col0 = b12; 
        mat2_col1 = b21; 

        #20 load_in = 0;

        // // Wait for done signal
        // wait(done == 1);

        #300;
        load_in = 1;
        mat1_row0 = 32'h0; 
        mat1_row1 = a22; 

        mat2_col0 = 32'h0; 
        mat2_col1 = b22; 

        #20 load_in = 0;

        //Wait for done signal
        // wait(done == 1);

        #300;
        load_in = 1;
        mat1_row0 = 32'h0; 
        mat1_row1 = 32'h0; 

        mat2_col0 = 32'h0; 
        mat2_col1 = 32'h0; 

        #20 load_in = 0;

        // Wait for done signal
        // wait(done == 1);
        // #10;
        // load_in = 1;

        

        // End simulation
        #200;
        if(((a11*b11 + a12*b21) == result_row00 )&&( (a11*b12 + a12*b22) == result_row10 )&&( (a21*b11 + a22*b21) == result_row01)&&( (a21*b12 + a22*b22) == result_row11)) begin
            $display("Test passed");
        end else begin
            $display("Test failed");
        end
        $finish;
    end



endmodule