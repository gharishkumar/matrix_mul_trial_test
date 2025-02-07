`timescale 1ns / 1ps

module test32x32;
    reg clk;
    reg rst;
    reg [31:0] a, b;
    reg        do;
    wire [63:0] result;
    wire valid_out;

  vedic32x32 V0(clk, rst, a, b, do, result, valid_out);
        
  	initial begin

        repeat (10) begin
            @(posedge clk);
            a = $random();
            b = $random();
            do = 1;
            @(posedge clk);
            do = 0;
            #70;          
            $display("A = %d B = %d Result: %d", a, b, result);
            if(result == a * b) begin
                $display("Result match");
            end else begin
                $display("expected");
                $display("result = %d", a * b);
                $display("Result not match");
            end
        end

        repeat (5) begin
            @(posedge clk);
            // a = $random();
            // b = $random();
            do = 1;
            @(posedge clk);
            do = 0;
            #230;          
            $display("A = %d B = %d Result: %d", a, b, result);
            if(result == a * b) begin
                $display("Result match");
            end else begin
                $display("expected");
                $display("result = %d", a * b);
                $display("Result not match");
            end
        end
        $finish;
    end
        
  
    initial begin
      clk = 1;
      forever #0.5 clk = ~clk;
    end

    initial begin
      rst = 1;
      #10 rst = ~rst;
    end
endmodule
