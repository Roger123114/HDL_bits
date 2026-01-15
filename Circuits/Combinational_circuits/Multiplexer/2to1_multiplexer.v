module top_module( 
    input a, b, sel,
    output out ); 
    
    //1 choose b,0 choose a
    assign out = (sel)? b : a; 
endmodule