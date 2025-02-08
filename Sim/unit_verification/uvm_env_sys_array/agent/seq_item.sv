class seq_item extends uvm_sequence_item;

    parameter DATA_TYPE = 3'b011;

    randc logic [31:0] a11;
    randc logic [31:0] a12;
    randc logic [31:0] a21;
    randc logic [31:0] a22;

    randc logic [31:0] b11;
    randc logic [31:0] b12;
    randc logic [31:0] b21;
    randc logic [31:0] b22;

    randc bit        load_in;    
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

    logic [31:0] arr1 [0:3];
    logic [31:0] arr2 [0:3];
    logic [31:0] arr3 [0:3];
    logic [31:0] arr4 [0:3];

    // Constraints for randomization
    // constraint a_constraints {
    //     a11 inside {[0:100]};
    //     a12 inside {[0:100]};
    //     a21 inside {[0:100]};
    //     a22 inside {[0:100]};
    // }

    // constraint b_constraints {
    //     b11 inside {[0:100]};
    //     b12 inside {[0:100]};
    //     b21 inside {[0:100]};
    //     b22 inside {[0:100]};
    // }

    // Task to assign values using a loop

    function void arr_values();
        arr1 = '{a12 , a11 , 0   , 0};
        arr2 = '{0   , a22 , a21 , 0};
        arr3 = '{b21 , a11 , 0   , 0};
        arr4 = '{0   , b22 , b12 , 0};
    endfunction : arr_values

    task assign_val();
        arr_values();
        for (int i = 0; i < 4; i++) begin
            // #100;
            // load_in = 1;

            // Assign row and column inputs
            row_in_row0 = arr1[i]; 
            row_in_row1 = arr2[i]; 
            col_in_col0 = arr3[i]; 
            col_in_col1 = arr4[i]; 

            $display("row_in_row0 = %0d",row_in_row0);

            // #10 load_in = 0;


            // #200; // Delay between transactions
        end
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

    // Constructor
    function new(string name = "seq_item");
        super.new(name);
        `uvm_info(get_type_name(), "SEQUENCE_ITEM_CALLED", UVM_NONE)

    endfunction

    function void display();
        $display("arr1 = %0p , arr2 = %0p , arr3 = %0p , arr4 = %0p",arr1,arr2,arr3,arr4);
    endfunction

endclass