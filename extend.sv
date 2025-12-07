module extend(input logic [11:0] in, output logic [31:0] out);
    assign out = {20'b0, in};    
endmodule
