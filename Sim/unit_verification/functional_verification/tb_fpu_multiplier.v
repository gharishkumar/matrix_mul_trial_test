`timescale 1ns / 1ps

module tb_fpu_multiplier;
    
    reg clk;
    reg rst;
    reg [31:0] input_a;
    reg input_a_stb;
    wire input_a_ack;
    reg [31:0] input_b;
    reg input_b_stb;
    wire input_b_ack;
    reg output_z_ack;
    wire [31:0] output_z;
    wire output_z_stb;
    
    fpu_multiplier uut (
        .clk(clk),
        .rst(rst),
        .input_a(input_a),
        .input_a_stb(input_a_stb),
        .input_a_ack(input_a_ack),
        .input_b(input_b),
        .input_b_stb(input_b_stb),
        .input_b_ack(input_b_ack),
        .output_z(output_z),
        .output_z_stb(output_z_stb),
        .output_z_ack(output_z_ack)
    );
    
    // Clock generation
    initial begin
        clk = 0;
        forever #5 clk = ~clk;
    end
    
    initial begin
        clk = 0;
        rst = 1;
        input_a = 0;
        input_a_stb = 0;
        input_b = 0;
        input_b_stb = 0;
        output_z_ack = 0;
        
        // Reset pulse
        #10 rst = 0;
        
        // Test case 1: 1.0 * 2.0 = 2.0
        #10;
        // Send input_a
        input_a = 32'h3F800000;
        input_a_stb = 1;
        wait(input_a_ack);
        input_a_stb = 0;
        
        // Send input_b
        input_b = 32'h40000000;
        input_b_stb = 1;
        wait(input_b_ack);
        input_b_stb = 0;
        
        // Wait for output
        wait(output_z_stb);
        output_z_ack = 1;
        #10 output_z_ack = 0;
        
        // Test case 2: 3.0 * 4.0 = 12.0
        #10;
        input_a = 32'h40400000;
        input_a_stb = 1;
        wait(input_a_ack);
        input_a_stb = 0;
        
        input_b = 32'h40800000;
        input_b_stb = 1;
        wait(input_b_ack);
        input_b_stb = 0;
        
        wait(output_z_stb);
        output_z_ack = 1;
        #10 output_z_ack = 0;
        
        // Test case 3: Multiplication of zero and a number
        #10;
        input_a = 32'h00000000;
        input_a_stb = 1;
        wait(input_a_ack);
        input_a_stb = 0;
        
        input_b = 32'h3F800000;
        input_b_stb = 1;
        wait(input_b_ack);
        input_b_stb = 0;
        
        wait(output_z_stb);
        output_z_ack = 1;
        #10 output_z_ack = 0;
        
        // Test case 4: Multiplication involving infinity
        #10;
        input_a = 32'h7F800000;
        input_a_stb = 1;
        wait(input_a_ack);
        input_a_stb = 0;
        
        input_b = 32'h3F800000;
        input_b_stb = 1;
        wait(input_b_ack);
        input_b_stb = 0;
        
        wait(output_z_stb);
        output_z_ack = 1;
        #10 output_z_ack = 0;
        
        #5000;
        $finish;
    end
        
endmodule : tb_fpu_multiplier