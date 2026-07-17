module top_module(
    input clk,
    input [7:0] in,
    input reset,    // Synchronous reset
    output done);

    parameter IDLE = 2'd0;
    parameter BYTE1  = 2'd1;
    parameter BYTE2  = 2'd2;
    parameter DONE   = 2'd3;

    reg [1:0] state, next_state;

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

    always @(posedge clk) begin
        if (reset)
            state <= IDLE;
        else
            state <= next_state;
    end

    assign done = (state == DONE);

endmodule

// module top_module(
//     input clk,
//     input [7:0] in,
//     input reset,    // Synchronous reset
//     output reg done
// ); 

//     parameter IDLE = 2'b00;
//     parameter BUSY = 2'b01;

//     reg [1:0] byte_counter;
//     reg [1:0] state, next_state; 

//     // State transition logic
//     always @(*) begin
//         case (state)

//             IDLE: begin
//                 if (in[3])
//                     next_state = BUSY;   // Find byte1
//                 else
//                     next_state = IDLE;   // Keep skip byte
//             end

//             BUSY: begin
//                 if (byte_counter == 2'd2)
//                     next_state = IDLE;   // Receive byte3，Find anoter byte1
//                 else
//                     next_state = BUSY;   // Receiving byte2/byte3
//             end

//             default: begin
//                 next_state = IDLE;
//             end

//         endcase
//     end

//     // State flip-flops
//     always @(posedge clk) begin
//         if (reset)
//             state <= IDLE;
//         else
//             state <= next_state;
//     end

//     // Byte counter and done
//     always @(posedge clk) begin
//         if (reset) begin
//             byte_counter <= 2'd0;
//             done <= 1'b0;
//         end
//         else begin
//             done <= 1'b0;   // default：done is high only one clock

//             if (state == IDLE) begin
//                 if (in[3])
//                     byte_counter <= 2'd1;   // This cycle receives byte1
//                 else
//                     byte_counter <= 2'd0;   // Hasn't find byte1
//             end
//             else begin
//                 if (byte_counter == 2'd2) begin
//                     byte_counter <= 2'd0;   // his cycle receives byte3
//                     done <= 1'b1;           // Next cycle see done=1
//                 end
//                 else begin
//                     byte_counter <= byte_counter + 2'd1;
//                 end
//             end
//         end
//     end

// endmodule