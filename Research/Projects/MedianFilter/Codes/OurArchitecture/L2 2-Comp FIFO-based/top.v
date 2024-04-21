`timescale 1ns / 1ps
`include "macro.vh"
///////////////////////
module top ( clk ,reset ,X ,median );

output [`DATA_LENGTH-1:0] median ;
input [`DATA_LENGTH-1:0] X ;
input clk ,reset ;
reg  flag ;
wire  [`DATA_LENGTH-1:0] oldData ;
wire 	[`DATA_LENGTH-1:0] dataOut1 ,dataOut2 ,dataOut3 ,dataOut4 ,dataOut5 ,dataOut6 ,dataOut7 ,dataOut8 ,dataOut9 ,dataOut10 ,dataOut11 ,dataOut12 ,dataOut13 ,dataOut14 ,dataOut15 ,dataOut16 ,dataOut17 ,dataOut18 ,dataOut19 ,dataOut20;
wire 	L1 ,L2 ,L3 ,L4 ,L5 ,L6 ,L7 ,L8 ,L9 ,L10 ,L11 ,L12 ,L13 ,L14 ,L15 ,L16 ,L17 ,L18 ,L19 ,L20;
wire 	 R1 ,R2 ,R3 ,R4 ,R5 ,R6 ,R7 ,R8 ,R9 ,R10 ,R11 ,R12 ,R13 ,R14 ,R15 ,R16 ,R17 ,R18 ,R19 ,R20;

assign median = (dataOut10 + dataOut11)>>1 ;

always @(posedge clk or  posedge reset)
begin
	if(reset)
		flag <= 0;
	else
		flag <= ~flag ;
end

FIFO  myfifo(.clk(clk) ,.reset(reset) ,.in(X) ,.out(oldData) ,.flag(flag));
medianFilterCell  m1(.X(X) ,.oldData(oldData) ,.flag(flag),.reset(reset) ,.clk(clk) ,.R_in(0) ,.L_in(0) ,.Rr(R2) ,.dataR_in(dataOut2) ,.dataL_in(0) 
	 ,.R_out(R1) ,.L_out(L1) ,.data_out(dataOut1)  );
medianFilterCell  m2(.X(X) ,.oldData(oldData)  ,.flag(flag),.reset(reset) ,.clk(clk) ,.R_in(R1) ,.L_in(L1) ,.Rr(R3) ,.dataR_in(dataOut3) ,.dataL_in(dataOut1) 
	 ,.R_out(R2) ,.L_out(L2) ,.data_out(dataOut2)  );
medianFilterCell  m3(.X(X) ,.oldData(oldData)  ,.flag(flag),.reset(reset) ,.clk(clk) ,.R_in(R2) ,.L_in(L2) ,.Rr(R4) ,.dataR_in(dataOut4) ,.dataL_in(dataOut2) 
	 ,.R_out(R3) ,.L_out(L3) ,.data_out(dataOut3)  );
medianFilterCell  m4(.X(X) ,.oldData(oldData)  ,.flag(flag),.reset(reset) ,.clk(clk) ,.R_in(R3) ,.L_in(L3) ,.Rr(R5) ,.dataR_in(dataOut5) ,.dataL_in(dataOut3) 
	 ,.R_out(R4) ,.L_out(L4) ,.data_out(dataOut4)  );
medianFilterCell  m5(.X(X) ,.oldData(oldData)  ,.flag(flag),.reset(reset) ,.clk(clk) ,.R_in(R4) ,.L_in(L4) ,.Rr(R6) ,.dataR_in(dataOut6) ,.dataL_in(dataOut4) 
	 ,.R_out(R5) ,.L_out(L5) ,.data_out(dataOut5)  );
medianFilterCell  m6(.X(X) ,.oldData(oldData)  ,.flag(flag),.reset(reset) ,.clk(clk) ,.R_in(R5) ,.L_in(L5) ,.Rr(R7) ,.dataR_in(dataOut7) ,.dataL_in(dataOut5) 
	 ,.R_out(R6) ,.L_out(L6) ,.data_out(dataOut6)  );
medianFilterCell  m7(.X(X) ,.oldData(oldData)  ,.flag(flag),.reset(reset) ,.clk(clk) ,.R_in(R6) ,.L_in(L6) ,.Rr(R8) ,.dataR_in(dataOut8) ,.dataL_in(dataOut6) 
	 ,.R_out(R7) ,.L_out(L7) ,.data_out(dataOut7)  );
medianFilterCell  m8(.X(X) ,.oldData(oldData)  ,.flag(flag),.reset(reset) ,.clk(clk) ,.R_in(R7) ,.L_in(L7) ,.Rr(R9) ,.dataR_in(dataOut9) ,.dataL_in(dataOut7) 
	 ,.R_out(R8) ,.L_out(L8) ,.data_out(dataOut8)  );
