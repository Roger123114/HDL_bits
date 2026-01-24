// Note the Verilog-1995 module declaration syntax here:
module top_module(clk, reset, in, out);
    input clk;
    input reset;    // Synchronous reset to state B
    input in;
    output out;//  
    reg out;

    // Fill in state name declarations
	parameter A = 1'b0,B = 1'b1;
    reg present_state, next_state;
   
    always@(*)begin
         case(present_state)
             A:begin
                 if(in == 1'b0)next_state = B;
                 else next_state = present_state;
                 out = 1'b0;
             end
             B:begin
                 if(in == 1'b0)next_state = A;
                 else next_state = present_state; 
                 out = 1'b1;
             end
         endcase
    end
    always @(posedge clk) begin
        if (reset) begin  
            present_state <= B;
        end 
        else begin
            present_state <= next_state;   
        end
    end
endmodule