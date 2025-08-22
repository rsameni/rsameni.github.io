#Eesa Nikahd 28/5/1389
#script program to create a txt file for my topModule
import math
W = input ("enter size of  window :")
dataLen = input ("enter data length (per bit):")

macrofile = open("macro.vh","w")
macrofile.write("`ifndef _my_include_vh_\n`define _my_include_vh_\n\n")
macrofile.write("`define W %d\n`define DATA_LENGTH  %d"% (W ,dataLen))
macrofile.write("\n`endif\n")
macrofile.close()

fifo = open ("FIFO.v" ,"w")
fifo.write("`timescale 1ns / 1ps\n`include \"macro.vh\"\n///////////////////////\n")
fifo.write("module FIFO( in , out , clk ,reset , flag);\n\n")
fifo.write("input  [`DATA_LENGTH-1:0] in;\noutput [`DATA_LENGTH-1:0] out;\ninput  clk ,reset ,flag;\n")			
fifo.write("reg	[`DATA_LENGTH-1:0] fifo [0:`W-1];\n\n")
fifo.write("assign  out =  fifo[`W-1] ;\n")
fifo.write("always @(posedge clk or  posedge reset)\nbegin\n\tif(reset)\n\tbegin")
for i in range(W):
    fifo.write("\n\t\tfifo[%d] <= 0;"%i)
fifo.write("\n\tend\n\telse\n\tbegin\n\t\tif(flag == 0)\n\t\tbegin\n\t\t\tfifo[0] <= in ;")
for i in range(1,W):
    fifo.write("\n\t\t\tfifo[%d] <= fifo[%d];" %(i,i-1))
fifo.write("\n\t\tend\n\tend\nend\n\nendmodule")

fifo.close()

myfile = open ("top.v" ,"w")
myfile.write("`timescale 1ns / 1ps\n`include \"macro.vh\"\n///////////////////////\n")
myfile.write("module top ( clk ,reset ,X ,median );\n\n")
myfile.write("output [`DATA_LENGTH-1:0] median ;\ninput [`DATA_LENGTH-1:0] X ;\ninput clk ,reset ;\n")

#myfile.write("reg  [`LOG_WMAX-1:0] first ;\n")
myfile.write("reg  flag ;\n")
myfile.write("wire  [`DATA_LENGTH-1:0] oldData ;")
myfile.write("\nwire 	[`DATA_LENGTH-1:0] dataOut1")
for i in range(2,W+1):
    myfile.write(" ,dataOut%d" % i)
myfile.write(";")


myfile.write("\nwire 	L1")
for i in range(2,W+1):
    myfile.write(" ,L%d" % i)
myfile.write(";")

myfile.write("\nwire 	 R1")
for i in range(2,W+1):
    myfile.write(" ,R%d" %i)
myfile.write(";\n")

if (W%2 ==0):
    myfile.write("\nassign median = (dataOut%d + dataOut%d)>>1 ;\n\n" %(int(math.ceil(W/2.0)),int(math.ceil(W/2.0))+1))
else:
    myfile.write("\nassign median = dataOut%d ;\n\n" %int(math.ceil(W/2.0)) )
    
#myfile.write("medianCell1st  m1(.X(X) ,.W(W),.reset(reset) ,.clk(clk) ,.dataR_in(dataOut2) ,.Rr(R2) ,.ageR_in(ageOut2) ,.R_out(R1) ,.L_out(L1) ,.data_out(dataOut1),.age_out(ageOut1));\n\n")
myfile.write("always @(posedge clk or  posedge reset)\nbegin\n\tif(reset)\n\t\tflag <= 0;\n\telse\n\t\tflag <= ~flag ;\nend\n\n")


myfile.write("FIFO  myfifo(.clk(clk) ,.reset(reset) ,.in(X) ,.out(oldData) ,.flag(flag));\n")


myfile.write("medianFilterCell  m1(.X(X) ,.oldData(oldData) ,.flag(flag),.reset(reset) ,.clk(clk) ,.R_in(0) ,.L_in(0) ,.Rr(R2) ,.dataR_in(dataOut2) ,.dataL_in(0) \n\t ,.R_out(R1) ,.L_out(L1) ,.data_out(dataOut1)  );\n" )
for i in range(2,W):
    myfile.write("medianFilterCell  m%d(.X(X) ,.oldData(oldData)  ,.flag(flag),.reset(reset) ,.clk(clk) ,.R_in(R%d) ,.L_in(L%d) ,.Rr(R%d) ,.dataR_in(dataOut%d) ,.dataL_in(dataOut%d) \n\t ,.R_out(R%d) ,.L_out(L%d) ,.data_out(dataOut%d)  );\n"%(i,i-1,i-1,i+1,i+1,i-1,i,i,i))
myfile.write("medianFilterCell  m%d(.X(X) ,.oldData(oldData) ,.flag(flag),.reset(reset) ,.clk(clk) ,.R_in(R%d) ,.L_in(L%d) ,.Rr(0) ,.dataR_in(0) ,.dataL_in(dataOut%d) \n\t ,.R_out(R%d) ,.L_out(L%d) ,.data_out(dataOut%d));\n"%(W ,W-1 ,W-1 ,W-1 ,W ,W ,W))

myfile.write("\n\nendmodule")     
                 
myfile.close()                 

