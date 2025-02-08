class user_config extends uvm_sequence_item ;

//-------------------------------------------------------------------------------
// Items
//-------------------------------------------------------------------------------

  /**** Discribe them in this feald ****/
  uvm_active_passive_enum ape_h;

//-------------------------------------------------------------------------------
// Factory register
//-------------------------------------------------------------------------------

  // `uvm_object_utils(user_config)
  `uvm_object_utils_begin(user_config)
		`uvm_field_enum (uvm_active_passive_enum, ape_h , UVM_ALL_ON)
  `uvm_object_utils_end

//-------------------------------------------------------------------------------
// Functions and Tasks
//-------------------------------------------------------------------------------

  // Constructor
  function new(string name = "user_config");
    super.new(name);
    `uvm_info("", "config class", UVM_HIGH)
  endfunction

endclass