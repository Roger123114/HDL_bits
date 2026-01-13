module top_module( 
    input [2:0] in,
    output [1:0] out );
    reg [1:0]counter;
    
    //Method1
    always@(*)begin
        counter = 0;
        if(in[0] == 1)counter = counter + 1;
        if(in[1] == 1)counter = counter + 1;
        if(in[2] == 1)counter = counter + 1;
        else counter = counter;
    end
    assign out[0] = counter[0];
    assign out[1] = counter[1];
    
    //Method2
    //assign out = in[0] + in[1] + in[2];
    
    //Method3
    /*integer i;
    always@(*)begin
        counter = 0;
        for(i = 0;i < 3;i = i + 1)begin
            if(in[i] == 1)counter = counter + 1;
            else counter = counter;
        end
    end
    assign out[0] = counter[0];
    assign out[1] = counter[1];*/
endmodule