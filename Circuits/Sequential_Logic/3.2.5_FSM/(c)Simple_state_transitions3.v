//Method1
module top_module(
    input in,
    input [1:0] state,
    output [1:0] next_state,
    output out); //

    parameter A=0, B=1, C=2, D=3;

    always@(*)begin
        case(state)
            A:begin
                if(in == 1'b0) next_state = A;
                else next_state = B;
                out = 1'b0;
            end
            B:begin
                if(in == 1'b0) next_state = C;
                else next_state = B;
                out = 1'b0;
            end
            C:begin
                if(in == 1'b0) next_state = A;
                else next_state = D;
                out = 1'b0;
            end            
            D:begin
                if(in == 1'b0) next_state = C;
                else next_state = B;
                out = 1'b1;
            end            
        endcase
    end
endmodule
//Method2
/*module top_module(
    input in,
    input [1:0] state,
    output [1:0] next_state,
    output out); //

    parameter A=0, B=1, C=2, D=3;

    // State transition logic: next_state = f(state, in)
    always@(*) begin
        case(state)
            A:next_state=(in==1'b1)?B:A;
            B:next_state=(in==1'b1)?B:C;
            C:next_state=(in==1'b1)?D:A;
            D:next_state=(in==1'b1)?B:C;
        endcase
    end
    // Output logic:  out = f(state) for a Moore state machine
    assign out=(state==D)?1'b1:1'b0;
endmodule */