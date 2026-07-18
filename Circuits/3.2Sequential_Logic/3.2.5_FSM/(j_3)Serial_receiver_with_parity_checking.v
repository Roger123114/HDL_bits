module top_module(
    input clk,
    input in,
    input reset,    // Synchronous reset
    output [7:0] out_byte,
    output done
); 
    parameter IDLE = 3'd0,BIT1 = 3'd1,BUSY = 3'd2,WAITSTOP = 3'd3,DONE = 3'd4;
    wire odd;
    wire parity_reset;
    reg [2:0] state,next_state;
    reg [3:0] counter;
    reg [7:0] out_temp;

    assign parity_reset = reset || (state == IDLE) || (state == DONE) || (state == WAITSTOP);

    //State transistion condition
    always@(*)begin
        case(state)
            IDLE:begin
                if(in == 1'b0) next_state = BIT1;
                else next_state = IDLE;
            end
            BIT1:begin
                next_state = BUSY;
            end
            BUSY:begin
                // Add : check whether serial bits are odd parity
                if(counter == 4'd11 && in != 1'b1) next_state = WAITSTOP; 
                else if(counter == 4'd11 && in == 1'b1)begin
                    if(odd) next_state = DONE;
                    else next_state = IDLE;
                end
                else next_state = BUSY;
            end
            WAITSTOP:begin
                if(in == 1'b1) next_state = IDLE;
                else next_state = WAITSTOP;
            end
            DONE:begin
                if(in == 1'b0) next_state = BIT1;
                else next_state = IDLE;
            end
            default: next_state = IDLE;
        endcase
    end

    // New: Add parity checking.
    parity p1(.clk(clk),.reset(parity_reset),.in(in),.odd(odd));

    always@(posedge clk)begin
        if (reset) counter <= 4'd0;
        else begin
            if(state == BUSY) counter <= counter + 1'd1;
            else if(state == BIT1) counter <= 4'd3;
            else if(state == WAITSTOP) counter <= counter; //Keep waiting stop bit
            else counter <= 4'd0;
        end
    end
    //Receive serial bits
    always@(posedge clk)begin
        if (reset) out_temp <= 8'd0;
        else begin
            if(state == BIT1 || (state == BUSY && counter < 4'd10)) out_temp <= {in,out_temp[7:1]};
            else out_temp <= out_temp;
        end
    end

    always @(posedge clk) begin
        if (reset) state <= IDLE;
        else state <= next_state;
    end

    assign done = (state == DONE);
    assign out_byte = out_temp;

endmodule