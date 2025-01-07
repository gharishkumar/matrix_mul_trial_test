`timescale 1ns / 1ps

module tb_wallace_tree_32bit();

    wire [63:0] result;
    reg [31:0] a;
    reg [31:0] b;

    wallaceTreeMultiplier32Bit DUT (result, a, b);

    initial begin
        a = 32'h0101_0010;
        b = 32'h0101_0014;
        #10;
        $display("A = %d B = %d Result: %d", a, b, result);
        a = 32'h0101_0012;
        b = 32'h0101_0066;
        #10;
        $display("A = %d B = %d Result: %d", a, b, result);
        a = 32'h0000_0000;
        b = 32'h0101_0010;
        #10;
        $display("A = %d B = %d Result: %d", a, b, result);
        $finish;
    end
    
endmodule