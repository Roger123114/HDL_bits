//method1
module top_module (
    input clk,
    input reset,
    input [31:0] in,
    output [31:0] out
);
    reg [31:0]q;
    always@(posedge clk)begin
        q <= in;
        if(reset)begin
            out <= 32'b0;
        end
        else begin
            out <= out | (q & ~in);
        end           
    end
endmodule

//method2
//set_mask 把「偵測條件」獨立出來，可讀性最好
//prev_in 一直更新，不會吃掉 reset 前後邊界的轉換（你前面遇到的 bug）
/*module top_module (
    input        clk,
    input        reset,
    input  [31:0] in,
    output reg [31:0] out
);
    reg  [31:0] prev_in;
    wire [31:0] set_mask;

    assign set_mask = prev_in & ~in;   // 1->0 偵測

    always @(posedge clk) begin
        prev_in <= in;                 // 永遠更新上一拍的輸入
        if (reset)
            out <= 32'b0;              // reset 優先
        else
            out <= out | set_mask;     // sticky set
    end
endmodule*/