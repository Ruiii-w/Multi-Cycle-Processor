`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2020/06/05 15:20:10
// Design Name: 
// Module Name: NPC
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


module NPC(
    input [31:0] PC,
    input [25:0] IMM,
    input [1:0] NPCOP,
    input [31:0] RA,
    input clock,
    input reset,
    input PC_Update,
    output [31:0] PC4,
    output reg [31:0] NPCtoPC
    );
    wire[31:0] BEQ_PC;
    wire [31:0] IMM_EX;
    wire [31:0] NPCtoPC_reg;
    reg PC_flag = 0; //reset降下去之后，保持PC=32'b0一个指令周期，执行第一条指令
    
    EXT_4_NPC U_S_EXT_4_NPC(
    .IMM(IMM[15:0]),
    .EXTOp(1'b1),
    .IMM_EX(IMM_EX)
    );
    assign PC4 = PC + 4;
    assign BEQ_PC = (PC4 +{IMM_EX[29:0],2'b00});
    assign NPCtoPC_reg = (NPCOP==2'b10) ? RA : ( (NPCOP==2'b11) ? {PC[31:28],IMM,2'b00} : ((NPCOP == 2'b01)? (PC4+{14'b0,IMM[15:0],2'b00}) : PC4 ));
    always@(posedge clock)
    begin
        if(!reset && PC_flag == 0)
//        if(!reset)
        begin
            PC_flag = 1;
        end
        else if(reset)
            NPCtoPC = 32'b0;
        else if(PC_Update)
        begin
            NPCtoPC = NPCtoPC_reg;
        end
        else
        begin
        
        end
    end
endmodule
