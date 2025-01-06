module tb_wallace_tree_8bit();

    wire [15:0] result;
    reg [7:0] a;
    reg [7:0] b;

    wallaceTreeMultiplier8Bit DUT (result, a, b);

    initial begin
        a = 8'd10;
        b = 8'd20;
        #10;
        $display("A = %d B = %d Result: %d", a, b, result);
        a = 8'd30;
        b = 8'd40;
        #10;
        $display("A = %d B = %d Result: %d", a, b, result);
        a = 8'd40;
        b = 8'd50;
        #10;
        $display("A = %d B = %d Result: %d", a, b, result);
        $finish;
    end
    
endmodule