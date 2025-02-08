class seq_item_original extends uvm_sequence_item ;

    parameter DATA_TYPE = 3'b011;
    
    rand logic [31:0] a11;
    rand logic [31:0] a12;
    rand logic [31:0] a21;
    rand logic [31:0] a22;
    
    rand logic [31:0] b11;
    rand logic [31:0] b12;
    rand logic [31:0] b21;
    rand logic [31:0] b22;

    logic        load_in;    

    logic [31:0] row_in_row0; 
    logic [31:0] row_in_row1; 
    logic [31:0] col_in_col0; 
    logic [31:0] col_in_col1; 

    logic [63:0] result_row00; 
    logic [63:0] result_row01; 
    logic [63:0] result_row10; 
    logic [63:0] result_row11;    
    logic        carry_00; 
    logic        carry_01; 
    logic        carry_10; 
    logic        carry_11;    
    logic        done;  

    logic [31:0] arr1 [0:3]= [a12 , a11 , 0   , 0];
    logic [31:0] arr2 [0:3]= [0   , a22 , a21 , 0];
    logic [31:0] arr3 [0:3]= [b21 , a11 , 0   , 0];
    logic [31:0] arr4 [0:3]= [0   , b22 , b12 , 0];


    task assign_val();
         #100;
        load_in = 1;
        row_in_row0 = arr1[0]; 
        row_in_row1 = arr2[0]; 

        col_in_col0 = arr3[0]; 
        col_in_col1 = arr4[0]; 
 
        #10 load_in = 0;

        // Wait for done signal
        // wait(done == 1);
        #200;

        // 2nd set of data
        load_in = 1;
        row_in_row0 = arr1[1]; 
        row_in_row1 = arr2[1]; 

        col_in_col0 = arr3[1]; 
        col_in_col1 = arr4[1]; 

        #10 load_in = 0;

        // // Wait for done signal
        // wait(done == 1);

        #200;
        load_in = 1;
        row_in_row0 = arr1[2]; 
        row_in_row1 = arr2[2]; 

        col_in_col0 = arr3[2]; 
        col_in_col1 = arr4[2]; 

        #10 load_in = 0;

        //Wait for done signal
        // wait(done == 1);

        #200;
        load_in = 1;
        row_in_row0 = arr1[3]; 
        row_in_row1 = arr2[3]; 

        col_in_col0 = arr3[3]; 
        col_in_col1 = arr4[3];
    endtask : assign_val


    `uvm_object_utils_begin(seq_item)
    	`uvm_field_int(load_in, UVM_ALL_ON)
    	`uvm_field_int(row_in_row0, UVM_ALL_ON)
    	`uvm_field_int(row_in_row1, UVM_ALL_ON)
    	`uvm_field_int(col_in_col0, UVM_ALL_ON)
    	`uvm_field_int(col_in_col1, UVM_ALL_ON)
        `uvm_field_int(result_row00, UVM_ALL_ON)
        `uvm_field_int(result_row01, UVM_ALL_ON)
        `uvm_field_int(result_row10, UVM_ALL_ON)
        `uvm_field_int(result_row11, UVM_ALL_ON)
        `uvm_field_int(carry_00, UVM_ALL_ON)
        `uvm_field_int(carry_01, UVM_ALL_ON)
        `uvm_field_int(carry_10, UVM_ALL_ON)
        `uvm_field_int(carry_11, UVM_ALL_ON)
        `uvm_field_int(done, UVM_ALL_ON)
    `uvm_object_utils_end

  function new(string name = "seq_item");
    super.new(name);
    `uvm_info(get_type_name(), "SEQUENCE_ITEM_CALLED", UVM_NONE)
  endfunction

endclass