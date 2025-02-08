`timescale 1ns/1ps

`include"uvm_macros.svh"
import uvm_pkg::*;

`include "test_pkg.sv"
import test_pkg::*;

`include "rtl.v"
`include "interface.sv"

module top_module;

	parameter DATA_TYPE = 3'b011;

	bit clk;
	bit rst;

	initial begin 
		forever #5 clk = ~clk;
	end
	
	intf #(.DATA_TYPE(DATA_TYPE)) vif();

	initial begin 
		#10 rst = 1'b1;
		
		#50 rst = 1'b0;
		// #50 $finish;
	end
	

	initial begin 

		uvm_config_db #(virtual intf #(.DATA_TYPE(DATA_TYPE))) :: set (null , "uvm_test_top.env_h.agent_h.mon_h" , "INTF_KEY" , vif);
		uvm_config_db #(virtual intf #(.DATA_TYPE(DATA_TYPE))) :: set (null , "uvm_test_top.env_h.agent_h.drv_h" , "INTF_KEY" , vif);

		run_test("integrated_test");
	end


	assign vif.clk   = clk;
	assign vif.rst = rst;

		systolic_2x2 #(
			.DATA_TYPE(DATA_TYPE)
		) inst_systolic_2x2 (
			.clk          (vif.clk),
			.rst          (vif.rst),
			.load_in      (vif.load_in),
			.row_in_row0  (vif.row_in_row0),
			.row_in_row1  (vif.row_in_row1),
			.col_in_col0  (vif.col_in_col0),
			.col_in_col1  (vif.col_in_col1),
			.result_row00 (vif.result_row00),
			.result_row01 (vif.result_row01),
			.result_row10 (vif.result_row10),
			.result_row11 (vif.result_row11),
			.carry_00     (vif.carry_00),
			.carry_01     (vif.carry_01),
			.carry_10     (vif.carry_10),
			.carry_11     (vif.carry_11),
			.done         (vif.done)
		);



endmodule