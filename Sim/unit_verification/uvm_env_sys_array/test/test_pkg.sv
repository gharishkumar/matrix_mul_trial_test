`include "env_pkg.sv"

package test_pkg;

	import uvm_pkg::*;
	import env_pkg::*;
	import agent_pkg::*;

	typedef class integrated_test;
	typedef class master_sequence;

	`include "master_sequence.sv"
	`include "integrated_test.sv"

endpackage