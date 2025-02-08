`ifndef MONITOR_
	`define MONITOR_

class monitor extends uvm_monitor;


	seq_item itm_h;
	

	uvm_analysis_port #(seq_item) mon_put_port;

	parameter DATA_TYPE = 3'b011;

	virtual intf #(.DATA_TYPE(DATA_TYPE)) vif;

	static int count = 0;

	// `uvm_component_utils(monitor)
	`uvm_component_utils_begin(monitor)
	/**** `uvm_field_* macro invocations here ****/
	`uvm_component_utils_end

	// Constructor
	function new(string name = "monitor", uvm_component parent);
		super.new(name, parent);
		mon_put_port = new("mon_put_port", this);
	endfunction

	// build
	function void build_phase(uvm_phase phase);
		super.build_phase(phase);
		`uvm_info(get_type_name(), "Build phase of MONITOR", UVM_NONE)		
		if (uvm_config_db #(virtual intf #(.DATA_TYPE(DATA_TYPE))) :: get (this,"","INTF_KEY",vif)) begin 
			`uvm_info(get_type_name(), "RECEIVED in MONITOR",UVM_NONE)
		end else begin 
			`uvm_fatal(get_type_name(), "NOT RECEIVED in MONITOR")
		end
	endfunction

	// run
	task run_phase(uvm_phase phase);
		super.run_phase(phase);
		forever begin 
			// #1;
			if (!vif.rst) begin 
				monitor_data();
			end else begin
				`uvm_info(get_type_name(), "Reset is driving one!", UVM_NONE)
				@(posedge vif.clk);
			end
		end
	endtask

	task monitor_data();
		itm_h=seq_item::type_id::create("itm_h");
		@(posedge vif.clk);
		if (vif.done) begin
			count++;
			itm_h.load_in        = vif.load_in;
			itm_h.row_in_row0    = vif.row_in_row0;
			itm_h.row_in_row1    = vif.row_in_row1;
			itm_h.col_in_col0    = vif.col_in_col0;
			itm_h.col_in_col1    = vif.col_in_col1;

			itm_h.result_row00    = vif.result_row00;
			itm_h.result_row01    = vif.result_row01;
			itm_h.result_row10    = vif.result_row10;
			itm_h.result_row11    = vif.result_row11;
			itm_h.carry_00        = vif.carry_00;

			itm_h.carry_01        = vif.carry_01;
			itm_h.carry_10        = vif.carry_10;
			itm_h.carry_11        = vif.carry_11;
			itm_h.done            = vif.done;

			mon_put_port.write(itm_h);
		`uvm_info(get_type_name(), "PRINTING VALUES FROM MONITOR", UVM_NONE)
		itm_h.print();
			`uvm_info(get_type_name(),"MONITOR WRITING DATA", UVM_NONE)			
		end else begin 
			`uvm_info(get_type_name(),"done is not here", UVM_NONE)
		end 
		
	endtask

	function void report_phase (uvm_phase phase);
		super.report_phase(phase);
		`uvm_info(get_type_name(), $sformatf("total number of Transactions from monitor : %0d",count), UVM_NONE)
	endfunction : report_phase

endclass

`endif