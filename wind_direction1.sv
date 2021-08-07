module wind_direction1 (clk, reset, wind, out);
input  [1:0] wind;
input        reset, clk;
output [2:0] out;
logic  [2:0] curr, next;

assign out = next;

always @(*) begin 
if (wind == 0) 
case(curr)
0: next = 3'b101;
5: next = 3'b010;
2: next = 3'b101;
default: next = 3'bxxx;
endcase
 else if (wind == 1) 
case(curr)
0: next = 3'b001;
1: next = 3'b010;
2: next = 3'b100;
4: next = 3'b001;
default: next = 3'bxxx;
endcase
 else if (wind == 2) 
case(curr)
0: next = 3'b100;
4: next = 3'b010;
2: next = 3'b001;
1: next = 3'b100;
default: next = 3'bxxx;
endcase
else 
assign next = 3'b000;
end


always_ff @(posedge clk)
if (reset)
next <= 0;
else
curr <= next;

endmodule