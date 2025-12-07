module Processor(input logic sysclk, reset);
    logic [31:0] Instr;
    logic [1:0]  Op;
    logic [5:0]  Funct;
    logic [3:0]  Rd;
    logic [1:0]  RegSrc, ImmSrc, ALUcntrl;
    logic        PC_src, RF_en, D_en, MemtoReg, ALUSrc;
    
    DPath dpath(.clk(sysclk), .reset(reset), .PC_src(PC_src), .RF_en(RF_en), .D_en(D_en), .MemtoReg(MemtoReg), .ALUSrc(ALUSrc), .RegSrc(RegSrc), .ImmSrc(ImmSrc), .ALUcntrl(ALUcntrl), .Instr(Instr));
    Control control(.Op(Instr[27:26]), .Funct(Instr[25:20]), .Rd(Instr[15:12]), .RegSrc(RegSrc), .ImmSrc(ImmSrc), .ALUcntrl(ALUcntrl), .PC_src(PC_src), .RF_en(RF_en), .D_en(D_en), .MemtoReg(MemtoReg), .ALUSrc(ALUSrc));
    
    
endmodule
