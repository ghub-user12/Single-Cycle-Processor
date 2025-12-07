module Control(input logic [1:0] Op,
               input logic [5:0] Funct,
               input logic [3:0] Rd,
               output logic [1:0] RegSrc, ImmSrc, ALUcntrl,
               output logic PC_src, RF_en, D_en, MemtoReg, ALUSrc);
    
    logic [9:0] controls;
    logic Branch, ALUOp;
    
    // Main Decoder
    
    always_comb
        case(Op)
            2'b00: if(Funct[5]) controls = 10'b0000101001;
                   else controls = 10'b0000001001;
            2'b01: if(Funct[0]) controls = 10'b0001111000;
                   else controls = 10'b1001110100;
            2'b10: controls = 10'b0110100010;
            default: controls = 10'bx;
        endcase
        
    assign {RegSrc, ImmSrc, ALUSrc, MemtoReg, RF_en, D_en, Branch, ALUOp} = controls;
    
    // ALU decoder
    
    always_comb
        if(ALUOp) begin
            case(Funct[4:1])
                4'b0100: ALUcntrl = 2'b00; // ADD
                4'b0010: ALUcntrl = 2'b01; // SUB
                4'b0000: ALUcntrl = 2'b10; // AND
                4'b1100: ALUcntrl = 2'b11; // ORR
                default: ALUcntrl = 2'bx;
            endcase
        end else begin
            ALUcntrl = 2'b00;
        end
    
    // PC Logic
    assign PC_src = ((Rd == 4'b1111) & RF_en) | Branch;            
    
endmodule


// TODO: Flags and conditional