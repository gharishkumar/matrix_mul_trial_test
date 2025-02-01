`timescale 1ns / 1ps

module tb_half_adder_axi_master_slave;

    // Inputs
    reg clk;
    reg reset;
    reg s_tvalid;      // Slave valid signal (from master)
    reg [1:0] s_tdata; // Slave data signal (from master)
    reg m_tready;      // Master ready signal (from slave)

    // Outputs
    wire s_tready;     // Slave ready signal (to master)
    wire m_tvalid;     // Master valid signal (to slave)
    wire [1:0] m_tdata; // Master data signal (to slave)

    // Instantiate the Unit Under Test (UUT)
    half_adder_axi_master_slave uut (
        .clk(clk),
        .reset(reset),
        .s_tvalid(s_tvalid),
        .s_tdata(s_tdata),
        .s_tready(s_tready),
        .m_tvalid(m_tvalid),
        .m_tdata(m_tdata),
        .m_tready(m_tready)
    );

    // Clock generation
    initial begin
        clk = 0;
        forever #5 clk = ~clk; // 10ns clock period
    end

    // Testbench logic
    initial begin
        // Initialize inputs
        reset = 1;
        s_tvalid = 0;
        s_tdata = 2'b00;
        m_tready = 0;

        // Apply reset
        #20;
        reset = 0;

        // Test case 1: A = 0, B = 0
        #10;
        s_tvalid = 1;
        s_tdata = 2'b00; // A = 0, B = 0
        #10;
        s_tvalid = 0;

        // Wait for the result
        wait (m_tvalid == 1);
        m_tready = 1; // Acknowledge the result
        #10;
        m_tready = 0;

        // Test case 2: A = 1, B = 0
        #10;
        s_tvalid = 1;
        s_tdata = 2'b01; // A = 1, B = 0
        #10;
        s_tvalid = 0;

        // Wait for the result
        wait (m_tvalid == 1);
        m_tready = 1; // Acknowledge the result
        #10;
        m_tready = 0;

        // Test case 3: A = 0, B = 1
        #10;
        s_tvalid = 1;
        s_tdata = 2'b10; // A = 0, B = 1
        #10;
        s_tvalid = 0;

        // Wait for the result
        wait (m_tvalid == 1);
        m_tready = 1; // Acknowledge the result
        #10;
        m_tready = 0;

        // Test case 4: A = 1, B = 1
        #10;
        s_tvalid = 1;
        s_tdata = 2'b11; // A = 1, B = 1
        #10;
        s_tvalid = 0;

        // Wait for the result
        wait (m_tvalid == 1);
        m_tready = 1; // Acknowledge the result
        #10;
        m_tready = 0;

        // End simulation
        #20;
        $stop;
    end

    // Monitor outputs
    initial begin
        $monitor("Time: %0t | s_tvalid: %b | s_tdata: %b | s_tready: %b | m_tvalid: %b | m_tdata: %b | m_tready: %b",
                 $time, s_tvalid, s_tdata, s_tready, m_tvalid, m_tdata, m_tready);
    end

endmodule