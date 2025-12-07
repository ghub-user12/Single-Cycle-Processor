module DPath(input logic clk, input logic reset, input logic PC_src, RF_en, D_en, MemtoReg, ALUSrc, input logic [1:0] RegSrc, output logic [31:0] Instr);
    
    logic [31:0] PC, PC_in, PC_4, Data, RA1, RA2, RD1, RD2, ext, ALU_res, R15, ext32, Result, aluB;
    
    // State elements
    
    Imem imem(.a(PC), .rd(Instr));
    Dmem dmem(.clk(clk), .a(ALU_res), .wd(RD2), .we(D_en), .rd(Data));
    PC pc(.clk(clk), .reset(reset), .pc_in(PC_in), .pc(PC));
    regfile rf(.clk(clk), .we(RF_en), .ra1(RA1), .ra2(RA2), .wa(Instr[15:12]), .wd(Result), .r15(R15), .rd1(RD1), .rd2(RD2));
    ALU alu(.a(RD1), .b(aluB), .cntrl(2'b00), .out(ALU_res));
    
    // Ancilliary elements
    
    adder#(.N(32)) PCplus4(.a(PC), .b(3'b100), .out(PC_4));
    adder#(.N(32)) PCplus8(.a(PC_4), .b(3'b100), .out(R15));
    extend(.in(Instr[23:0]), .out(ext32));
    
    mux#(.N(32)) PCmux(.i0(PC_4), .i1(Result), .sel(PC_src), .out(PC_in));
    mux#(.N(32)) Resultmux(.i0(ALU_res), .i1(Data), .sel(MemtoReg), .out(Result));
    mux#(.N(32)) ALUmux(.i0(RD2), .i1(ext32), .sel(ALUSrc), .out(aluB));
    
    mux#(.N(4)) RFmux2(.i0(Instr[3:0]), .i1(Instr[15:12]), .sel(RegSrc[0]), .out(RA2));
    mux#(.N(4)) RFmux1(.i0(Instr[19:16]), .i1(Instr[4'b1111]), .sel(RegSrc[1]), .out(RA1));
    


endmodule
