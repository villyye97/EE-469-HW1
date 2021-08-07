module regfile(ReadData1, ReadData2,WriteData,ReadRegister1,ReadRegister2, 
	WriteRegister,RegWrite,clk);
	input logic [4:0] ReadRegister1, ReadRegister2,WriteRegister;
	input logic RegWrite;
	input logic clk;
	input logic [63:0]WriteData;
	output logic [63:0]ReadData1, ReadData2;
	
	logic [63:0] registers [31:0];
	logic [31:0] address;
	
	decoder5_32 d1(WriteRegister,address,RegWrite);
	
	genvar i;
		generate 
			for(i = 0; i < 31; i++) begin: eachreg
				REG R(WriteData,registers[i],clk,address[i]);
			end
		endgenerate
		
	assign registers[31] = 64'b0;
	
	mux32x64_64 mux1(registers,ReadData1, ReadRegister1);
	mux32x64_64 mux2(registers,ReadData2, ReadRegister2);
	
endmodule
	
	
	
	
	
	
	
	module REG #(parameter WIDTH=64)(in, out , clk, enable);
	input logic [WIDTH-1:0] in;
	input logic clk;
	input logic enable;
	output logic [WIDTH-1:0] out;

	logic [WIDTH-1:0] data;
	
	genvar i;
	
	generate
		for(i=0; i < WIDTH; i++) begin: eachDff
		   mux2_1 sel({in[i], out[i]},data[i] ,enable);
			D_FF dffs(out[i], data[i], 1'b0, clk);
		end
	endgenerate
	
endmodule
	

