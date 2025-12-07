module DPath(input logic clk, input logic reset, input logic PC_src, RF_en, D_en, MemtoReg, ALUSrc, input logic [1:0] RegSrc, ImmSrc, ALUcntrl, output logic [31:0] Instr);
    
    logic [3:0] RA1, RA2;
    logic [31:0] PC, PC_in, PC_4, Data, RD1, RD2, ALU_res, R15, ext32, Result, aluB;
    
    // State elements
    
    Imem imem(.a(PC), .rd(Instr));
    Dmem dmem(.clk(clk), .a(ALU_res), .wd(RD2), .we(D_en), .rd(Data));
    PC pc(.clk(clk), .reset(reset), .pc_in(PC_in), .pc(PC));
    regfile rf(.clk(clk), .we(RF_en), .ra1(RA1), .ra2(RA2), .wa(Instr[15:12]), .wd(Result), .r15(R15), .rd1(RD1), .rd2(RD2));
    ALU alu(.a(RD1), .b(aluB), .cntrl(ALUcntrl), .out(ALU_res));
    
    // Ancilliary elements
    
    adder#(.N(32)) PCplus4(.a(PC), .b(3'b100), .out(PC_4));
    adder#(.N(32)) PCplus8(.a(PC_4), .b(3'b100), .out(R15));
    extend EXT32(.in(Instr[23:0]), .ImmSrc(ImmSrc), .out(ext32));
    
    mux#(.N(32)) PCmux(.i0(PC_4), .i1(Result), .sel(PC_src), .y(PC_in));
    mux#(.N(32)) Resultmux(.i0(ALU_res), .i1(Data), .sel(MemtoReg), .y(Result));
    mux#(.N(32)) ALUmux(.i0(RD2), .i1(ext32), .sel(ALUSrc), .y(aluB));
    
    mux#(.N(4)) RFmux2(.i0(Instr[3:0]), .i1(Instr[15:12]), .sel(RegSrc[0]), .y(RA2));
    mux#(.N(4)) RFmux1(.i0(Instr[19:16]), .i1(4'b1111), .sel(RegSrc[1]), .y(RA1));
    

endmodule
