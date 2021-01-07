`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2020/06/12 16:29:25
// Design Name: 
// Module Name: minisys
// Project Name: 
// Target Devices: 
// Tool Versions: 
// Description: 
// 
// Dependencies: 
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
//////////////////////////////////////////////////////////////////////////////////


module minisys(
    input rst,      //Reset�źţ��ߵ�ƽ��λ
    input clk,      //���ϵ�100MHzʱ���ź�
    output [31:0] imm_ex  //��Ϊ��������Implemented ��ʵ������
    );
    
    wire clock ;        //��Ƶ���23MHzʱ���ź�
    wire [31:0] debug_wb_pc;        //�鿴PC��ֵ������PC�Ĵ���
    wire        debug_wb_rf_wen;    //�鿴�Ĵ����ѵ�дʹ�ܣ�����RFWr
    wire [4:0]  debug_wb_rf_wnum;   //�鿴�Ĵ����ѵ�Ŀ�ļĴ����ţ�����Ŀ�ļĴ���A3   
    wire [31:0] debug_wb_rf_wdata;  //�鿴�Ĵ����ѵ�д���ݣ�����WD
    
    wire [31:0] NPCtoPC;    //NPC����PC��ֵ
    wire [31:0] PCtoNPC;    //pc����NPC��ֵ
    wire [31:0] RF_RD1;     //RF�ĵ�һ���������
    wire [31:0] RF_RD2;     //RF�ĵڶ����������
    wire [31:0] PC4;        // PC + 4
    wire [31:0] Instruction;    //��ǰ������ָ��
    wire [31:0] read_data;      //�ڴ��ж���������  Ҫ����RF��
    wire [31:0] ALU_C;          //ALU�ļ�����
    wire [4:0] ALUOp;           //ALUҪִ�еĲ���
    wire [31:0] AR;     //����ALU�������ļĴ���
    
    //ͨ��ָ��ĸ�6λ�͵�6λ����������
    wire [5:0] op;              //ָ��ĸ�6λ
    wire [5:0] func;            //ָ��ĵ�6λ  
    wire [31:0] ins_out;    //����ָ��ļĴ��� IR
    
    //�����ź�
    wire [1:0] NPCOP;   //����NPC����ָ���ַ�ļ��㷽ʽ���ź�
    wire EXTOp;         //������չ�ź�
    wire [1:0] WRSel;   //RFд�����ݼĴ����ſ����ź�
    wire [1:0] WDSel;   //RFд��������Դ�����ź�
    wire DMWr;      //�洢��д�ź�
    wire BSel;      //����ALU_Bȡֵ���ź�
    wire ZeroG;     //�����Ƿ�Ҫ���м�����������
    wire Zero;      //���������־
    wire PCWr;      //PCWrд�ź�
    wire IRWr;      //IRWr  IRд�ź�
    wire backsignal;        //һ��ָ����ɺ󣬿���PC�ĸ���
    
    CLK u_clk(.clk_in1(clk),.clk_out1(clock));
    
    PC u_pc(.clk(~clock),.reset(rst),.DI(debug_wb_pc),
    .PCWr(PCWr),
    .DO(PCtoNPC));
    
    NPC u_npc(
    .PC(PCtoNPC),
    .IMM(ins_out[25:0]),
    .NPCOP(NPCOP),
    .RA(RF_RD1),
    .clock(~clock),
    .reset(rst),
//    .PCWr(PCWr),
    .PC_Update(backsignal),
    .PC4(PC4),
    .NPCtoPC(debug_wb_pc)
    );
    
    programrom u_rom(
    .PC(debug_wb_pc),
    .clock(clock),
    .Instruction(Instruction)
    );
    
    S_EXT u_ext(
    .IMM(ins_out[15:0]),
    .EXTOp(EXTOp),
    .clock(~clock),
    .IMM_EX(imm_ex)
    );
   
    RF u_rf(
    .RD1(RF_RD1),
    .RD2(RF_RD2),
    .A3(debug_wb_rf_wnum),
    .Wdata(debug_wb_rf_wdata),
    .op(op),
    .func(func),
    .instruction(ins_out),
    .clock(~clock),
    .ALU_C(ALU_C),
    .DM_RD(read_data),
//    .NPC_PC(debug_wb_pc),
    .NPC_PC(PCtoNPC),
    .WRSel(WRSel),
    .RFWr(debug_wb_rf_wen),
    .WDSel(WDSel)
    );
    
    dmemory32 u_ram(
    .read_data(read_data),
    .address(AR),
    .write_data(RF_RD2),
    .Memwrite(DMWr),
    .clock(~clock)
    );
    
    ALU u_alu(
    .ALUOp(ALUOp),
    .IMM_EX(imm_ex),
    .RF_RD2(RF_RD2),
    .RF_RD1(RF_RD1),
    .IM_D(ins_out[10:6]),
    .BSel(BSel),
    .ZeroG(ZeroG),
    .clock(~clock),
    .Zero(Zero),
    .result(ALU_C)
    );
    
    CU u_cu(
    .reset(rst),
    .clock(clock),
    .op(op),
    .func(func),
    .Zero(Zero),
    .NPCOp(NPCOP),
    .PCWr(PCWr),
    .IRWr(IRWr),
    .RFWr(debug_wb_rf_wen),
    .ALUOp(ALUOp),
    .DMWr(DMWr),
    .WRSel(WRSel),
    .WDSel(WDSel),
    .BSel(BSel),
    .ZeroG(ZeroG),
    .EXTOp(EXTOp),
    .backflag(backsignal)
    );
    
    AR_reg u_AR(
    .clock(~clock),
    .ALU_C(ALU_C),
    .AR(AR)
    );
    
    IR_reg u_IR(
    .clock(~clock),
    .IRWr(IRWr),
    .ins_in(Instruction),
    .ins_out(ins_out)
    );
endmodule
