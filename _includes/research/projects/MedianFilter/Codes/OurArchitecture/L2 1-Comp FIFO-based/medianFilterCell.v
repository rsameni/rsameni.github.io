																															 //-----------------------------------------------------------------------------
//
// Title       : medianCell1st
// Design      : median2
// Author      : Eesa Nikahd
// Company     : nik
//
//-----------------------------------------------------------------------------
//
// File        : medianCell.v
// Generated   : Sun Aug 17 23:35:19 2008
// From        : interface description file
// By          : Itf2Vhdl ver. 1.21
//
//-----------------------------------------------------------------------------
//
// Description :
//				inputs and outputs  :
//					"X" is an eleman of input signal
//					"W" indicate size of median window ;for change W you shoud assert reset simultaneous. 
//					"cellNo" indicate number of this Cell
//					"R_in" is a signal that if be set indicate input data is greater  than value of previous Cell , that mean a right shift is require
//					"L_in" is a signal that if be set indicate oldest input is in a one of left Cell ,that mean a left shift is require
//					"Rr" is a signal that if be set indicate input data is greater  than value of next Cell
//					"dataR_in" is data value of right cell  and dataL_in is data value of left cell
//					"ageR_in" is age value of right cell and "ageL_in" is age value of left cell (age Determines when data has been entered)
//					"R_out" is a signal that if be set indicate input data is greater  than value of this Cell
//					"L_out" is a signal that if be set indicate oldest input is in a one of this Cell 
//					"data_out" is value of this cell 
//					"age_out" is age of data value of this cell
//							
//				macros:
//					"DATA_LENGTH" , "LOG_WMAX" and "WMAX" are  macros(global constant) that is defined in "macro.vh" 
//					and you can run "script.py" and create "top.v" and "macro.vh" and set  their values .		
//					"DATA_LENGTH" determine length of each eleman of input signal for example 32 bits
//					"WMAX" is maximum size of median window that you can set it when run "script.py" and henceforth you just set input W less than WMAX.
//					"LOG_WMAX" is logarithm of WMAX that use for  determine number of bits that has needed for counter. 
//-----------------------------------------------------------------------------
`timescale 1 ns / 1 ps	  
`include "macro.vh"


module medianFilterCell(X ,oldData ,flag ,reset ,clk ,R_in ,dataR_in ,dataL_in ,R_out ,data_out);
	
	input [`DATA_LENGTH-1:0]  X,oldData ,dataR_in ,dataL_in ;
	
	
	input 	clk ,reset ,flag;
	input	R_in ;
	
	output 	[`DATA_LENGTH -1:0] data_out;
	output 	R_out ;	  
	
	
	wire [`DATA_LENGTH-1:0] X_oldData;	 	
	wire L_R;
		
	reg   [`DATA_LENGTH-1:0] dataReg;
	
	assign   R_out = L_R;				  
	assign 	data_out = dataReg ;	 
	
	mux2_1 mux(.in1(oldData), .in2(X), .out(X_oldData), .select(flag));
	comparator comp(.data_in1(X_oldData), .data_in2(dataReg), .L_R(L_R));	  
	always @(posedge clk or posedge reset)
	begin
		if(reset)
		begin
			dataReg <= 0;
		end
		else
		begin
				if (flag == 0)
				begin			
						dataReg <= (L_R)? dataR_in:dataReg;							
				end						
				else
				begin		 					
					case ({L_R,R_in})						
						2'b10:
						begin
							dataReg <=X;												
						end
						
						2'b11:
						begin 	
							dataReg <= dataL_in ;							
						end
						2'b00:
						begin
							dataReg <= dataReg;
						end	
						2'b01:
						begin
							dataReg <= dataReg;
						end						
					endcase							
				end			
		end
	end

endmodule		
							
			
			
			
			
			
			
				
							
						
					
					