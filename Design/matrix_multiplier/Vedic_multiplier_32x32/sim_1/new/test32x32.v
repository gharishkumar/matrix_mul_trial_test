`timescale 1ns / 1ps

module test32x32;
    reg clk;
    reg reset;
    reg [31:0] a, b;
    reg        start;
    wire [63:0] result;
    wire valid_out;

  vedic32x32 V0(clk, reset, a, b, start, result, valid_out);
  
    initial begin
        clk = 1;
        forever #0.5 clk = ~clk;
    end

    initial begin
        reset = 1;
        #10 reset = ~reset;
    end
        
  	initial begin
        a = 32'd0;
        b = 32'd0;
        start = 0;
        wait(reset == 1'b0);
        repeat (10) begin
            @(posedge clk);
            a = $random();
            b = $random();
            start = 1;
            @(posedge clk);
            start = 0;
            wait(valid_out);          
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
            start = 1;
            @(posedge clk);
            start = 0;
            wait(valid_out);   
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
            a = 32'hFFFFFFFF;
            b = 32'hFFFFFFFF;
            start = 1;
            @(posedge clk);
            start = 0;
            wait(valid_out);         
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
        
endmodule
