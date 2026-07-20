module top_module (
    input clk,
    input areset,
    input x,
    output z
); 
    parameter A = 2'd0,B = 2'd1,C = 2'd2;
    reg [1:0] state,next_state;

    always@(*)begin
        case(state)
            A:begin
                if(x)next_state = B; // Find the first 1
                else next_state = A;
            end
            B:begin //0 -> 1
                if(x)next_state = C; 
                else next_state = B;
            end            
            C:begin //1 -> 0
                if(x)next_state = C;
                else next_state = B;
            end
            default:next_state = A;
        endcase
    end

    always@(posedge clk or posedge areset)begin
        if(areset) state <= A;
        else state <= next_state;
    end 
    
    assign z = (state == B);

endmodule