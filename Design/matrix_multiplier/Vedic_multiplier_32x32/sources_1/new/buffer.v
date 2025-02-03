module buffer #(
    parameter N = 1
) (
    input wire clk,
    input wire [N-1:0] d_in,
    output reg [N-1:0] d_out
);
    always @(posedge clk) begin
        d_out <= d_in;      
    end
endmodule