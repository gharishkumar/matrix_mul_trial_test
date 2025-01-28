`timescale 1ns/1ps

module decimal_to_bram_bram_rom
    (
        input wire clk,
        input wire [2:0] addr,
        output reg [31:0] data_out
    );

    (* rom_style = "block" *)

    // Memory array
    reg [31:0] rom [0:7];

    initial begin
        rom[0] = 32'b01000001011000110011010000000100;
        rom[1] = 32'b01000001110110011001101000110110;
        rom[2] = 32'b01000001100110011001101101110001;
        rom[3] = 32'b01000010100101100111100010100000;
        rom[4] = 32'b01000010001101111001010100011000;
        rom[5] = 32'b01000001101111001000110100011011;
        rom[6] = 32'b01000001010101110111110010000100;
        rom[7] = 32'b01000001111011101100010011010000;
    end

    always @(posedge clk) begin
        data_out <= rom[addr];
    end

endmodule