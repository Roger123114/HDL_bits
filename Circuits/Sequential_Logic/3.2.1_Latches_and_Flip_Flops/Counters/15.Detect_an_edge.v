module top_module (
    input clk,
    input [7:0] in,
    output [7:0] pedge
);
    reg[7:0]q;
    integer i;
    always@(posedge clk)begin
        q <= in; 
        for(i = 0;i < 8;i = i + 1)begin
            if(q[i] == 1'b0 & in[i] == 1'b1)pedge[i] <= 1'b1;
            else pedge[i] <= 1'b0;
        end
    end
endmodule

/*module top_module (
    input clk,
    input [7:0] in,
    output [7:0] pedge
);
    reg [7:0] q;	
			
	always @(posedge clk) begin
		q <= in;			// Remember the state of the previous cycle
		pedge <= in & ~q;	// A positive edge occurred if input was 0 and is now 1.
	end
endmodule*/