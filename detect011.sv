module detect011(input logic sysclk, input logic reset, input logic stream, output logic y);

typedef enum logic [1:0] {S0, S1, S2, S3} state_type;
state_type state_reg, state_next;

always_comb 
    if (state_reg == S3) y = 1'b1;
    else y = 1'b0;

always_ff @(posedge sysclk, posedge reset)
    if (reset) begin
        state_reg <= S0;
    end
    else if (state_reg == S0) begin
        if (~stream) state_reg <= S1;
        else state_reg <= S0;
    end
    else if (state_reg == S1) begin
        if (~stream) state_reg <= S1;
        else state_reg <= S2;
    end
    else if (state_reg == S2) begin
        if (~stream) state_reg <= S1;
        else state_reg <= S3;
    end
    else if (state_reg == S3) begin
        if (~stream) state_reg <= S1;
        else state_reg <= S0;
    end 

endmodule
