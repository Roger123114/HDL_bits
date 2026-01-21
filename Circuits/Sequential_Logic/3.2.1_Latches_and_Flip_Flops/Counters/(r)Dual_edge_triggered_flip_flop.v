//Method1
module top_module (
    input clk,
    input d,
    output q
);
    reg q_pos,q_neg;
    always@(posedge clk)begin
        q_pos <= d;
    end
    always@(negedge clk)begin
        q_neg <= d;
    end
    always@(*)begin
        if(clk)q = q_pos;
        else q = q_neg;
    end
endmodule

//Method2
module top_module(
	input clk,
	input d,
	output q);
	
	reg p, n;
	// A positive-edge triggered flip-flop
    always @(posedge clk)
        p <= d ^ n;       
    // A negative-edge triggered flip-flop
    always @(negedge clk)
        n <= d ^ p; 
    // Why does this work? 
    // After posedge clk, p changes to d^n. Thus q = (p^n) = (d^n^n) = d.
    // After negedge clk, n changes to d^p. Thus q = (p^n) = (p^d^p) = d.
    // At each (positive or negative) clock edge, p and n FFs alternately
    // load a value that will cancel out the other and cause the new value of d to remain.
    assign q = p ^ n;
	// Can't synthesize this.
	/*always @(posedge clk, negedge clk) begin
		q <= d;
	end*/
endmodule