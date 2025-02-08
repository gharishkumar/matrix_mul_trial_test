class master_sequence extends uvm_sequence #(seq_item);

	seqence add_seq_h;

	`uvm_object_utils_begin(master_sequence)
	`uvm_object_utils_end

	`uvm_declare_p_sequencer (virtual_sequencer)

	function new(string name = "master_sequence");
		super.new(name);
		add_seq_h = seqence::type_id::create("add_seq_h");
	endfunction

	task body();
		add_seq_h.start(p_sequencer.add_seqr);
        `uvm_info("", "SEQUENCE 1", UVM_NONE)
	endtask : body


endclass