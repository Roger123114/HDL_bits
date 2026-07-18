module top_module(
    input clk,
    input reset,    // Synchronous reset
    input in,
    output disc,
    output flag,
    output err);

    parameter IDLE = 3'd0,DISC = 3'd1,FLAG = 3'd2,ERR = 3'd3,DONE = 3'd4;

    reg [2:0] state,next_state;
    reg [2:0] bit_counter;

    always@(*)begin
        case(state)
            IDLE:begin 
                if(in == 1'b1) next_state = DISC; 
                else next_state = IDLE; 
            end
            DISC:begin
                if(bit_counter < 3'd5 && in == 1'b0) next_state = IDLE;
                else if(bit_counter == 3'd5 && in == 1'b0) next_state = DONE;
                else if(bit_counter == 3'd5 && in == 1'b1) next_state = FLAG;
                else next_state = DISC;
            end
            FLAG:begin
                if(bit_counter == 3'd6 && in == 1'b0) next_state = DONE;
                else next_state = ERR;
            end
            ERR:begin
                if(bit_counter == 3'd7 && in == 1'b0) next_state = IDLE;
                else next_state = ERR;
            end
            DONE:begin
                if(in == 1'b1) next_state = DISC;
                else next_state = IDLE;
            end
            default: next_state = IDLE;
        endcase
    end

    //Receive how much consecutive 1's
    always@(posedge clk)begin
        if(reset) bit_counter <= 3'd0;
        else begin
            if(state == IDLE)begin
                if(in) bit_counter <= 3'd1;
                else bit_counter <= 3'd0;
            end
            else if(state == DISC && in == 1'd1) bit_counter <= bit_counter + 3'd1;
            else if(state == FLAG && in == 1'd1) bit_counter <= bit_counter + 3'd1;
            else if(state == ERR) bit_counter <= 3'd7;
            else if(state == DONE)begin
                if(in) bit_counter <= 3'd1;
                else bit_counter <= 3'd0;
            end
            else bit_counter <= bit_counter;
        end
    end

    always@(posedge clk)begin
        if(reset) state <= IDLE;
        else state <= next_state;
    end

    assign disc = (state == DONE && bit_counter == 3'd5);
    assign flag = (state == DONE && bit_counter == 3'd6);
    assign err = (state == ERR);

endmodule


//Method2
// module top_module(
//     input clk,
//     input reset,    // Synchronous reset
//     input in,
//     output disc,
//     output flag,
//     output err
// );

//     parameter S0       = 4'd0;  // 0 consecutive 1s
//     parameter S1       = 4'd1;  // 1 consecutive 1
//     parameter S2       = 4'd2;
//     parameter S3       = 4'd3;
//     parameter S4       = 4'd4;
//     parameter S5       = 4'd5;
//     parameter S6       = 4'd6;
//     parameter DISCARD  = 4'd7;
//     parameter FLAG     = 4'd8;
//     parameter ERROR    = 4'd9;

//     reg [3:0] state, next_state;

//     always @(*) begin
//         case (state)

//             S0: begin
//                 if (in)
//                     next_state = S1;
//                 else
//                     next_state = S0;
//             end

//             S1: begin
//                 if (in)
//                     next_state = S2;
//                 else
//                     next_state = S0;
//             end

//             S2: begin
//                 if (in)
//                     next_state = S3;
//                 else
//                     next_state = S0;
//             end

//             S3: begin
//                 if (in)
//                     next_state = S4;
//                 else
//                     next_state = S0;
//             end

//             S4: begin
//                 if (in)
//                     next_state = S5;
//                 else
//                     next_state = S0;
//             end

//             S5: begin
//                 if (in)
//                     next_state = S6;
//                 else
//                     next_state = DISCARD;   // 0111110
//             end

//             S6: begin
//                 if (in)
//                     next_state = ERROR;     // 01111111...
//                 else
//                     next_state = FLAG;      // 01111110
//             end

//             DISCARD: begin
//                 if (in)
//                     next_state = S1;
//                 else
//                     next_state = S0;
//             end

//             FLAG: begin
//                 if (in)
//                     next_state = S1;
//                 else
//                     next_state = S0;
//             end

//             ERROR: begin
//                 if (in)
//                     next_state = ERROR;     // 7 or more consecutive 1s
//                 else
//                     next_state = S0;
//             end

//             default: begin
//                 next_state = S0;
//             end

//         endcase
//     end

//     always @(posedge clk) begin
//         if (reset)
//             state <= S0;
//         else
//             state <= next_state;
//     end

//     assign disc = (state == DISCARD);
//     assign flag = (state == FLAG);
//     assign err  = (state == ERROR);

// endmodule