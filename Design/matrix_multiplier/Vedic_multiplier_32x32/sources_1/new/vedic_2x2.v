`timescale 1ns / 1ps

module vedic_2x2(
    input wire clk,
    input wire arst_n,
    input wire [1:0] s_a_tdata,  
    input wire [1:0] s_b_tdata,

    input wire s_a_tvalid,
    output reg s_a_tready,

    input wire s_b_tvalid,
    output reg s_b_tready,

    output reg [3:0] m_result_tdata,
    output reg m_tvalid,
    input wire m_tready
);

    
    reg a_reg, b_reg;
    reg state;
    
    reg m_result_tdata_reg;
    reg s_a_tvalid_ha_1_reg, s_b_tvalid_ha_1_reg, s_b_tvalid_ha_2_reg;

    reg calc_done, a_done, b_done;
    wire  m_handshake, s_a_handshake, s_b_handshake;

    wire [1:0] m_result_tdata_ha_1;
    wire [1:0] m_result_tdata_ha_2;
    
    assign s_a_tdata_ha_1 = s_a_tdata[0] & s_b_tdata[1];
    assign s_b_tdata_ha_1 = s_a_tdata[1] & s_b_tdata[0];

    assign s_a_tdata_ha_2 = m_result_tdata_ha_1[1];
    assign s_b_tdata_ha_2 = s_a_tdata[1] & s_b_tdata[1];


    assign m_handshake = m_tvalid&m_tready;

    assign s_a_handshake = s_a_tvalid&s_a_tready;
    assign s_b_handshake = s_b_tvalid&s_b_tready;
    
    assign s_a_tvalid_ha_1 = s_a_tvalid_ha_1_reg;
    assign s_b_tvalid_ha_1 = s_b_tvalid_ha_1_reg;
    assign s_b_tvalid_ha_2 = s_b_tvalid_ha_2_reg;
    


    halfAdder inst_halfAdder_1 (
            .clk            (clk),
            .arst_n         (arst_n),
            .s_a_tdata      (s_a_tdata_ha_1),
            .s_b_tdata      (s_b_tdata_ha_1),
            .s_a_tvalid     (s_a_tvalid_ha_1),
            .s_a_tready     (s_a_tready_ha_1),
            .s_b_tvalid     (s_b_tvalid_ha_1),
            .s_b_tready     (s_b_tready_ha_1),
            .m_result_tdata (m_result_tdata_ha_1),
            .m_tvalid       (m_tvalid_ha_1),
            .m_tready       (m_tready_ha_1)
        );

    halfAdder inst_halfAdder_2 (
        .clk            (clk),
        .arst_n         (arst_n),
        .s_a_tdata      (s_a_tdata_ha_2),
        .s_b_tdata      (s_b_tdata_ha_2),
        .s_a_tvalid     (m_tvalid_ha_1),
        .s_a_tready     (s_a_tready_ha_2),
        .s_b_tvalid     (s_b_tvalid_ha_2),
        .s_b_tready     (s_b_tready_ha_2),
        .m_result_tdata (m_result_tdata_ha_2),
        .m_tvalid       (m_tvalid_ha_2),
        .m_tready       (m_tready_ha_2)
    );


    parameter CAPTURE_DATA = 1'b0,
              COMPUTE_DATA = 1'b1;

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
            state     <= CAPTURE_DATA;
            s_a_tvalid_ha_1_reg <= 1'b0;
            s_b_tvalid_ha_1_reg <= 1'b0;
            s_b_tvalid_ha_2_reg <= 1'b0;
        end else begin
            case (state)
                CAPTURE_DATA : begin
                        if(a_done&&b_done) begin
                        state     <= COMPUTE_DATA;
                        calc_done <= 1'b0;
                        s_a_tvalid_ha_1_reg <= 1'b1;
                        s_b_tvalid_ha_1_reg <= 1'b1;
                        s_b_tvalid_ha_2_reg <= 1'b1;
                        end
                end
                COMPUTE_DATA : begin
                               if (m_tvalid_ha_2) begin
                               calc_done <= 1'b1;
                               state     <= CAPTURE_DATA;
                               m_result_tdata_reg <= {m_result_tdata_ha_2, m_result_tdata_ha_1[0], (s_a_tdata[0]&s_b_tdata[0])};
                               end
                end
                default : state <= CAPTURE_DATA;
              endcase  
        end
    end

    //driving m_tvalid
        always @(posedge clk , negedge arst_n) begin
        if (!arst_n) begin
            m_tvalid <= 0;
            m_result_tdata <= 1'b0;
        end
        else 
            begin
                    if(m_handshake) begin
                            m_tvalid  <=  1'b0;
                    end 
                    else if (calc_done) begin
                            m_result_tdata <= m_result_tdata_reg;
                            m_tvalid  <=  1'b1;
                    end
            end 
        end

endmodule
