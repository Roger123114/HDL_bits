module top_module(
    input clk,
    input areset,    // Freshly brainwashed Lemmings walk left.
    input bump_left,
    input bump_right,
    input ground,
    input dig,
    output reg walk_left,
    output reg walk_right,
    output reg aaah,
    output reg digging ); 

    parameter LEFT=3'b000,RIGHT=3'b001,groundL=3'b010,groundR=3'b011,DIGGINGL=3'b100,DIGGINGR=3'b101;

    reg [2:0] state, next_state;

    always @(*) begin
        // State transition logic
        case(state)
            LEFT:begin  
                if(!ground) next_state = groundL;
                else if(dig) next_state = DIGGINGL;
                else if(bump_left) next_state = RIGHT;
                else next_state = LEFT;
            end
            RIGHT:begin
                if(!ground) next_state = groundR;
                else if(dig) next_state = DIGGINGR;
                else if(bump_right) next_state = LEFT;
                else next_state = RIGHT;
            end
            groundL:begin //Dig ignored
                if(ground) next_state = LEFT;
                else next_state = groundL;
            end
            groundR:begin //Dig ignored
                if(ground) next_state = RIGHT;
                else next_state = groundR;
            end
            DIGGINGL:begin
                if(!ground) next_state = groundL;
                else next_state = DIGGINGL;
            end
            DIGGINGR:begin
                if(!ground) next_state = groundR;
                else next_state = DIGGINGR;
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
    always @(posedge clk, posedge areset) begin
        if(areset)begin
            {walk_left,walk_right,aaah,digging} <= {4'b1000};
        end
        else begin
            case(next_state)
                LEFT:begin  
                    {walk_left,walk_right,aaah,digging} <= {4'b1000};
                end
                RIGHT:begin
                    {walk_left,walk_right,aaah,digging} <= {4'b0100};
                end
                groundL:begin
                    {walk_left,walk_right,aaah,digging} <= {4'b0010};
                end
                groundR:begin
                    {walk_left,walk_right,aaah,digging} <= {4'b0010};
                end
                DIGGINGL:begin
                    {walk_left,walk_right,aaah,digging} <= {4'b0001};
                end
                DIGGINGR:begin
                    {walk_left,walk_right,aaah,digging} <= {4'b0001};
                end
                default:begin
                    {walk_left,walk_right,aaah,digging} <= {4'b1000};
                end
            endcase
        end
    end
endmodule