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
    input rst,      //Reset信号，高电平复位
    input clk,      //板上的100MHz时钟信号
    output [31:0] imm_ex  //作为输出，完成Implemented 无实际意义
    );
    
    wire clock ;        //分频后的23MHz时钟信号
    wire [31:0] debug_wb_pc;        //查看PC的值，连接PC寄存器
    wire        debug_wb_rf_wen;    //查看寄存器堆的写使能，连接RFWr
    wire [4:0]  debug_wb_rf_wnum;   //查看寄存器堆的目的寄存器号，连接目的寄存器A3   
    wire [31:0] debug_wb_rf_wdata;  //查看寄存器堆的写数据，连接WD
    
    wire [31:0] NPCtoPC;    //NPC传给PC的值
    wire [31:0] PCtoNPC;    //pc传给NPC的值
    wire [31:0] RF_RD1;     //RF的第一个输出数据
    wire [31:0] RF_RD2;     //RF的第二个输出数据
    wire [31:0] PC4;        // PC + 4
    wire [31:0] Instruction;    //当前读出的指令
    wire [31:0] read_data;      //内存中读出的数据  要送入RF中
    wire [31:0] ALU_C;          //ALU的计算结果
    wire [4:0] ALUOp;           //ALU要执行的操作
    wire [31:0] AR;     //保存ALU运算结果的寄存器
    
    //通过指令的高6位和低6位完成译码操作
    wire [5:0] op;              //指令的高6位
    wire [5:0] func;            //指令的低6位  
    wire [31:0] ins_out;    //保存指令的寄存器 IR
    
    //控制信号
    wire [1:0] NPCOP;   //控制NPC下条指令地址的计算方式的信号
    wire EXTOp;         //数据拓展信号
    wire [1:0] WRSel;   //RF写入数据寄存器号控制信号
    wire [1:0] WDSel;   //RF写入数据来源控制信号
    wire DMWr;      //存储器写信号
    wire BSel;      //控制ALU_B取值的信号
    wire ZeroG;     //控制是否要进行计算结果的判零
    wire Zero;      //计算结果零标志
    wire PCWr;      //PCWr写信号
    wire IRWr;      //IRWr  IR写信号
    wire backsignal;        //一条指令完成后，控制PC的更新
    
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
