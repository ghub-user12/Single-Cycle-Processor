module PC(input logic clk, input logic reset, input logic pc_in, output logic pc);
    
    always_ff @(posedge clk, posedge reset)
        if (reset) pc <= 0;
        else pc <= pc_in;

endmodule