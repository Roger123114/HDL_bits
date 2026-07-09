module top_module (
    input clk,
    input reset,   // Synchronous active-high reset
    output [3:1] ena,
    output [15:0] q);
    wire [3:0] q0,q1,q2,q3;

    bcdcounter counter0(.clk(clk),.reset(reset),.enable(1'b1),.q(q0));
    bcdcounter counter1(.clk(clk),.reset(reset),.enable(ena[1]),.q(q1));
    bcdcounter counter2(.clk(clk),.reset(reset),.enable(ena[2]),.q(q2));
    bcdcounter counter3(.clk(clk),.reset(reset),.enable(ena[3]),.q(q3));

    assign ena[1] = (q0 == 4'd9);
    assign ena[2] = (q0 == 4'd9) && (q1 == 4'd9);
    assign ena[3] = (q0 == 4'd9) && (q1 == 4'd9) && (q2 == 4'd9) ;

    assign q = {q3,q2,q1,q0};

endmodule

module bcdcounter(
    input clk,
    input reset,
    input enable,
    output [3:0] q
);
    always@(posedge clk)begin
        if(reset) q <= 4'd0;
        else begin
            if(enable)begin
                if(q < 9) q <= q + 4'd1;
                else q <= 4'd0;
            end
            else q <= q;
        end
    end
endmodule