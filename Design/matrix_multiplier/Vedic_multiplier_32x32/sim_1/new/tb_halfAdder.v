`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 29.01.2025 15:34:41
// Design Name: 
// Module Name: tb_ha_try
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


module tb_ha_try;

    // Inputs
    reg clk;
    reg arst_n;
    reg s_a_tdata;
    reg s_b_tdata;
    reg s_a_tvalid;
    reg s_b_tvalid;
    reg m_tready;

    // Outputs
    wire s_a_tready;
    wire s_b_tready;
    wire [1:0] m_result_tdata;
    wire m_tvalid;

    // Instantiate the module under test
    halfAdder_try uut (
        .clk(clk),
        .arst_n(arst_n),
        .s_a_tdata(s_a_tdata),
        .s_b_tdata(s_b_tdata),
        .s_a_tvalid(s_a_tvalid),
        .s_a_tready(s_a_tready),
        .s_b_tvalid(s_b_tvalid),
        .s_b_tready(s_b_tready),
        .m_result_tdata(m_result_tdata),
        .m_tvalid(m_tvalid),
        .m_tready(m_tready)
    );

    // Clock generation
    initial begin
        clk = 1'b0;
        forever #5 clk = ~clk; // 10ns clock period
    end

    always #10 s_a_tdata = $random;
    always #10 s_b_tdata = $random;
    
    // Test sequence
    initial begin
        // Initialize inputs
        arst_n = 1'b1;
        s_a_tdata = 1'b0;
        s_b_tdata = 1'b0;
        s_a_tvalid = 1'b0;
        s_b_tvalid = 1'b0;
        m_tready = 1'b0;
        

        // Apply asynchronous reset
        #15;
        arst_n = 1'b0;
        #10;
        arst_n = 1'b1;
        
        
        #10;
        
        s_a_tvalid = 1'b1;
        s_b_tvalid = 1'b1;
        m_tready = 1'b1; // Accept result

        // Wait for a and b to be captured
//        wait(s_a_tready == 1'b0 && s_b_tready == 1'b0);
//        #10;
//        s_a_tvalid = 1'b0;
//        s_b_tvalid = 1'b0;

        // Wait for valid output
//        wait(m_tvalid == 1'b1);
//        #10;
//        m_tready = 1'b1; // Accept result
//        #10;
//        m_tready = 1'b0;

        // Test case 2: Second set of inputs
        #20;
//        s_a_tdata = 1'b1;
//        s_b_tdata = 1'b0;
//        s_a_tvalid = 1'b1;
//        s_b_tvalid = 1'b1;

//        // Wait for a and b to be captured
//        wait(s_a_tready == 1'b0 && s_b_tready == 1'b0);
//        #10;
//        s_a_tvalid = 1'b0;
//        s_b_tvalid = 1'b0;

        // Wait for valid output
//        wait(m_tvalid == 1'b1);
//        m_tready = 1'b1; // Accept result
//        #10;
//        m_tready = 1'b0;

        // Test case 3: Third set of inputs
        #20;
//        s_a_tdata = 1'b0;
//        s_b_tdata = 1'b1;
//        s_a_tvalid = 1'b1;
//        s_b_tvalid = 1'b1;

//        // Wait for a and b to be captured
//        wait(s_a_tready == 1'b0 && s_b_tready == 1'b0);
//        #10;
//        s_a_tvalid = 1'b0;
//        s_b_tvalid = 1'b0;

        // Wait for valid output
//        wait(m_tvalid == 1'b1);
//        #10;
//        m_tready = 1'b0;

        // End simulation
        #20;
        $stop;
    end

    // Monitor signals
    initial begin
        $monitor("Time: %0t | clk: %b | arst_n: %b | s_a_tdata: %b | s_b_tdata: %b | s_a_tvalid: %b | s_a_tready: %b | s_b_tvalid: %b | s_b_tready: %b | m_result_tdata: %b | m_tvalid: %b | m_tready: %b",
                 $time, clk, arst_n, s_a_tdata, s_b_tdata, s_a_tvalid, s_a_tready, s_b_tvalid, s_b_tready, m_result_tdata, m_tvalid, m_tready);
    end

endmodule