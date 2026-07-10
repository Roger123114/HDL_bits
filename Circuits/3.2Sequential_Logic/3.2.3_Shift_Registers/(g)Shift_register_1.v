module top_module (
    input clk,
    input resetn,   // synchronous reset
    input in,
    output out);
    reg Q0,Q1,Q2;

    always@(posedge clk)begin
        if(!resetn)begin
            {out,Q2,Q1,Q0} <= 4'b0;
        end
        else begin
            {out,Q2,Q1,Q0} <= {Q2,Q1,Q0,in};
        end
    end

endmodule