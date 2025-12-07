module Imem(input logic [31:0] a, output logic [31:0] rd);
    
    logic [31:0] imem[63:0];
    
    initial begin
        $readmemh("memfile.mem", imem);
    end
    
    assign rd = imem[a[31:2]]; // word alligned
endmodule
