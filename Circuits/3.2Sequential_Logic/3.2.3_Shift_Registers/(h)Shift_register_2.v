module top_module (
    input [3:0] SW,
    input [3:0] KEY,
    output [3:0] LEDR
); //
    wire Q3,Q2,Q1,Q0;

    MUXDFF M3(.clk(KEY[0]),.E(KEY[1]),.R(SW[3]),.L(KEY[2]),.w(KEY[3]),.q(Q3));
    MUXDFF M2(.clk(KEY[0]),.E(KEY[1]),.R(SW[2]),.L(KEY[2]),.w(Q3),.q(Q2));
    MUXDFF M1(.clk(KEY[0]),.E(KEY[1]),.R(SW[1]),.L(KEY[2]),.w(Q2),.q(Q1));
    MUXDFF M0(.clk(KEY[0]),.E(KEY[1]),.R(SW[0]),.L(KEY[2]),.w(Q1),.q(Q0));

    assign LEDR = {Q3,Q2,Q1,Q0};

endmodule

module MUXDFF (
    input clk,
    input E,
    input R,
    input L,
    input w,
    output reg q
);
    wire temp;
    assign temp = (E) ? w : q;

    always@(posedge clk)begin
        if(L) q <= R;
        else q <= temp;
    end

endmodule