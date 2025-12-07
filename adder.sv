// generic adder

module adder #(parameter N=8)(input logic [N-1:0] a, input logic [N-1:0] b, output logic [N-1:0] out);
    
    assign out = a + b;
endmodule
