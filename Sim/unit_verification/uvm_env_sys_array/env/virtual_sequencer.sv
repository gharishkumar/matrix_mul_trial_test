class virtual_sequencer extends uvm_sequencer #(seq_item);

	`uvm_component_utils_begin(virtual_sequencer)
	`uvm_component_utils_end

	sequencer add_seqr;
	// sequencer_rst rst_seqr;


	function new(string name = "virtual_sequencer", uvm_component parent);
		super.new(name, parent);
	endfunction

endclass