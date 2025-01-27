module halfAdder (
    input wire clk,
    input wire rst,
    input wire a_in,  
    input wire b_in,
    input wire valid_in,
    output reg ready_out,
    output reg sum_out,
    output reg carry_out,
    output reg valid_out,
    input wire ready_in
);

    reg a_reg, b_reg;
    reg [1:0]  state;

    parameter RESET        = 2'b00,
              READY_OUT1   = 2'b01,
              COMPUTE_DATA = 2'b10,
              VALID_OUT1   = 2'b11;

    always @(posedge clk) begin
        if (rst) begin
            ready_out <= 0;
            valid_out <= 0;
            a_reg <= 1'b0;
            b_reg <= 1'b0;
            state <= RESET;
        end else begin
            case (state)
                RESET : begin
                        if(valid_in) begin
                            a_reg     <= a_in;
                            b_reg     <= b_in;
                            ready_out <=  1'b1;
                            state     <= READY_OUT1;
                        end
                end
                READY_OUT1 : begin
                            ready_out <= 1'b1;
                            state     <= COMPUTE_DATA;
                end
                COMPUTE_DATA : begin
                               {carry_out ,  sum_out } <= a_reg + b_reg;
                               valid_out               <= 1'b1;
                               state                   <= VALID_OUT1;
                end
                VALID_OUT1 : begin
                             if(ready_in) begin
                                 valid_out <= 1'b0;
                                 state     <= RESET;
                             end
                end
                default : state <= RESET;
              endcase  
        end
    end
endmodule





// module halfAdder (
//     input wire clk,
//     input wire rst,
//     input wire a_in,  
//     input wire b_in,
//     input wire valid_in,
//     output reg ready_out,
//     output reg sum_out,
//     output reg carry_out,
//     output reg valid_out,
//     input wire ready_in
// );

//     reg a_reg, b_reg;
//     // reg internal_valid_out;
//     reg load;

//    always @(posedge clk) begin
    //     if (rst) begin
    //         ready_out <= 0;
    //         valid_out <= 0;
    //         a_reg <= 1'b0;
    //         b_reg <= 1'b0;
    //         load <= 0;
    //     end else begin
    //         if (valid_in && !load) begin
    //             a_reg <= a_in;
    //             b_reg <= b_in;
    //             load <= 1;
    //             ready_out <= 1;  
    //         end else if (load) begin
    //             {carry_out, sum_out} <= a_reg + b_reg;  // Example operation (sum of a and b)
    //             valid_out <= 1;             // Indicate output data is valid
    //             load <= 0;            // Reset load flag
    //             ready_out <= 1'b0;
    //         end else if (valid_out && ready_in) begin
    //             valid_out <= 1'b0;
    //         end
    //     end
    // end

// endmodule


// module halfAdder(
//     input wire  clk,
//     input wire  rst,
//     input wire  a, 
//     input wire  b, 
//     input wire  valid_in,
//   	output reg  sum,
//   	output reg  carry,
//     output reg  ready_out
//     );

// 	always @(posedge clk) begin
//         if(rst) begin
//             ready_out <= 1'b0;
//         end else if (valid_in && !ready_out) begin
            
//         end
//     end

// endmodule

