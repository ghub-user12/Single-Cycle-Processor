module ALU #(parameter N=32)(input logic [N-1:0] a, input logic[N-1:0] b, input logic [1:0] cntrl, output logic [N-1:0] out);

    always_comb 
        case (cntrl)
            2'b00 : out = a + b; // ADD
            2'b01 : out = a - b; // SUB
            2'b10 : out = a & b; // AND
            2'b11 : out = a | b; // ORR
            default : out = '0;
        endcase
endmodule

// TODO: Flags