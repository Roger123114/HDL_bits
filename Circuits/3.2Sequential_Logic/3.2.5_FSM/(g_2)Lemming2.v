module top_module(
    input clk,
    input areset,    // Freshly brainwashed Lemmings walk left.
    input bump_left,
    input bump_right,
    input ground,
    output reg walk_left,
    output reg walk_right,
    output reg aaah ); 

    parameter LEFT=2'b00,RIGHT=2'b01,groundL=2'b10,groundR=2'b11;
    reg [1:0] state, next_state;

    always @(*) begin
        // State transition logic
        case(state)
            LEFT:begin  
                if(!ground) next_state = groundL;
                else if(bump_left) next_state = RIGHT;
                else next_state = LEFT;
            end
            RIGHT:begin
                if(!ground) next_state = groundR;
                else if(bump_right) next_state = LEFT;
                else next_state = RIGHT;
            end
            groundL:begin
                if(ground) next_state = LEFT;
                else next_state = groundL;
            end
            groundR:begin
                if(ground) next_state = RIGHT;
                else next_state = groundR;
            end
            default: next_state = LEFT;
        endcase
    end

    always @(posedge clk, posedge areset) begin
        // State flip-flops with asynchronous reset
        if(areset)begin
            state <= LEFT;
        end
        else begin
            state <= next_state;
        end
    end

    // Output logic
    always @(*) begin
        case(state)
            LEFT:begin  
                walk_left <= 1'b1;
                walk_right <= 1'b0;
                aaah <= 1'b0;
            end
            RIGHT:begin
                walk_left <= 1'b0;
                walk_right <= 1'b1;
                aaah <= 1'b0;
            end
            groundL:begin
                walk_left <= 1'b0;
                walk_right <= 1'b0;
                aaah <= 1'b1;
            end
            groundR:begin
                walk_left <= 1'b0;
                walk_right <= 1'b0;
                aaah <= 1'b1;
            end
            default:begin
                walk_left <= 1'b1;
                walk_right <= 1'b0;
                aaah <= 1'b0;
            end
        endcase
    end

    // always @(posedge clk, posedge areset) begin
    //     if(areset)begin
    //         walk_left <= 1'b1;
    //         walk_right <= 1'b0;
    //         aaah <= 1'b0;
    //     end
    //     else begin
    //         case(next_state)
    //             LEFT:begin  
    //                 walk_left <= 1'b1;
    //                 walk_right <= 1'b0;
    //                 aaah <= 1'b0;
    //             end
    //             RIGHT:begin
    //                 walk_left <= 1'b0;
    //                 walk_right <= 1'b1;
    //                 aaah <= 1'b0;
    //             end
    //             groundL:begin
    //                 walk_left <= 1'b0;
    //                 walk_right <= 1'b0;
    //                 aaah <= 1'b1;
    //             end
    //             groundR:begin
    //                 walk_left <= 1'b0;
    //                 walk_right <= 1'b0;
    //                 aaah <= 1'b1;
    //             end
    //             default:begin
    //                 walk_left <= 1'b1;
    //                 walk_right <= 1'b0;
    //                 aaah <= 1'b0;
    //             end
    //         endcase
    //     end
    // end

endmodule