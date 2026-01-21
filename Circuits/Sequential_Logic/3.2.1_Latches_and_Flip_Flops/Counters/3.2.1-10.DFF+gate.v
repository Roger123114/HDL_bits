module top_module (
    input clk,
    input in, 
    output out);
    wire d;
    
    assign d = in ^ out;
    always@(posedge clk)begin
        out <= d;
    end
endmodule

/*module top_module (
    input clk,
    input in, 
    output out);
    
    always@(posedge clk)begin
        out <= in ^ out;
    end
endmodule*/