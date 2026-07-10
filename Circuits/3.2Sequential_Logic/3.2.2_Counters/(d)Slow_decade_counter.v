module top_module (
    input clk,
    input slowena,
    input reset,
    output [3:0] q);

    always@(posedge clk)begin
        if(reset) q <= 4'd0;
        else begin
            if(slowena)begin
                if(q < 4'd9) q <= q + 1'd1;
                else q <= 4'd0;
            end
            else begin
                q <= q;
            end
        end
    end
endmodule

