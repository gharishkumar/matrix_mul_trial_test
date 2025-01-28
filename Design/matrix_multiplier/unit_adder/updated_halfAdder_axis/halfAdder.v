module halfAdder (
    input wire clk,
    input wire arst_n,
    input wire s_a_tdata,  
    input wire s_b_tdata,
    input wire s_a_tvalid,
    output reg s_a_tready,
    input wire s_b_tvalid,
    output reg s_b_tready,

    output reg [1:0] m_result_tdata,
    output reg m_tvalid,
    input wire m_tready
);
    reg sum_out;
    reg carry_out;
    reg a_reg, b_reg;
    reg [2:0]  state;
    reg calc_done,a_done,b_done;
    wire  m_handshake,s_a_handshake,s_b_handshake;

    assign m_handshake = m_tvalid&m_tready;

    assign s_a_handshake = s_a_tvalid&s_a_tready;
    assign s_b_handshake = s_b_tvalid&s_b_tready;

    parameter CAPTURE_DATA  = 3'b000,
              READY_OUT1   = 3'b001,
              COMPUTE_DATA = 3'b010,
              VALID_OUT1   = 3'b011,
              RST_VALID    = 3'b100;

    //capturing data
    always @(posedge clk , negedge arst_n) begin
        if (!arst_n) begin
            a_reg <= 0;
            a_done <=0;
            s_a_tready  <=  1'b1;
        end
        else 
            begin
                    if(s_a_handshake) begin
                            s_a_tready  <=  1'b0;
                            a_reg <= s_a_tdata;
                            a_done <=1;
                    end 
                    else if (m_tvalid) begin
                            s_a_tready  <=  1'b1;
                            a_done <=0;
                    end
            end 
        end

    always @(posedge clk , negedge arst_n) begin
        if (!arst_n) begin
            b_reg <= 0;
            b_done <=0;
            s_b_tready  <=  1'b1;
        end
        else 
            begin
                    if(s_b_handshake) begin
                            s_b_tready  <=  1'b0;
                            b_reg <= s_b_tdata;
                            b_done<=1;
                    end 
                    else if (m_tvalid) begin
                            s_b_tready  <=  1'b1;
                            b_done <=0;
                    end
            end 
        end

    //FSM
    always @(posedge clk , negedge arst_n) begin
        if (!arst_n) begin
            calc_done <= 0;
            a_reg <= 1'b0;
            b_reg <= 1'b0;
            state <= CAPTURE_DATA;
            //TODO : reset carry out and sum out
        end else begin
            case (state)
                CAPTURE_DATA : begin
                        if(a_done&&b_done) begin
                        state     <= COMPUTE_DATA;
                        calc_done               <= 1'b0;
                        end
                end
                //READY_OUT1 : begin
                //            s_tready  <= 1'b0;
                //            state     <= COMPUTE_DATA;
                //end
                COMPUTE_DATA : begin
                               {carry_out,  sum_out } <= a_reg + b_reg;
                               calc_done               <= 1'b1;
                               state                  <= CAPTURE_DATA;
                end
                // VALID_OUT1 : begin
                //              if(m_tready) begin
                //                  m_tvalid  <= 1'b0;
                //                  state     <= CAPTURE_DATA;
                //              end 
                //end
                // RST_VALID : begin
                //             if (!m_tready) begin
                //                  m_tvalid  <= 1'b0;
                //                  state     <= CAPTURE_DATA;
                //             end
                // end
                default : state <= CAPTURE_DATA;
              endcase  
        end
    end

    // //driving s_tready
    //     always @(posedge clk , negedge arst_n) begin
    //     if (arst_n) begin
    //         s_tready <= 1;
    //     end
    //     else 
    //         begin
    //                 if(s_handshake) begin
    //                         s_tready  <=  1'b0;
    //                 end 
    //                 else if (m_tvalid) begin
    //                         s_tready  <=  1'b1;
    //                 end
    //         end 
    //     end

    //driving m_tvalid
        always @(posedge clk , negedge arst_n) begin
        if (!arst_n) begin
            m_tvalid <= 0;
        end
        else 
            begin
                    if(m_handshake) begin
                            m_tvalid  <=  1'b0;
                    end 
                    else if (calc_done) begin
                            m_result_tdata <= {carry_out,  sum_out };
                            m_tvalid  <=  1'b1;
                    end
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
    //             load <= 0;            // CAPTURE_DATA load flag
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

