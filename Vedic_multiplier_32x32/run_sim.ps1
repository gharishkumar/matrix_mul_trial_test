vlog -work work sources_1\new\halfAdder.v sources_1\new\adder4.v sources_1\new\adder6.v sources_1\new\adder8.v sources_1\new\adder10.v sources_1\new\adder16.v sources_1\new\adder18.v sources_1\new\adder32.v sources_1\new\adder34.v sources_1\new\vedic_2x2.v sources_1\new\vedic_4x4.v sources_1\new\vedic_8x8.v sources_1\new\vedic_16x16.v sources_1\new\vedic_32x32.v .\sim_1\new\test32x32.v

vsim -c -voptargs=+acc -sv_seed 432  work.test32x32 -do "add wave -position insertpoint sim:/test32x32/*;run -all"