medianFilterCell  m9(.X(X) ,.oldData(oldData)  ,.flag(flag),.reset(reset) ,.clk(clk) ,.R_in(R8) ,.L_in(L8) ,.Rr(R10) ,.dataR_in(dataOut10) ,.dataL_in(dataOut8) 
	 ,.R_out(R9) ,.L_out(L9) ,.data_out(dataOut9)  );
medianFilterCell  m10(.X(X) ,.oldData(oldData)  ,.flag(flag),.reset(reset) ,.clk(clk) ,.R_in(R9) ,.L_in(L9) ,.Rr(R11) ,.dataR_in(dataOut11) ,.dataL_in(dataOut9) 
	 ,.R_out(R10) ,.L_out(L10) ,.data_out(dataOut10)  );
medianFilterCell  m11(.X(X) ,.oldData(oldData)  ,.flag(flag),.reset(reset) ,.clk(clk) ,.R_in(R10) ,.L_in(L10) ,.Rr(R12) ,.dataR_in(dataOut12) ,.dataL_in(dataOut10) 
	 ,.R_out(R11) ,.L_out(L11) ,.data_out(dataOut11)  );
medianFilterCell  m12(.X(X) ,.oldData(oldData)  ,.flag(flag),.reset(reset) ,.clk(clk) ,.R_in(R11) ,.L_in(L11) ,.Rr(R13) ,.dataR_in(dataOut13) ,.dataL_in(dataOut11) 
	 ,.R_out(R12) ,.L_out(L12) ,.data_out(dataOut12)  );
medianFilterCell  m13(.X(X) ,.oldData(oldData)  ,.flag(flag),.reset(reset) ,.clk(clk) ,.R_in(R12) ,.L_in(L12) ,.Rr(R14) ,.dataR_in(dataOut14) ,.dataL_in(dataOut12) 
	 ,.R_out(R13) ,.L_out(L13) ,.data_out(dataOut13)  );
medianFilterCell  m14(.X(X) ,.oldData(oldData)  ,.flag(flag),.reset(reset) ,.clk(clk) ,.R_in(R13) ,.L_in(L13) ,.Rr(R15) ,.dataR_in(dataOut15) ,.dataL_in(dataOut13) 
	 ,.R_out(R14) ,.L_out(L14) ,.data_out(dataOut14)  );
medianFilterCell  m15(.X(X) ,.oldData(oldData)  ,.flag(flag),.reset(reset) ,.clk(clk) ,.R_in(R14) ,.L_in(L14) ,.Rr(R16) ,.dataR_in(dataOut16) ,.dataL_in(dataOut14) 
	 ,.R_out(R15) ,.L_out(L15) ,.data_out(dataOut15)  );
medianFilterCell  m16(.X(X) ,.oldData(oldData)  ,.flag(flag),.reset(reset) ,.clk(clk) ,.R_in(R15) ,.L_in(L15) ,.Rr(R17) ,.dataR_in(dataOut17) ,.dataL_in(dataOut15) 
	 ,.R_out(R16) ,.L_out(L16) ,.data_out(dataOut16)  );
medianFilterCell  m17(.X(X) ,.oldData(oldData)  ,.flag(flag),.reset(reset) ,.clk(clk) ,.R_in(R16) ,.L_in(L16) ,.Rr(R18) ,.dataR_in(dataOut18) ,.dataL_in(dataOut16) 
	 ,.R_out(R17) ,.L_out(L17) ,.data_out(dataOut17)  );
medianFilterCell  m18(.X(X) ,.oldData(oldData)  ,.flag(flag),.reset(reset) ,.clk(clk) ,.R_in(R17) ,.L_in(L17) ,.Rr(R19) ,.dataR_in(dataOut19) ,.dataL_in(dataOut17) 
	 ,.R_out(R18) ,.L_out(L18) ,.data_out(dataOut18)  );
medianFilterCell  m19(.X(X) ,.oldData(oldData)  ,.flag(flag),.reset(reset) ,.clk(clk) ,.R_in(R18) ,.L_in(L18) ,.Rr(R20) ,.dataR_in(dataOut20) ,.dataL_in(dataOut18) 
	 ,.R_out(R19) ,.L_out(L19) ,.data_out(dataOut19)  );
medianFilterCell  m20(.X(X) ,.oldData(oldData) ,.flag(flag),.reset(reset) ,.clk(clk) ,.R_in(R19) ,.L_in(L19) ,.Rr(0) ,.dataR_in(0) ,.dataL_in(dataOut19) 
	 ,.R_out(R20) ,.L_out(L20) ,.data_out(dataOut20));


endmodule