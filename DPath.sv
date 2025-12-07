module DPath(input logic clk, input logic reset);
    
    logic [31:0] PC, PC_in, Instr, Data, RD1, RD2, ext, DA, R15, ext;
    logic D_en, RF_en, PC_src;
    
    // State elements
    
    Imem imem(.a(PC), .rd(Instr));
    Dmem dmem(.clk(clk), .a(DA), .wd(RD2), .we(D_en), .rd(Data));
    PC pc(.clk(clk), .reset(reset), .pc_in(PC_in), .pc(PC));
    regfile rf(.clk(clk), .we(RF_en), .ra1(Instr[19:16]), .ra2(Instr[15:12]), .wa(Instr[15:12]), .wd(Data), .r15(R15), .rd1(RD1), .rd2(RD2));
    ALU alu(.a(RD1), .b(ext), .cntrl(2'b00), .out(DA));
    
    // Ancilliary elements
    
    adder#(.N(32)) PCplus4(.a(PC), .b(3'b100), .out(PC_in));
    adder#(.N(32)) PCplus8(.a(PC_in), .b(3'b100), .out(R15));
    extend(.in(Instr[11:0]), .out(ext));
    


endmodule
