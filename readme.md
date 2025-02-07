
# Expected directory structure
.  
├── Design  
│ &emsp;&emsp;└── matrix_multiplier  
│&emsp;&emsp;&emsp;&emsp;       ├── unit_adder  
│&emsp;&emsp;&emsp;&emsp;       │&emsp;&emsp;  └── unit_adder.v  
│&emsp;&emsp;&emsp;&emsp;       ├── unit_multiplier  
│&emsp;&emsp;&emsp;&emsp;       │&emsp;&emsp;  └── unit_multiplier.sv  
│&emsp;&emsp;&emsp;&emsp;       ├── IO_block  
│&emsp;&emsp;&emsp;&emsp;       │&emsp;&emsp;  └── IO_block.v  
│&emsp;&emsp;&emsp;&emsp;       │&emsp;&emsp;  └── Python_script.py  
│&emsp;&emsp;&emsp;&emsp;       ├── PE_block  
│&emsp;&emsp;&emsp;&emsp;       │&emsp;&emsp;   ├── FPU_normalizer  
│&emsp;&emsp;&emsp;&emsp;       │&emsp;&emsp;   │&emsp;&emsp;  └── FPU_normalizer.sv  
│&emsp;&emsp;&emsp;&emsp;       │&emsp;&emsp;   ├── Systolic_array_equ_unit  
│&emsp;&emsp;&emsp;&emsp;       │&emsp;&emsp;   │&emsp;&emsp;   └── Systolic_array_equ_unit.sv  
│&emsp;&emsp;&emsp;&emsp;       │&emsp;&emsp;   └── PE_block.sv  
│&emsp;&emsp;&emsp;&emsp;       └── matrix_multiplier.sv  
├── Sim  
│&emsp;&emsp;   ├── unit_verification  
│&emsp;&emsp;   │&emsp;&emsp;  └── functional_verificaion  
│&emsp;&emsp;&emsp;&emsp;&emsp;&emsp;&emsp; └── tb_unit_adder.v  
│&emsp;&emsp;   │&emsp;&emsp;   ├── UVM  
│&emsp;&emsp;   │&emsp;&emsp;   └── SV_tb  
│&emsp;&emsp;   └── top_verification  
│&emsp;&emsp;&emsp;&emsp;       ├── UVM  
│&emsp;&emsp;&emsp;&emsp;       └── SV_tb  
└── Synth  

# Actual directory structure

