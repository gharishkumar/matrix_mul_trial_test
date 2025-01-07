`timescale 1ns / 1ps

module tb_wallace_tree_32bit();

    wire [63:0] result;
    reg [31:0] a;
    reg [31:0] b;
    reg flag;

    wallaceTreeMultiplier32Bit DUT (result, a, b);

    initial begin
        repeat (7) begin
            a = $random;
            b = $random;
            #10;
            $display("A = %d B = %d Result: %d", a, b, result);
            if(result == a * b) begin
                $display("Result match");
            end else begin
                $display("Result not match");
            end
        end
        $finish;
    end
    
endmodule