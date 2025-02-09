`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 11/13/2024 02:42:25 PM
// Design Name: 
// Module Name: fsm_button
// Project Name: 
// Target Devices: 
// Tool Versions: 
// Description: 
// 
// Dependencies: 
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
//////////////////////////////////////////////////////////////////////////////////


module fsm_button(
    input wire clk,
    input wire reset,
    input wire btn,
    output wire d_out
    );

parameter RESET_C = 1'b0;
parameter ASSERT_C = 1'b1;

reg  button;
reg state;

always @(posedge clk or posedge reset) begin
    if(reset) begin
        state <= RESET_C;
        button <= 0;
    end  else begin
        case(state) 
            RESET_C : 
                    begin
                        if(btn) begin
                            button<= 1'b1;
                            state <= ASSERT_C;
                        end else begin
                            button<= 1'b0;
                            state <= RESET_C;
                        end
                    end

            ASSERT_C : 
                    begin
                        if(btn) begin
                            button<= 1'b0;
                            state <= ASSERT_C;
                        end else begin
                            button<= 1'b0;
                            state <= RESET_C;
                        end
                    end

            default : 
                    begin
                        button<= 1'b0;
                        state <= RESET_C;
                    end
        endcase
    end
end

assign d_out = button;

endmodule

