module Dmem(input logic clk, input logic [31:0] a, wd, input logic we, output logic [31:0] rd);
    
    logic [31:0] dmem[63:0];
    
    assign rd = dmem[a[31:2]]; // word alligned
    
    always_ff @(posedge clk)
        if (we) dmem[a[31:2]] <= wd;
        
endmodule
