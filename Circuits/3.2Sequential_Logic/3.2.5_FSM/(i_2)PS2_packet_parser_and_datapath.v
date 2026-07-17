module top_module(
    input clk,
    input [7:0] in,
    input reset,    // Synchronous reset
    output [23:0] out_bytes,
    output done);

    parameter IDLE   = 2'd0;
    parameter BYTE1  = 2'd1;
    parameter BYTE2  = 2'd2;
    parameter DONE   = 2'd3;

    reg [1:0] state, next_state;
    reg [23:0] out_temp;

    always @(*) begin
        case (state)
            IDLE: begin
                if (in[3]) next_state = BYTE1;
                else next_state = IDLE;
            end

            BYTE1: begin
                next_state = BYTE2;
            end

            BYTE2: begin
                next_state = DONE;
            end

            DONE: begin
                if (in[3]) next_state = BYTE1;
                else next_state = IDLE;
            end

            default: begin
                next_state = IDLE;
            end

        endcase
    end
    // New: Datapath to store incoming bytes.
    always @(posedge clk) begin
        if (reset)
            out_temp <= 24'b0;
        else begin
            if((state == IDLE || state == DONE) && in[3] == 1'b1) out_temp[23:16] = in;
            else if(state == BYTE1) out_temp[15:8] = in;
            else if(state == BYTE2) out_temp[7:0] = in;
            else out_temp <= out_temp;
        end
    end

    always @(posedge clk) begin
        if (reset)
            state <= IDLE;
        else
            state <= next_state;
    end

    assign done = (state == DONE);
    assign out_bytes = out_temp;

endmodule