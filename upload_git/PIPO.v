module PIPO #(
    parameter N = 1
) (
    input wire clk,
    input wire reset,
    input wire [N-1:0] d_in,
    input wire do,
    output reg [N-1:0] d_out,
    output reg done
);

    always @(posedge clk) begin
        if (reset) begin
            done <= 1'b0;
        end else if (do) begin
            d_out <= d_in;
            done <= 1'b1;
        end else begin
            done <= 1'b0;
        end
    end

endmodule
