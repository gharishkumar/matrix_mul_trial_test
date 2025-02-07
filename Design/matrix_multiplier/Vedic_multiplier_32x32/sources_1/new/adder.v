module adder #(
    parameter N = 1
) (
    input wire clk,
    input wire [N-1:0] a_in, b_in,
    output reg [N  :0] result_out
);

    always @(posedge clk) begin
        result_out <= a_in + b_in;
    end
endmodule