module top_module (
    input clk,
    input areset,
    input x,
    output z
); 
    parameter A = 2'd0,B = 2'd1;
    reg [1:0] state,next_state;

    always @(*) begin
        next_state[A] = state[A] & ~x;
        next_state[B] = (state[A] & x) | state[B];
    end

    always@(posedge clk or posedge areset)begin
        if(areset) state <= 2'd01;
        else state <= next_state;
    end

    assign z = (state[A] & x) || (state[B] & ~x);

endmodule