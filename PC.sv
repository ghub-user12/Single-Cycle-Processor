module PC(input logic clk, input logic reset, input logic [31:0] pc_in, output logic [31:0] pc);
    
    always_ff @(posedge clk, posedge reset)
        if (reset) pc <= 0;
        else pc <= pc_in;

endmodule