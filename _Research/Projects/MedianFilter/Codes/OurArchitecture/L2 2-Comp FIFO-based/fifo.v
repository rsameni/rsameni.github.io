`timescale 1ns / 1ps
`include "macro.vh"
///////////////////////
module FIFO( in , out , clk ,reset , flag);

input  [`DATA_LENGTH-1:0] in;
output [`DATA_LENGTH-1:0] out;
input  clk ,reset ,flag;
reg	[`DATA_LENGTH-1:0] fifo [0:`W-1];

assign  out =  fifo[`W-1] ;
always @(posedge clk or  posedge reset)
begin
	if(reset)
	begin
		fifo[0] <= 0;
		fifo[1] <= 0;
		fifo[2] <= 0;
		fifo[3] <= 0;
		fifo[4] <= 0;
		fifo[5] <= 0;
		fifo[6] <= 0;
		fifo[7] <= 0;
		fifo[8] <= 0;
		fifo[9] <= 0;
		fifo[10] <= 0;
		fifo[11] <= 0;
		fifo[12] <= 0;
		fifo[13] <= 0;
		fifo[14] <= 0;
		fifo[15] <= 0;
		fifo[16] <= 0;
		fifo[17] <= 0;
		fifo[18] <= 0;
		fifo[19] <= 0;
	end
	else
	begin
		if(flag == 0)
		begin
			fifo[0] <= in ;
			fifo[1] <= fifo[0];
			fifo[2] <= fifo[1];
			fifo[3] <= fifo[2];
			fifo[4] <= fifo[3];
			fifo[5] <= fifo[4];
			fifo[6] <= fifo[5];
			fifo[7] <= fifo[6];
			fifo[8] <= fifo[7];
			fifo[9] <= fifo[8];
			fifo[10] <= fifo[9];
			fifo[11] <= fifo[10];
			fifo[12] <= fifo[11];
			fifo[13] <= fifo[12];
			fifo[14] <= fifo[13];
			fifo[15] <= fifo[14];
			fifo[16] <= fifo[15];
			fifo[17] <= fifo[16];
			fifo[18] <= fifo[17];
			fifo[19] <= fifo[18];
		end
	end
end

endmodule