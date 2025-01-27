`timescale 1ns / 1ps

module test8x8;
    reg [7:0] a, b;
    wire [15:0] result;
    reg clk;

  vedic8x8 V0(a, b, clk, result);
        
        // Initialize values
  		initial begin
        a = 8'b10101011;
        b = 8'b10111100;
        #10;
        a = 8'b10111100;
        b = 8'b11001101;
        #10;
        a = 8'b11001101;
        b = 8'b11011110;
        #10;
        a = 8'b11011110;
        b = 8'b11101111;
        #10;
        a = 8'b11101111;
        b = 8'b11111010;
        end
        
  
    initial begin
      clk = 1;
    // Start the clock
    forever #0.5 clk = ~clk;
  end

  // Add a delay to allow simulation to run
  //initial #100 $finish; // Finish simulation
endmodule
