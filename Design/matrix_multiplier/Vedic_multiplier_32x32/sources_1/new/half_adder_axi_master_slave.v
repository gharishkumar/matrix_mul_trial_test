module half_adder_axi_master_slave (
    input wire       clk,
    input wire       reset,

    // Slave Interface (Input from Master)
    input wire       s_a_tvalid,      // Slave valid signal (from master)
    input wire [1:0] s_a_tdata,       // Slave data signal (from master)
    output reg       s_a_tready,      // Slave ready signal (to master)

    input wire       s_b_tvalid,      // Slave valid signal (from master)
    input wire [1:0] s_b_tdata,       // Slave data signal (from master)
    output reg       s_b_tready,      // Slave ready signal (to master)

    // Master Interface (Output to Slave)
    output reg       m_sum_tvalid,      // Master valid signal (to slave)
    output reg [1:0] m_sum_tdata,       // Master data signal (to slave)
    input wire       m_sum_tready       // Master ready signal (from slave)

    output reg       m_sum_tvalid,      // Master valid signal (to slave)
    output reg [1:0] m_sum_tdata,       // Master data signal (to slave)
    input wire       m_sum_tready       // Master ready signal (from slave)
);

    // State machine states
    parameter IDLE    = 2'b00;
    parameter PROCESS = 2'b01;
    parameter DONE    = 2'b10;
    

    reg [1:0] current_state;

    // Internal signals for half adder
    reg a_reg, b_reg;
    reg sum_reg, carry_reg;

    // State machine logic (single always block)
    always @(posedge clk or posedge reset) begin
        if (reset) begin
            // Reset all signals and state
            current_state <= IDLE;
            s_tready <= 1'b0;
            m_tvalid <= 1'b0;
            m_tdata <= 2'b00;
            a_reg <= 1'b0;
            b_reg <= 1'b0;
            sum <= 1'b0;
            carry <= 1'b0;
        end else begin
            case (current_state)
                IDLE: begin
                    // Wait for valid input data
                    if (s_tvalid) begin
                        s_tready <= 1'b1; // Acknowledge input data
                        current_state <= PROCESS;
                    end else begin
                        s_tready <= 1'b0; // Not ready for input
                    end
                end

                PROCESS: begin
                    // Perform half adder logic
                    sum <= s_tdata[0] ^ s_tdata[1]; // Sum = A XOR B
                    carry <= s_tdata[0] & s_tdata[1]; // Carry = A AND B
                    s_tready <= 1'b0; // Stop accepting new input
                    current_state <= DONE;
                end

                DONE: begin
                    // Output the result
                    m_tdata <= {carry, sum}; // Master output data {Carry, Sum}
                    m_tvalid <= 1'b1; // Assert output valid

                    // Wait for downstream slave to accept data
                    if (m_tready) begin
                        m_tvalid <= 1'b0; // Deassert output valid
                        current_state <= IDLE; // Return to IDLE state
                    end
                end

                default: begin
                    // Handle unexpected states
                    current_state <= IDLE;
                end
            endcase
        end
    end

endmodule