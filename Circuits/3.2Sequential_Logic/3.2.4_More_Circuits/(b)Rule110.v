module top_module(
    input clk,
    input load,
    input [511:0] data,
    output reg [511:0] q
); 

    wire [511:0] left;
    wire [511:0] right;
    wire [511:0] q_next;

    assign left  = {1'b0, q[511:1]};   // left[i]  = q[i+1]
    assign right = {q[510:0], 1'b0};   // right[i] = q[i-1]

    assign q_next = (q ^ right) | (~left & q);

    always @(posedge clk) begin
        if (load)
            q <= data;
        else
            q <= q_next;
    end

endmodule