// module top_module(
//     input clk,
//     input load,
//     input [511:0] data,
//     output reg [511:0] q); 

//     reg [511:0] q_next;
//     integer i;
//     always@(*)begin
//         for(i = 0;i < 512; i = i + 1)begin
//             if(i == 0) q_next[0] = 1'b0 ^ q[1];
//             else if(i == 511) q_next[511] = 1'b0 ^ q[510];
//             else q_next[i] = q[i-1] ^ q[i+1];
//         end
//     end

//     always@(posedge clk)begin
//         if(load) q <= data;
//         else q <= q_next;
//     end

// endmodule

module top_module(
    input clk,
    input load,
    input [511:0] data,
    output reg [511:0] q
); 

    wire [511:0] q_next;

    assign q_next = {q[510:0], 1'b0} ^ {1'b0, q[511:1]};

    always @(posedge clk) begin
        if (load)
            q <= data;
        else
            q <= q_next;
    end

endmodule