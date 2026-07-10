module top_module(
    input clk,
    input load,
    input [1:0] ena,
    input [99:0] data,
    output reg [99:0] q); 

    always@(posedge clk)begin
        if(load)begin
            q <= data;
        end
        else begin
            if(ena == 2'b00 || ena == 2'b11) q <= q;
            else if(ena == 2'b01) q <= {q[0],q[99:1]};
            else q <= {q[98:0],q[99]};
        end
    end

endmodule
