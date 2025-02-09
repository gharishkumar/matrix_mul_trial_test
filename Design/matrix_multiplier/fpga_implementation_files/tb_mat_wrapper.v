`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 09.02.2025 15:42:03
// Design Name: 
// Module Name: tb_mat_wrapper
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


module tb_mat_wrapper();

    reg        clk;
    reg        rst;
    reg        load_in;
    reg [1:0]  a11;
    reg [1:0]  a12;
    reg [1:0]  a21;
    reg [1:0]  a22;
    reg [1:0]  b11;
    reg [1:0]  b12;
    reg [1:0]  b21;
    reg [1:0]  b22;
    wire [19:0] result_out;
    wire       valid;



   wire [4:0] result_row00;
   wire [4:0] result_row01;
   wire [4:0] result_row10;
   wire [4:0] result_row11;

    mat_wrapper inst_mat_wrapper (
            .clk        (clk),
            .rst        (rst),
            .load_in    (load_in),
            .a11        (a11),
            .a12        (a12),
            .a21        (a21),
            .a22        (a22),
            .b11        (b11),
            .b12        (b12),
            .b21        (b21),
            .b22        (b22),
            .result_out (result_out),
            .valid      (valid)
        );

initial begin
        clk = 0;
        forever #5 clk = ~clk; // 10ns period clock
    end

    assign result_row00 = result_out[4:0];
    assign result_row01 = result_out[9:5];
    assign result_row10 = result_out[14:10];
    assign result_row11 = result_out[19:15];

    // Test sequence
    initial begin
        a11=2'b0;         a12=2'b0;
        a21=2'b0;         a22=2'b0;
        
        b11=2'b0;         b12=2'b0;
        b21=2'b0;         b22=2'b0;
        
        // Initialize inputs
        rst = 1;
        load_in = 0;

        // Apply reset
        #20;
        rst = 0;

        // Load first set of data
        #100;
        load_in = 1;
        
        a11 = 2'd3;
        a12 = 2'd3;
        a21 = 2'd3;
        a22 = 2'd3;

        b11 = 2'd3;
        b12 = 2'd3;
        b21 = 2'd3;
        b22 = 2'd3;

        #20 load_in = 0;

        wait(valid==1);


        

        // End simulation
        #200;
        $finish;
    end


endmodule
