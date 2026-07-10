module top_module(
    input clk,
    input reset,
    input ena,
    output pm,
    output [7:0] hh,
    output [7:0] mm,
    output [7:0] ss); 

    reg pm_temp;
    wire mm_en,hh_en;

    bcdcounter0_59 second(.clk(clk),.reset(reset),.enable(ena),.q(ss));
    bcdcounter0_59 minute(.clk(clk),.reset(reset),.enable(mm_en),.q(mm));
    bcdcounter1_12 hour(.clk(clk),.reset(reset),.enable(hh_en),.q(hh));
    
    assign mm_en = ena && (ss == 8'h59);
    assign hh_en = ena && (ss == 8'h59) && (mm == 8'h59);

    //Deal with pm change
    always@(posedge clk)begin
        if(reset) pm_temp <= 1'b0;
        else begin
            if(ena && (ss == 8'h59) && (mm == 8'h59) && (hh == 8'h11)) pm_temp <= ~pm_temp;
            else pm_temp <= pm_temp;
        end
    end

    assign pm = pm_temp;
    assign hh = hh;
    assign mm = mm;
    assign ss = ss;

endmodule


module bcdcounter1_12(
    input clk,
    input reset,
    input enable,
    output reg [7:0] q
);
    always@(posedge clk)begin
        if(reset) q <= 8'h12;
        else begin
            if(enable)begin
                if(q == 8'h12) q <= 8'h1;
                else if(q[3:0] == 4'd9) q <= {q[7:4] + 1'h1, 4'h0};
                else q <= q + 8'h1;
            end
            else q <= q;
        end
    end
endmodule

module bcdcounter0_59(
    input clk,
    input reset,
    input enable,
    output reg[7:0] q
);
    always@(posedge clk)begin
        if(reset) q <= 8'h0;
        else begin
            if(enable)begin
                if(q == 8'h59) q <= 8'h0;
                else if(q[3:0] == 4'd9) q <= {q[7:4] + 1'h1, 4'h0};
                else q <= q + 8'h1;
            end
            else q <= q;
        end
    end
endmodule