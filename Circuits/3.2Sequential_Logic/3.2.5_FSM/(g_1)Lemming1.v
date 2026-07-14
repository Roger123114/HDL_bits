module top_module(
    input clk,
    input areset,    // Freshly brainwashed Lemmings walk left.
    input bump_left,
    input bump_right,
    output walk_left,
    output walk_right); 

    // parameter LEFT=0, RIGHT=1, ...
    reg state, next_state;

    always @(*) begin
        // State transition logic
            if(bump_left & bump_right) next_state = ~state;
            else if(bump_left) next_state = 1'b1;
            else if(bump_right) next_state = 1'b0;
            else next_state = state;
    end

    always @(posedge clk, posedge areset) begin
        // State flip-flops with asynchronous reset
        if(areset)begin
            state <= 1'b0;
        end
        else begin
            state <= next_state;
        end
    end

    // Output logic
    assign walk_left = (state == 1'b0);
    assign walk_right = (state == 1'b1);

endmodule
