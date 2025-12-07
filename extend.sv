module extend(input logic [23:0] in, input logic [1:0] ImmSrc, output logic [31:0] out);
    always_comb
        case (ImmSrc)
            2'b00 : out = {24'b0, in[7:0]};
            2'b01 : out = {20'b0, in[11:0]};
            2'b10 : out = {{6{in[23]}}, in[23:0], 2'b00};
            default : out = 32'bx;
        endcase   
endmodule
