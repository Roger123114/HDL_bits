module top_module (
    input clk,
    input reset,   // Synchronous reset
    input x,
    output z
);
    reg[2:0]state,next_state;
    parameter A = 3'b000,B = 3'b001,C = 3'b010,D = 3'b011,E = 3'b100;
    
    always@(*)begin
        case(state)
            A:next_state = (x) ? B : A;
            B:next_state = (x) ? E : B;
            C:next_state = (x) ? B : C;
            D:next_state = (x) ? C : B;
            E:next_state = (x) ? E : D;
            default next_state = A;
        endcase
    end
    always@(posedge clk)begin
        if(reset)begin
            state <= A;
        end
        else state <= next_state;
    end
    assign z = (state == D | state == E);
endmodule