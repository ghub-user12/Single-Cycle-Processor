module mux#(parameter N=8)(input logic [N-1:0] i0, i1, input logic sel, output logic [N-1:0] y);
    assign y = sel ? i1 : i0;
endmodule
