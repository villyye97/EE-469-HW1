module decoder2_4(in,out,enable);
	input logic  [1:0] in;
	input logic enable;
	output logic [3:0] out; 
	
	
	logic a, b, ia, ib;
	
	assign a = in[1];
	assign b = in[0];
	not n1 (ia, a);
	not n2 (ib, b);
	and a1 (out[0],ia,ib,enable);
	and a2 (out[1],ia,b,enable);
	and a3 (out[2],a,ib,enable);
	and a4 (out[3], a,b,enable);
	
endmodule 

module decoder3_8 (in, out, enable);
	input logic [2:0] in;
	input logic enable;
	output logic [7:0] out;
	logic c,ic,temp1,temp2;
	assign c = in[2];
	
	not n1(ic,c);
	and a1(temp1,enable,c);
	and a2(temp2,enable,ic);
	decoder2_4 d1(in[1:0],out[7:4],temp1);
	decoder2_4 d2(in[1:0],out[3:0],temp2);
	
endmodule

module decoder5_32(in,out, enable);
	input logic [4:0]in;
	input logic enable;
	output logic [31:0] out;
	
	logic [3:0]d;
	decoder2_4 d1(in[4:3],d,enable);
	decoder3_8 d2(in[2:0],out[7:0],d[0]);	
	decoder3_8 d3(in[2:0],out[15:8],d[1]);
	decoder3_8 d4(in[2:0],out[23:16],d[2]);
	decoder3_8 d5(in[2:0],out[31:24],d[3]);
	
endmodule
	
	
	
	
	