`ifndef SCOREBOARD_
	`define SCOREBOARD_
	`uvm_analysis_imp_decl(_A)
	`uvm_analysis_imp_decl(_B)

class scoreboard extends uvm_scoreboard;

	uvm_analysis_imp_A #(seq_item, scoreboard) score_imp_mon;
	uvm_analysis_imp_B #(seq_item, scoreboard) score_imp_driver;

	seq_item mon_data;
	seq_item drv_data;

	seq_item mon_to_sb[$];
	seq_item drv_to_sb[$];

	event drv_trigger, mon_trigger;
	static int count=0;

	`uvm_component_utils_begin(scoreboard)
	`uvm_component_utils_end

	// Constructor
	function new(string name = "scoreboard", uvm_component parent);
		super.new(name, parent);
		score_imp_mon    = new("score_imp_mon", this);
		score_imp_driver = new("score_imp_driver", this);
	endfunction

	// Build phase
	function void build_phase(uvm_phase phase);
		super.build_phase(phase);
		`uvm_info(get_type_name(), "Build phase of scoreboard", UVM_NONE)
	endfunction

	// Run phase
	virtual task run_phase(uvm_phase phase);
		super.run_phase(phase);
		forever begin
			#1;
			@(mon_trigger);
			@(drv_trigger);
			// if (mon_to_sb.size() > 0 && drv_to_sb.size() > 0) begin
				mon_data = mon_to_sb.pop_front();
				drv_data = drv_to_sb.pop_front();
				// if (mon_data.en) begin 
					// if (mon_data.ctrl) begin
					// 	// if (mon_data.data1 + mon_data.data2 == drv_data.data_out) begin 
					// 	if (col_1_mul(mon_data.data1 , mon_data.data2) == drv_data.data_out) begin
					// 		`uvm_info(get_type_name(), "col 1 Data matched ", UVM_NONE)
					// 	end else begin 
					// 		`uvm_error(get_type_name(), "col 1 DATA not mached ")
					// 	end
					// end else begin 
					// 	// if (mon_data.data1 - mon_data.data2 == drv_data.data_out) begin 
					// 	if (col_2_mul(mon_data.data1 , mon_data.data2) == drv_data.data_out) begin
					// 		`uvm_info(get_type_name(), "col 1 Data matched ", UVM_NONE)
					// 	end else begin 
					// 		`uvm_error(get_type_name(), "col 1 DATA not mached ")
					// 	end
					// end
				// end 			
			// end
			count++;
		end
	endtask

	virtual function int col_1_mul(bit [3:0] data1, bit [3:0] data2);
		return data1 * data2;
	endfunction

	virtual function int col_2_mul(bit [3:0] data1, bit [3:0] data2);
		return data1 * data2;
	endfunction

	
	function void write_A(seq_item itm_h);
		mon_to_sb.push_back(itm_h);
		`uvm_info(get_type_name(), "Data received from Monitor", UVM_NONE)
		-> mon_trigger;
	endfunction

	
	function void write_B(seq_item itm_h);
		drv_to_sb.push_back(itm_h);
		`uvm_info(get_type_name(), "Data received from Driver", UVM_NONE)
		-> drv_trigger;
	endfunction

function void report_phase(uvm_phase phase);
	super.report_phase(phase);
	`uvm_info(get_type_name(),$sformatf("total number of Transactions from scoreboard : %0d",count), UVM_NONE)
endfunction : report_phase 


endclass

`endif
