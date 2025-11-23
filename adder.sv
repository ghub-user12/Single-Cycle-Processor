// generic adder

module adder #(parameter L=1, parameter M=1, parameter N=1)(input logic [L-1:0] a, input logic [M-1:0] b, output logic [N-1:0] out); // N >= M >= L
    initial begin
        if (M < L) $error("Parameter M must be >= N");
        else if (N < M) $error("Parameter N must be >= M");
    end
    
    assign out = a + b;
endmodule
