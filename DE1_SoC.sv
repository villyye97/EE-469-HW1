module DE1_SoC (clk, HEX0, HEX1, HEX2, HEX3, HEX4, HEX5, KEY, LEDR, SW);
input logic clk; 
output logic [6:0] HEX0, HEX1, HEX2, HEX3, HEX4, HEX5;
output logic [9:0] LEDR;
input logic [3:0] KEY; 
input logic [9:0] SW;


//
//logic [31:0] clk1;
//parameter whichClock = 25;
//clock_divider cdiv (clk, clk1);

gateCounterMachine gate(LEDR[3:0], clk, SW[9]);


endmodule
// D flip-flop act as a memory block
module DFlipFlop(q, qBar, D, clk, rst);
	
	input D, clk, rst;
	output q, qBar;
	reg q;
	not n1 (qBar, q);
	always@ (negedge rst or posedge clk)
		begin
			if(!rst)
				q = 0;
			else
				q = D;
		end

endmodule

// main counter instantantiate 4 instant of DFF and connect them together
// to create a ripple down counter
module gateCounterMachine (output [3:0] out, input clk, reset);

	wire a, b, c, d;
//	logic e, f, g, h, i, j;
//	
//	and myAnd(e, a, b, c, d);
//	
//	or myOr1 (g, e, a);
//	or myOr2 (h, e, b);
//	or myOr3 (i, e, c);
//	or myOr4 (j, e, d);
	
	DFlipFlop d1 (.q(out [0]), .qBar(a), .D(a), .clk(clk), .rst(reset));
	DFlipFlop d2 (.q(out [1]), .qBar(b), .D(b), .clk(a), .rst(reset));	
	DFlipFlop d3 (.q(out [2]), .qBar(c), .D(c), .clk(b), .rst(reset));
	DFlipFlop d4 (.q(out [3]), .qBar(d), .D(d), .clk(c), .rst(reset));


endmodule


module DE1_SoC_testbench;
	logic  [6:0]    HEX0, HEX1, HEX2, HEX3, HEX4, HEX5;
	logic  [9:0]    LEDR;
	logic  [3:0]    KEY;
	logic  [9:0] 	SW;
	logic  clk;

	DE1_SoC dut (clk, HEX0, HEX1, HEX2, HEX3, HEX4, HEX5, KEY, LEDR, SW);
	
	parameter CLOCK_PERIOD = 100;   
		initial begin    
			clk <= 0;    
			forever #(CLOCK_PERIOD/2) clk <= ~clk;   
		end  
	
	initial begin 
		SW[9] <= 0; @(posedge clk);
		@(posedge clk);
		@(posedge clk);
		@(posedge clk);
		@(posedge clk);
		@(posedge clk);
		@(posedge clk);
		SW[9] <= 1; @(posedge clk);
		SW[9] <= 0; @(posedge clk);
		@(posedge clk);
		@(posedge clk);
		@(posedge clk);
		@(posedge clk);
		@(posedge clk);
		@(posedge clk);
		@(posedge clk);
		@(posedge clk);
		@(posedge clk);
		@(posedge clk);
		@(posedge clk);
		@(posedge clk);
		@(posedge clk);
		@(posedge clk);
		@(posedge clk);
		@(posedge clk);
		
		
		

	
	$stop(); 
	end
	
endmodule 
