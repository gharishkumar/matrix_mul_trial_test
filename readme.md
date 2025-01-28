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
