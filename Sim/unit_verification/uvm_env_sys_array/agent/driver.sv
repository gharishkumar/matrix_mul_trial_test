`ifndef DRIVER_
	`define DRIVER_

class driver extends uvm_driver #(seq_item);

	parameter DATA_TYPE =3'b011;

	virtual intf #(.DATA_TYPE(DATA_TYPE)) vif;

	seq_item seq;
	
	`uvm_component_utils_begin(driver)
	`uvm_component_utils_end

	// Constructor
	function new(string name = "driver", uvm_component parent);
		super.new(name, parent);
	endfunction 

	// build
	function void build_phase(uvm_phase phase);
		super.build_phase(phase);
		`uvm_info(get_type_name(), "Build phase of DRIVER", UVM_NONE)
		if (uvm_config_db #(virtual intf #(.DATA_TYPE(DATA_TYPE))) :: get (this,"","INTF_KEY",vif)) begin
			`uvm_info(get_type_name(), "RECEIVED in DRIVER",UVM_NONE)
		end else begin 
			`uvm_fatal(get_type_name(), "NOT RECEIVED in DRIVER")
		end
	endfunction

	// run
	task run_phase(uvm_phase phase);
		super.run_phase(phase);
		forever begin 
			#1;
			if (!vif.rst) begin 
				seq_item_port.get_next_item(seq);
				`uvm_info(get_type_name(), "DATA PRINTING FROM DRIVER", UVM_NONE)
				seq.display();
				// seq.print();
				// wait (vif.rst_n==1);
				drive_data(seq);
				seq_item_port.item_done(seq);
				`uvm_info(get_type_name(), "DATA passed to vif", UVM_NONE)
			end else begin 
				`uvm_info(get_type_name(), "Reset is LOW", UVM_NONE)
				@(posedge vif.clk);
			end
		end
	endtask

	task drive_data(seq_item  seq);
				seq.assign_val(); 
		
		@(posedge vif.clk);
	    vif.load_in       <= seq.load_in;
	    vif.row_in_row0   <= seq.row_in_row0;
	    vif.row_in_row1   <= seq.row_in_row1;
	    vif.col_in_col0   <= seq.col_in_col0;
	    vif.col_in_col1   <= seq.col_in_col1;

	    seq.result_row00  = vif.result_row00;
	    seq.result_row01  = vif.result_row01;
	    seq.result_row10  = vif.result_row10;
	    seq.result_row11  = vif.result_row11;
	    seq.carry_00      = vif.carry_00;

	    seq.carry_01      = vif.carry_01;
	    seq.carry_10      = vif.carry_10;
	    seq.carry_11      = vif.carry_11;
	    seq.done          = vif.done;
		seq_item_port.put_response(seq);

		rsp_port.write(seq);
		`uvm_info(get_type_name(), "PRINTING VALUES FROM DRIVER", UVM_NONE)
		seq.print();
	endtask : drive_data

endclass

`endif