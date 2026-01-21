module top_module (
    input clk,
    input reset,            // Synchronous reset Reset 只在 clock edge 觸發時才生效：
    input [7:0] d,
    output [7:0] q
);
    always@(posedge clk)begin
        if(reset)q <= 8'd0;
        else q <= d;
    end
endmodule