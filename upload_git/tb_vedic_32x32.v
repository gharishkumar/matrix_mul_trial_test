`timescale 1ns / 1ps

module test32x32;
    reg [31:0] a, b;
    wire [63:0] result;
    wire valid_out;
    reg clk;
    reg rst;

  vedic32x32 V0(a, b, clk, rst, result, valid_out);
        
  		initial begin
  		
  		a= 0;
  		b= 0;
  		
        #100;
        repeat (10) begin
          @(posedge clk);
          a = $random();
          b = $random();
          #190;          
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
      forever #10 clk = ~clk;
    end

    initial begin
      rst = 1;
      #20 rst = ~rst;
    end
endmodule