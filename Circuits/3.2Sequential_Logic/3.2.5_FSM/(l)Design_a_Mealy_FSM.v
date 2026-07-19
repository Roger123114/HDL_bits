module top_module (
    input clk,
    input aresetn,    // Asynchronous active-low reset
    input x,
    output z ); 

    parameter S0 = 2'd0, S1 = 2'd1, S2 = 2'd2;
    reg [1:0] counter;
    reg [1:0] state,next_state;

    always@(*)begin
        case(state)
            S0:begin
                if(x) next_state = S1;
                else next_state = S0;
                z = 0;
            end
            S1:begin
                if(x)begin
                    next_state = S1;
                    z = 0;
                end
                else begin
                    next_state = S2;
                    z = 0;
                end
            end
            S2:begin
                if(x)begin
                    next_state = S1;
                    z = 1;
                end
                else begin
                    next_state = S0;
                    z = 0;
                end
            end
            default: begin
                next_state = S0;
                z = 0;
            end
        endcase
    end

    always@(posedge clk or negedge aresetn)begin
        if(!aresetn) state <= S0;
        else state <= next_state;
    end
endmodule