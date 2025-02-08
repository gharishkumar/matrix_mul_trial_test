`ifndef INTF_
	`define INTF_

`timescale 1ns/1ps

interface intf # (DATA_TYPE = 3'b011);



	logic 		 clk;    
	logic 		 rst;    
	bit 		 load_in; 

	logic [31:0] row_in_row0; 
	logic [31:0] row_in_row1; 
    logic [31:0] col_in_col0; 
    logic [31:0] col_in_col1; 

    logic [63:0] result_row00; 
    logic [63:0] result_row01; 
    logic [63:0] result_row10; 
    logic [63:0] result_row11;  

    logic 		 carry_00; 
    logic 		 carry_01; 
    logic 		 carry_10; 
    logic 		 carry_11;  
      
    logic 		 done;


    endinterface : intf

`endif