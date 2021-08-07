module wind_direction (clk, reset, wind, out);
input  [1:0] wind;
input        reset, clk;
output [2:0] out;
logic  [2:0] curr, next;

assign out = next;

always @(*) begin 
if (wind == 0) begin
case(curr)
4: next = 3'b101;
1: next = 3'b010;
5: next = 3'b010;
2: next = 3'b101;
default: next = 3'bxxx;
endcase
end else if (wind == 1) begin
case(curr)
1: next = 3'b010;
2: next = 3'b100;
4: next = 3'b001;
5: next = 3'b010;
default: next = 3'bxxx;
endcase
end else if (wind == 2) begin
case(curr)
4: next = 3'b010;
2: next = 3'b001;
1: next = 3'b100;
5: next = 3'b010;
default: next = 3'bxxx;
endcase
end else begin 
next = 3'b010;
end
end

always_ff @(posedge clk)
if (reset)
curr <= 3'b010;
else
curr <= next;

endmodule 


module wind_direction_testbench;
logic  [1:0] wind;
logic        reset, clk;
logic  [2:0] out;
logic  [2:0] curr, next;

wind_direction dut (clk, reset, wind, out);

parameter CLOCK_PERIOD=100;
initial begin
clk <= 0;
forever #(CLOCK_PERIOD/2) clk <= ~clk;
end


initial begin
								@(posedge clk);
reset <= 1; 				@(posedge clk);
reset <= 0; wind <= 0; 	@(posedge clk);
								@(posedge clk);
								@(posedge clk);
								@(posedge clk);
				wind <= 1; 	@(posedge clk);
				wind <= 0; 	@(posedge clk);
				wind <= 1;	@(posedge clk);
								@(posedge clk);
								@(posedge clk);								
				wind <= 2;	@(posedge clk);
				         	@(posedge clk);								
								@(posedge clk);
								@(posedge clk);
				            @(posedge clk);
								@(posedge clk);
$stop; // End the simulation.
end
endmodule