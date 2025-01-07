`timescale 1ns / 1ps

module test32x32;
    reg [31:0] a, b;
    wire [63:0] result;
    reg clk;

  vedic32x32 V0(a, b, clk, result);
        
        // Initialize values
  		initial begin
        a = $random();
        b = $random();
        #300;
        a = $random();
        b = $random();
        #300;
        a = $random();
        b = $random();
        #300;
        a = $random();
        b = $random();
        #100;
        a = $random();
        b = $random();
        end
        
  
    initial begin
      clk = 1;
    // Start the clock
    forever #0.5 clk = ~clk;
  end

  // Add a delay to allow simulation to run
  //initial #100 $finish; // Finish simulation
endmodule
