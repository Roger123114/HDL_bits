module top_module(
    input clk,
    input load,
    input [255:0] data,
    output [255:0] q ); 

    reg [3:0] count;
    reg [255:0] q_next;
    integer row,col;
    integer up,down,right,left;

    always@(*)begin
        for(row = 0;row < 16;row = row + 1)begin
            for(col = 0;col < 16;col = col + 1)begin
                count = 4'b0;
                up = (row == 0) ? 15 : row - 1;
                down = (row == 15) ? 0 : row + 1;
                left = (col == 0) ? 15 : col - 1;
                right = (col == 15) ? 0 : col + 1;

                count = count + q[up * 16 + left];
                count = count + q[up * 16 + col];
                count = count + q[up * 16 + right];

                count = count + q[row * 16 + left];
                count = count + q[row * 16 + right];

                count = count + q[down * 16 + left];
                count = count + q[down * 16 + col];
                count = count + q[down * 16 + right];

                if(count == 4'd2) q_next[row * 16 + col] = q[row * 16 + col];
                else if(count == 4'd3) q_next[row * 16 + col] = 1'b1;
                else q_next[row * 16 + col] = 1'b0;
            end
        end
    end

    always @(posedge clk) begin
        if (load)
            q <= data;
        else
            q <= q_next;
    end

endmodule