Directory structure:  
└── matrix_mul_trial_test/  
&emsp;&emsp;    ├── Design/  
&emsp;&emsp;    │&emsp;&emsp;   └── matrix_multiplier/  
&emsp;&emsp;    │&emsp;&emsp;&emsp;&emsp;       ├── IO_block/  
&emsp;&emsp;    │&emsp;&emsp;&emsp;&emsp;       │&emsp;&emsp;   ├── IO_block.v.v  
&emsp;&emsp;    │&emsp;&emsp;&emsp;&emsp;       │&emsp;&emsp;   └── py_script.py  
&emsp;&emsp;    │&emsp;&emsp;&emsp;&emsp;       ├── PE/  
&emsp;&emsp;    │&emsp;&emsp;&emsp;&emsp;       │&emsp;&emsp;   ├── PE.sv  
&emsp;&emsp;    │&emsp;&emsp;&emsp;&emsp;       │&emsp;&emsp;   ├── PE_int.sv  
&emsp;&emsp;    │&emsp;&emsp;&emsp;&emsp;       │&emsp;&emsp;   ├── pe.v  
&emsp;&emsp;    │&emsp;&emsp;&emsp;&emsp;       │&emsp;&emsp;   └── sys_arry.v  
&emsp;&emsp;    │&emsp;&emsp;&emsp;&emsp;       ├── Vedic_multiplier_32x32/  
&emsp;&emsp;    │&emsp;&emsp;&emsp;&emsp;       │&emsp;&emsp;   ├── run_sim.ps1  
&emsp;&emsp;    │&emsp;&emsp;&emsp;&emsp;       │&emsp;&emsp;   ├── sim_1/  
&emsp;&emsp;    │&emsp;&emsp;&emsp;&emsp;       │&emsp;&emsp;   │&emsp;&emsp;   └── new/  
&emsp;&emsp;    │&emsp;&emsp;&emsp;&emsp;       │&emsp;&emsp;   │&emsp;&emsp;&emsp;&emsp;       ├── tb_bd.v  
&emsp;&emsp;    │&emsp;&emsp;&emsp;&emsp;       │&emsp;&emsp;   │&emsp;&emsp;&emsp;&emsp;       ├── tb_halfAdder.v  
&emsp;&emsp;    │&emsp;&emsp;&emsp;&emsp;       │&emsp;&emsp;   │&emsp;&emsp;&emsp;&emsp;       ├── tb_half_adder_axi_master_slave.v  
&emsp;&emsp;    │&emsp;&emsp;&emsp;&emsp;       │&emsp;&emsp;   │&emsp;&emsp;&emsp;&emsp;       ├── tb_vedic_2x2.v  
&emsp;&emsp;    │&emsp;&emsp;&emsp;&emsp;       │&emsp;&emsp;   │&emsp;&emsp;&emsp;&emsp;       └── test32x32.v  
&emsp;&emsp;    │&emsp;&emsp;&emsp;&emsp;       │&emsp;&emsp;   ├── sources_1/  
&emsp;&emsp;    │&emsp;&emsp;&emsp;&emsp;       │&emsp;&emsp;   │&emsp;&emsp;   └── new/  
&emsp;&emsp;    │&emsp;&emsp;&emsp;&emsp;       │&emsp;&emsp;   │&emsp;&emsp;&emsp;&emsp;       ├── adder10.v  
&emsp;&emsp;    │&emsp;&emsp;&emsp;&emsp;       │&emsp;&emsp;   │&emsp;&emsp;&emsp;&emsp;       ├── adder16.v  
&emsp;&emsp;    │&emsp;&emsp;&emsp;&emsp;       │&emsp;&emsp;   │&emsp;&emsp;&emsp;&emsp;       ├── adder18.v  
&emsp;&emsp;    │&emsp;&emsp;&emsp;&emsp;       │&emsp;&emsp;   │&emsp;&emsp;&emsp;&emsp;       ├── adder32.v  
&emsp;&emsp;    │&emsp;&emsp;&emsp;&emsp;       │&emsp;&emsp;   │&emsp;&emsp;&emsp;&emsp;       ├── adder34.v  
&emsp;&emsp;    │&emsp;&emsp;&emsp;&emsp;       │&emsp;&emsp;   │&emsp;&emsp;&emsp;&emsp;       ├── adder4.v  
&emsp;&emsp;    │&emsp;&emsp;&emsp;&emsp;       │&emsp;&emsp;   │&emsp;&emsp;&emsp;&emsp;       ├── adder6.v  
&emsp;&emsp;    │&emsp;&emsp;&emsp;&emsp;       │&emsp;&emsp;   │&emsp;&emsp;&emsp;&emsp;       ├── adder8.v  
&emsp;&emsp;    │&emsp;&emsp;&emsp;&emsp;       │&emsp;&emsp;   │&emsp;&emsp;&emsp;&emsp;       ├── buffer.v  
&emsp;&emsp;    │&emsp;&emsp;&emsp;&emsp;       │&emsp;&emsp;   │&emsp;&emsp;&emsp;&emsp;       ├── halfAdder.v  
&emsp;&emsp;    │&emsp;&emsp;&emsp;&emsp;       │&emsp;&emsp;   │&emsp;&emsp;&emsp;&emsp;       ├── half_adder_axi_master_slave.v  
&emsp;&emsp;    │&emsp;&emsp;&emsp;&emsp;       │&emsp;&emsp;   │&emsp;&emsp;&emsp;&emsp;       ├── vedic_16x16.v  
&emsp;&emsp;    │&emsp;&emsp;&emsp;&emsp;       │&emsp;&emsp;   │&emsp;&emsp;&emsp;&emsp;       ├── vedic_2x2.v  
&emsp;&emsp;    │&emsp;&emsp;&emsp;&emsp;       │&emsp;&emsp;   │&emsp;&emsp;&emsp;&emsp;       ├── vedic_32x32.v  
&emsp;&emsp;    │&emsp;&emsp;&emsp;&emsp;       │&emsp;&emsp;   │&emsp;&emsp;&emsp;&emsp;       ├── vedic_4x4.v  
&emsp;&emsp;    │&emsp;&emsp;&emsp;&emsp;       │&emsp;&emsp;   │&emsp;&emsp;&emsp;&emsp;       └── vedic_8x8.v  
&emsp;&emsp;    │&emsp;&emsp;&emsp;&emsp;       │&emsp;&emsp;   └── ss/  
&emsp;&emsp;    │&emsp;&emsp;&emsp;&emsp;       └── unit_adder/  
&emsp;&emsp;    │&emsp;&emsp;&emsp;&emsp;           ├── unit_adder.v.v  
&emsp;&emsp;    │&emsp;&emsp;&emsp;&emsp;           └── updated_halfAdder_axis/  
&emsp;&emsp;    │&emsp;&emsp;&emsp;&emsp;&emsp;&emsp;               ├── halfAdder.v  
&emsp;&emsp;    │&emsp;&emsp;&emsp;&emsp;&emsp;&emsp;               └── tb_halfAdder.v  
&emsp;&emsp;    ├── Sim/  
&emsp;&emsp;    │&emsp;&emsp;   └── unit_verification/  
&emsp;&emsp;    │&emsp;&emsp;&emsp;&emsp;       └── functional_verification/  
&emsp;&emsp;    │&emsp;&emsp;&emsp;&emsp;&emsp;&emsp;           ├── sys_tb.v  
&emsp;&emsp;    │&emsp;&emsp;&emsp;&emsp;&emsp;&emsp;           ├── sys_tb_test_case.v  
&emsp;&emsp;    │&emsp;&emsp;&emsp;&emsp;&emsp;&emsp;           ├── tb_pe.v  
&emsp;&emsp;    │&emsp;&emsp;&emsp;&emsp;&emsp;&emsp;           └── tb_unit_adder.sv  
&emsp;&emsp;    └── scripts/  
&emsp;&emsp;    │&emsp;&emsp;    ├── run_systolic2x2_tb.ps1  
&emsp;&emsp;    │&emsp;&emsp;    └── run_vedic32x32_tb.ps1  
&emsp;&emsp;    └── readme.md  
