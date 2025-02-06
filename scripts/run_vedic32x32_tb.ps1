vlog -work work .\Design\matrix_multiplier\Vedic_multiplier_32x32\sources_1\new\buffer.v .\Design\matrix_multiplier\Vedic_multiplier_32x32\sources_1\new\halfAdder.v .\Design\matrix_multiplier\Vedic_multiplier_32x32\sources_1\new\adder4.v .\Design\matrix_multiplier\Vedic_multiplier_32x32\sources_1\new\adder6.v .\Design\matrix_multiplier\Vedic_multiplier_32x32\sources_1\new\adder8.v .\Design\matrix_multiplier\Vedic_multiplier_32x32\sources_1\new\adder10.v .\Design\matrix_multiplier\Vedic_multiplier_32x32\sources_1\new\adder16.v .\Design\matrix_multiplier\Vedic_multiplier_32x32\sources_1\new\adder18.v .\Design\matrix_multiplier\Vedic_multiplier_32x32\sources_1\new\adder32.v .\Design\matrix_multiplier\Vedic_multiplier_32x32\sources_1\new\adder34.v .\Design\matrix_multiplier\Vedic_multiplier_32x32\sources_1\new\vedic_2x2.v .\Design\matrix_multiplier\Vedic_multiplier_32x32\sources_1\new\vedic_4x4.v .\Design\matrix_multiplier\Vedic_multiplier_32x32\sources_1\new\vedic_8x8.v .\Design\matrix_multiplier\Vedic_multiplier_32x32\sources_1\new\vedic_16x16.v .\Design\matrix_multiplier\Vedic_multiplier_32x32\sources_1\new\vedic_32x32.v .\Design\matrix_multiplier\Vedic_multiplier_32x32\sim_1\new\test32x32.v

vsim -voptargs=+acc -sv_seed 432  work.test32x32 -do "add wave -position insertpoint sim:/test32x32/*;run -all"