module adder18(a, b, clk, sum,reset,start,valid,s_ready);
    input [17:0] a, b;
    input clk;
    input reset,start,s_ready;
    output reg valid;
    output reg [17:0] sum;
    
    reg [17:0] r_a,r_b;

    always @(posedge clk,posedge reset) begin
        if(reset) 
        begin
            //valid <=0;
            r_a <= 0;
            r_b <=0;
        end
        else if(start)
            begin
            r_a <= a;
            r_b <= b;
            end
    end
    
    always @(posedge clk,posedge reset) begin
        if(reset)
            valid <=0;
        else
            if((s_ready&valid) == 1'b1)
               valid <=0;
            begin
               valid <=1;
               sum <= a + b;
            end
    end
    
endmodule