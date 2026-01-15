module top_module( 
    input [15:0] a, b, c, d, e, f, g, h, i,
    input [3:0] sel,
    output [15:0] out );
    
    always@(*)begin
        if(sel == 4'b0) out = a;
        else if(sel == 4'd1) out = b;
        else if(sel == 4'd2) out = c;
        else if(sel == 4'd3) out = d;
        else if(sel == 4'd4) out = e;
        else if(sel == 4'd5) out = f;
        else if(sel == 4'd6) out = g;
        else if(sel == 4'd7) out = h;
        else if(sel == 4'd8) out = i;
        else out = {16{1'd1}};
    end
endmodule

	// Case statements can only be used inside procedural blocks (always block)
	// This is a combinational circuit, so use a combinational always @(*) block.
	/*
    always @(*) begin
		out = '1;		// '1 is a special literal syntax for a number with all bits set to 1.
						// '0, 'x, and 'z are also valid.
						// I prefer to assign a default value to 'out' instead of using a
						// default case.
		case (sel)
			4'h0: out = a;
			4'h1: out = b;
			4'h2: out = c;
			4'h3: out = d;
			4'h4: out = e;
			4'h5: out = f;
			4'h6: out = g;
			4'h7: out = h;
			4'h8: out = i;
		endcase
	end
    */