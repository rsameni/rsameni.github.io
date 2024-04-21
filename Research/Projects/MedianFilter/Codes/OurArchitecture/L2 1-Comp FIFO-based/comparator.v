`timescale 1 ns / 1 ps	  
`include "macro.vh"

module comparator(data_in1, data_in2,L_R);
	
	input [`DATA_LENGTH-1:0] data_in1, data_in2;
	output L_R;
	assign L_R = ( data_in2 <= data_in1) ? 1'b1: 1'b0;
endmodule

	