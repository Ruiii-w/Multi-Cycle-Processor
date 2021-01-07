`timescale 1ns / 1ps
`include "para.v"
`define S1 3'b001
`define S2 3'b010
`define S3 3'b011
`define S4 3'b100
`define S5 3'b101

//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2020/06/08 13:41:30
// Design Name: 
// Module Name: CU
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
`define PC4 2'b00 

module CU(  
    input reset,
    input clock,
    input [5:0] op,
    input [5:0] func,
    input Zero,
    output backflag,
    output reg [1:0] NPCOp,
    output reg PCWr,
    output reg IRWr,
    output reg RFWr,
    output reg[4:0] ALUOp,
    output reg DMWr,
    output reg [1:0] WRSel,
    output reg [1:0] WDSel,
    output reg BSel,
    output reg ZeroG,
    output reg EXTOp
    //output M1
    );
//    reg [1:0] NPCOp_reg;
//    reg [4:0] ALUOp_reg;
//    reg [1:0] WRSel_reg;
//    reg RFWr_reg;
//    reg DMWr_reg;
//    reg [1:0] WDSel_reg;
//    reg BSel_reg;
//    reg ZeroG_reg;
//    reg EXTOp_reg;
    reg [2:0] Current_State;
    reg backsign = 1;   //一条指令执行结束，返回取指阶段的信号
    reg backsign2;
    wire T1;
    wire T2;
    wire T3;
    wire T4;
    wire T5;
    reg flag=0;
    assign T1 = (Current_State==`S1);
    assign T2 = (Current_State==`S2);
    assign T3 = (Current_State==`S3);
    assign T4 = (Current_State==`S4);
    assign T5 = (Current_State==`S5);
    assign backflag = backsign;
//    always@( op or func )
//    begin
//        backsign2 = 1;
//    end
    always@(posedge clock)
    begin
        if(reset==1)
        begin
            Current_State <= 3'b0;   
        end
        else
        begin
            if( Current_State <= 3'b0 || backsign == 1 || backsign2 == 1)
//            if(backsign == 1 || backsign2 == 1)
                Current_State <= `S1;
            else if(Current_State <= `S1)
                Current_State <= `S2;
            else if(Current_State <= `S2)
                Current_State <= `S3;
            else if(Current_State <= `S3)
                Current_State <= `S4;
            else if(Current_State <= `S4)
                Current_State <= `S5;
            else if(Current_State <= `S5)
                Current_State <= `S1;
        end
    end
    always@(*)
    begin
        if(reset==1)
        begin
            NPCOp <= 2'b0;
            PCWr <= 1;
            IRWr <= 1;
//            backsign <= 0;
            RFWr <= 1;
            WDSel <= 2'b00;
            WRSel <= 2'b00;
        end
        else
            if(op == 6'b0)
            begin
                case (func)
                    6'b100000: 
                    begin
                        if(T1)
                        begin
//                            WRSel <= 2'b11;
//                            WDSel <= 2'b11;
                            NPCOp <= `PC4;
                            PCWr <= 1;
                            IRWr <= 1;
                            backsign <= 0;
                            EXTOp <= 1'bX;
                            DMWr <= 0;
                            RFWr <= 0;
                            backsign2 <= 0;
                        end
                        else if (T3)
                        begin
                            ALUOp <= `ADD;
                            ZeroG <= 0;
                            BSel <= 0;
                            PCWr <= 0;
    //                        IRWr <= 0;
                        end
                        else if (T4)
                        begin
                            RFWr <= 1;
                            WRSel <= 2'b01;
                            WDSel <= 2'b00;
                            backsign <= 1;
                            IRWr <= 0;
                        end
                        else
                        begin
                            backsign <= 0;
                            EXTOp <= 1'bX;
                            DMWr <= 0;
                            PCWr <= 0;
    //                        IRWr <= 0;
                            ALUOp <= `ADD;
                            ZeroG <= 0;
                            BSel <= 0;
                            RFWr <= 0;
                            WRSel <= 2'b01;
                            WDSel <= 2'b00;
                        end
                    end
                    6'b100001:
                    begin
                        if(T1)
                        begin
                            NPCOp <= `PC4;
                            PCWr <= 1;
                            IRWr <= 1;
                            backsign <= 0;
                            EXTOp <= 1'bX;
                            DMWr <= 0;
                            RFWr <= 0;
                            backsign2 <= 0;
                        end
                        else if (T3)
                        begin
                            ALUOp <= `ADD;
                            ZeroG <= 0;
                            BSel <= 0;
                            PCWr <= 0;
    //                        IRWr <= 0;
                        end
                        else if (T4)
                        begin
                            RFWr <= 1;
                            WRSel <= 2'b01;
                            WDSel <= 2'b00;
                            backsign <= 1;
                            IRWr <= 0;
                        end
                        else
                        begin
                            backsign <= 0;
                            EXTOp <= 1'bX;
                            DMWr <= 0;
                            PCWr <= 0;
    //                        IRWr <= 0;
                            ALUOp <= `ADD;
                            ZeroG <= 0;
                            BSel <= 0;
                            RFWr <= 0;
                            WRSel <= 2'b01;
                            WDSel <= 2'b00;
                        end
                    end
                    6'b100010:
                    begin
                        if(T1)
                        begin
                            backsign2 <= 0;
                            NPCOp <= `PC4;
                            PCWr <= 1;
                            IRWr <= 1;
                            backsign <= 0;
                            EXTOp <= 1'bX;
                            DMWr <= 0;
                            RFWr <= 0;
                        end
                        else if (T3)
                        begin
                            ALUOp <= `SUB;
                            ZeroG <= 0;
                            BSel <= 0;
                            PCWr <= 0;
    //                        IRWr <= 0;
                        end
                        else if (T4)
                        begin
                            RFWr <= 1;
                            WRSel <= 2'b01;
                            WDSel <= 2'b00;
                            backsign <= 1;
                            IRWr <= 0;
                        end
                        else
                        begin
                            backsign <= 0;
                            EXTOp <= 1'bX;
                            DMWr <= 0;
                            PCWr <= 0;
    //                        IRWr <= 0;
    //                        ALUOp <= `SUB;
                            ZeroG <= 0;
                            BSel <= 0;
                            RFWr <= 0;
                            WRSel <= 2'b01;
                            WDSel <= 2'b00;
                        end
                    end
                    6'b100011:
                    begin
                        if(T1)
                        begin
                            backsign2 <= 0;
                            NPCOp <= `PC4;
                            PCWr <= 1;
                            IRWr <= 1;
                            backsign <= 0;
                            EXTOp <= 1'bX;
                            DMWr <= 0;
                            RFWr <= 0;
                        end
                        else if (T3)
                        begin
                            ALUOp <= `SUB;
                            ZeroG <= 0;
                            BSel <= 0;
                            PCWr <= 0;
    //                        IRWr <= 0;
                        end
                        else if (T4)
                        begin
                            RFWr <= 1;
                            WRSel <= 2'b01;
                            WDSel <= 2'b00;
                            backsign <= 1;
                            IRWr <= 0;
                        end
                        else
                        begin
                            backsign <= 0;
                            EXTOp <= 1'bX;
                            DMWr <= 0;
                            PCWr <= 0;
    //                        IRWr <= 0;
    //                        ALUOp <= `SUB;
                            ZeroG <= 0;
                            BSel <= 0;
                            RFWr <= 0;
                            WRSel <= 2'b01;
                            WDSel <= 2'b00;
                        end
                    end
                    6'b100100:
                    begin
                        if(T1)
                        begin
                            backsign2 <= 0;
                            NPCOp <= `PC4;
                            PCWr <= 1;
                            IRWr <= 1;
                            backsign <= 0;
                            EXTOp <= 1'bX;
                            DMWr <= 0;
                            RFWr <= 0;
                        end
                        else if (T3)
                        begin
                            ALUOp <= `AND;
                            ZeroG <= 0;
                            BSel <= 0;
                            PCWr <= 0;
    //                        IRWr <= 0;
                        end
                        else if (T4)
                        begin
                            RFWr <= 1;
                            WRSel <= 2'b01;
                            WDSel <= 2'b00;
                            backsign <= 1;
                            IRWr <= 0;
                        end
                        else
                        begin
                            backsign <= 0;
                            EXTOp <= 1'bX;
                            DMWr <= 0;
                            PCWr <= 0;
    //                        IRWr <= 0;
                            ZeroG <= 0;
                            BSel <= 0;
                            RFWr <= 0;
                            WRSel <= 2'b01;
                            WDSel <= 2'b00;
                        end
                    end 
                    6'b100101:
                    begin
                       if(T1)
                        begin
                            backsign2 <= 0;
                            NPCOp <= `PC4;
                            PCWr <= 1;
                            IRWr <= 1;
                            backsign <= 0;
                            EXTOp <= 1'bX;
                            DMWr <= 0;
                            RFWr <= 0;
                        end
                        else if (T3)
                        begin
                            ALUOp <= `OR;
                            ZeroG <= 0;
                            BSel <= 0;
                            PCWr <= 0;
    //                        IRWr <= 0;
                        end
                        else if (T4)
                        begin
                            RFWr <= 1;
                            WRSel <= 2'b01;
                            WDSel <= 2'b00;
                            backsign <= 1;
                            IRWr <= 0;
                        end
                        else
                        begin
                            backsign <= 0;
                            EXTOp <= 1'bX;
                            DMWr <= 0;
                            PCWr <= 0;
    //                        IRWr <= 0;
                            ZeroG <= 0;
                            BSel <= 0;
                            RFWr <= 0;
                            WRSel <= 2'b01;
                            WDSel <= 2'b00;
                        end
                    end
                    6'b100110:
                    begin
                        if(T1)
                        begin
                            backsign2 <= 0;
                            NPCOp <= `PC4;
                            PCWr <= 1;
                            IRWr <= 1;
                            backsign <= 0;
                            EXTOp <= 1'bX;
                            DMWr <= 0;
                            RFWr <= 0;
                        end
                        else if (T3)
                        begin
                            ALUOp <= `XOR;
                            ZeroG <= 0;
                            BSel <= 0;
                            PCWr <= 0;
    //                        IRWr <= 0;
                        end
                        else if (T4)
                        begin
                            RFWr <= 1;
                            WRSel <= 2'b01;
                            WDSel <= 2'b00;
                            backsign <= 1;
                            IRWr <= 0;
                        end
                        else
                        begin
                            backsign <= 0;
                            EXTOp <= 1'bX;
                            DMWr <= 0;
                            PCWr <= 0;
    //                        IRWr <= 0;
                            ZeroG <= 0;
                            BSel <= 0;
                            RFWr <= 0;
                            WRSel <= 2'b01;
                            WDSel <= 2'b00;
                        end
                    end
                    6'b100111:
                    begin
                        if(T1)
                        begin
                            backsign2 <= 0;
                            NPCOp <= `PC4;
                            PCWr <= 1;
                            IRWr <= 1;
                            backsign <= 0;
                            EXTOp <= 1'bX;
                            DMWr <= 0;
                            RFWr <= 0;
                        end
                        else if (T3)
                        begin
                            ALUOp <= `NOR;
                            ZeroG <= 0;
                            BSel <= 0;
                            PCWr <= 0;
    //                        IRWr <= 0;
                        end
                        else if (T4)
                        begin
                            RFWr <= 1;
                            WRSel <= 2'b01;
                            WDSel <= 2'b00;
                            backsign <= 1;
                            IRWr <= 0;
                        end
                        else
                        begin
                            backsign <= 0;
                            EXTOp <= 1'bX;
                            DMWr <= 0;
                            PCWr <= 0;
    //                        IRWr <= 0;
                            ZeroG <= 0;
                            BSel <= 0;
                            RFWr <= 0;
                            WRSel <= 2'b01;
                            WDSel <= 2'b00;
                        end
                    end
                    6'b101010:
                    begin
                        if(T1)
                        begin
                            backsign2 <= 0;
                            NPCOp <= `PC4;
                            PCWr <= 1;
                            IRWr <= 1;
                            backsign <= 0;
                            EXTOp <= 1'bX;
                            DMWr <= 0;
                            RFWr <= 0;
                        end
                        else if (T3)
                        begin
                            ALUOp <= `SUB;
                            ZeroG <= 1;
                            BSel <= 0;
                            PCWr <= 0;
    //                        IRWr <= 0;
                        end
                        else if (T4)
                        begin
                            RFWr <= 1;
                            WRSel <= 2'b01;
                            WDSel <= 2'b00;
                            backsign <= 1;
                            IRWr <= 0;
                        end
                        else
                        begin
                            backsign <= 0;
                            EXTOp <= 1'bX;
                            DMWr <= 0;
                            PCWr <= 0;
    //                        IRWr <= 0;
                            ZeroG <= 0;
                            BSel <= 0;
                            RFWr <= 0;
                            WRSel <= 2'b01;
                            WDSel <= 2'b00;
                        end
                    end
                    6'b101011:
                    begin
                        if(T1)
                        begin
                            backsign2 <= 0;
                            NPCOp <= `PC4;
                            PCWr <= 1;
                            IRWr <= 1;
                            backsign <= 0;
                            EXTOp <= 1'bX;
                            DMWr <= 0;
                            RFWr <= 0;
                        end
                        else if (T3)
                        begin
                            ALUOp <= `SUB;
                            ZeroG <= 1;
                            BSel <= 0;
                            PCWr <= 0;
    //                        IRWr <= 0;
                        end
                        else if (T4)
                        begin
                            RFWr <= 1;
                            WRSel <= 2'b01;
                            WDSel <= 2'b00;
                            backsign <= 1;
                            IRWr <= 0;
                        end
                        else
                        begin
                            backsign <= 0;
                            EXTOp <= 1'bX;
                            DMWr <= 0;
                            PCWr <= 0;
    //                        IRWr <= 0;
                            ZeroG <= 0;
                            BSel <= 0;
                            RFWr <= 0;
                            WRSel <= 2'b01;
                            WDSel <= 2'b00;
                        end
                    end
                    6'b000000:
                    begin
                        if(T1)
                        begin
                            backsign2 <= 0;
                            NPCOp <= `PC4;
                            PCWr <= 1;
                            IRWr <= 1;
                            backsign <= 0;
                            EXTOp <= 1'bX;
                            DMWr <= 0;
                            RFWr <= 0;
                        end
                        else if (T3)
                        begin
                            ALUOp <= `SLL;
                            ZeroG <= 0;
                            BSel <= 0;
                            PCWr <= 0;
    //                        IRWr <= 0;
                        end
                        else if (T4)
                        begin
                            RFWr <= 1;
                            WRSel <= 2'b01;
                            WDSel <= 2'b00;
                            backsign <= 1;
                            IRWr <= 0;
                        end
                        else
                        begin
                            backsign <= 0;
                            EXTOp <= 1'bX;
                            DMWr <= 0;
                            PCWr <= 0;
    //                        IRWr <= 0;
                            ZeroG <= 0;
                            BSel <= 0;
                            RFWr <= 0;
                            WRSel <= 2'b01;
                            WDSel <= 2'b00;
                        end
                    end
                    6'b000010:
                    begin
                        if(T1)
                        begin
                            backsign2 <= 0;
                            NPCOp <= `PC4;
                            PCWr <= 1;
                            IRWr <= 1;
                            backsign <= 0;
                            EXTOp <= 1'bX;
                            DMWr <= 0;
                            RFWr <= 0;
                        end
                        else if (T3)
                        begin
                            ALUOp <= `SRL;
                            ZeroG <= 0;
                            BSel <= 0;
                            PCWr <= 0;
    //                        IRWr <= 0;
                        end
                        else if (T4)
                        begin
                            RFWr <= 1;
                            WRSel <= 2'b01;
                            WDSel <= 2'b00;
                            backsign <= 1;
                            IRWr <= 0;
                        end
                        else
                        begin
                            backsign <= 0;
                            EXTOp <= 1'bX;
                            DMWr <= 0;
                            PCWr <= 0;
    //                        IRWr <= 0;
                            ZeroG <= 0;
                            BSel <= 0;
                            RFWr <= 0;
                            WRSel <= 2'b01;
                            WDSel <= 2'b00;
                        end
                    end
                    6'b000011:
                    begin
                        if(T1)
                        begin
                            backsign2 <= 0;
                            NPCOp <= `PC4;
                            PCWr <= 1;
                            IRWr <= 1;
                            backsign <= 0;
                            EXTOp <= 1'bX;
                            DMWr <= 0;
                            RFWr <= 0;
                        end
                        else if (T3)
                        begin
                            ALUOp <= `SRA;
                            ZeroG <= 0;
                            BSel <= 0;
                            PCWr <= 0;
    //                        IRWr <= 0;
                        end
                        else if (T4)
                        begin
                            RFWr <= 1;
                            WRSel <= 2'b01;
                            WDSel <= 2'b00;
                            backsign <= 1;
                            IRWr <= 0;
                        end
                        else
                        begin
                            backsign <= 0;
                            EXTOp <= 1'bX;
                            DMWr <= 0;
                            PCWr <= 0;
    //                        IRWr <= 0;
                            ZeroG <= 0;
                            BSel <= 0;
                            RFWr <= 0;
                            WRSel <= 2'b01;
                            WDSel <= 2'b00;
                        end
                    end
                    6'b000100:
                    begin
                        if(T1)
                        begin
                            backsign2 <= 0;
                            NPCOp <= `PC4;
                            PCWr <= 1;
                            IRWr <= 1;
                            backsign <= 0;
                            EXTOp <= 1'bX;
                            DMWr <= 0;
                            RFWr <= 0;
                        end
                        else if (T3)
                        begin
                            ALUOp <= `SLLV;
                            ZeroG <= 0;
                            BSel <= 0;
                            PCWr <= 0;
    //                        IRWr <= 0;
                        end
                        else if (T4)
                        begin
                            RFWr <= 1;
                            WRSel <= 2'b01;
                            WDSel <= 2'b00;
                            backsign <= 1;
                            IRWr <= 0;
                        end
                        else
                        begin
                            backsign <= 0;
                            EXTOp <= 1'bX;
                            DMWr <= 0;
                            PCWr <= 0;
    //                        IRWr <= 0;
                            ZeroG <= 0;
                            BSel <= 0;
                            RFWr <= 0;
                            WRSel <= 2'b01;
                            WDSel <= 2'b00;
                        end
                    end
                    6'b000110:
                    begin
                        if(T1)
                        begin
                            backsign2 <= 0;
                            NPCOp <= `PC4;
                            PCWr <= 1;
                            IRWr <= 1;
                            backsign <= 0;
                            EXTOp <= 1'bX;
                            DMWr <= 0;
                            RFWr <= 0;
                        end
                        else if (T3)
                        begin
                            ALUOp <= `SRLV;
                            ZeroG <= 0;
                            BSel <= 0;
                            PCWr <= 0;
    //                        IRWr <= 0;
                        end
                        else if (T4)
                        begin
                            RFWr <= 1;
                            WRSel <= 2'b01;
                            WDSel <= 2'b00;
                            backsign <= 1;
                            IRWr <= 0;
                        end
                        else
                        begin
                            backsign <= 0;
                            EXTOp <= 1'bX;
                            DMWr <= 0;
                            PCWr <= 0;
    //                        IRWr <= 0;
                            ZeroG <= 0;
                            BSel <= 0;
                            RFWr <= 0;
                            WRSel <= 2'b01;
                            WDSel <= 2'b00;
                        end
                    end
                    6'b000111:
                    begin
                       if(T1)
                        begin
                            backsign2 <= 0;
                            NPCOp <= `PC4;
                            PCWr <= 1;
                            IRWr <= 1;
                            backsign <= 0;
                            EXTOp <= 1'bX;
                            DMWr <= 0;
                            RFWr <= 0;
                        end
                        else if (T3)
                        begin
                            ALUOp <= `SRAV;
                            ZeroG <= 1;
                            BSel <= 0;
                            PCWr <= 0;
    //                        IRWr <= 0;
                        end
                        else if (T4)
                        begin
                            RFWr <= 1;
                            WRSel <= 2'b01;
                            WDSel <= 2'b00;
                            backsign <= 1;
                            IRWr <= 0;
                        end
                        else
                        begin
                            backsign <= 0;
                            EXTOp <= 1'bX;
                            DMWr <= 0;
                            PCWr <= 0;
    //                        IRWr <= 0;
                            ZeroG <= 0;
                            BSel <= 0;
                            RFWr <= 0;
                            WRSel <= 2'b01;
                            WDSel <= 2'b00;
                        end
                    end
                    6'b001000:
                    begin
                        if(T1)
                        begin
                            backsign2 <= 0;
                            NPCOp <= `PC4;
                            PCWr <= 1;
                            IRWr <= 1;
                            backsign <= 0;
                            EXTOp <= 1'bX;
                            DMWr <= 0;
                            ZeroG <= 0;
                            BSel <= 1'bX;
                            RFWr <= 0;
                        end
                        else if(T2)
                        begin
                            NPCOp <= 2'b10;
                            PCWr <= 1;
                            backsign <= 1;
                            IRWr <= 0;
                            EXTOp <= 1'bX;
                            DMWr <= 0;
                            ZeroG <= 0;
                            BSel <= 1'bX;
                            RFWr <= 0;
                            WRSel <= 2'bXX;
                            WDSel <= 2'bXX;
                            ALUOp <= `X;
                        end
                    end
                endcase
            end
            
            else 
            begin
                case(op)
                    6'b001000:
                    begin
                        if(T1)
                        begin
                            backsign2 <= 0;
                            NPCOp <= `PC4;
                            PCWr <= 1;
                            IRWr <= 1;
                            backsign <= 0;
                            RFWr <= 0;
                            DMWr <= 0;
                        end
                        else if(T2)
                        begin
                            PCWr <= 0;
    //                        IRWr <= 0;
                            EXTOp <= 1'b1;
                        end
                        else if(T3)
                        begin
                            ALUOp <= `ADD;
                            ZeroG <= 0;
                            BSel <= 1'b1;
                        end
                        else if(T4)
                        begin
                            WRSel <= 2'b00;
                            WDSel <= 2'b00;
                            RFWr <= 1;
                            backsign <= 1;
                            IRWr <= 0;
                        end
    
                    end
                    6'b001001:
                    begin
                        if(T1)
                        begin
                            backsign2 <= 0;
                            NPCOp <= `PC4;
                            PCWr <= 1;
                            IRWr <= 1;
                            backsign <= 0;
                            RFWr <= 0;
                            DMWr <= 0;
                        end
                        else if(T2)
                        begin
                            PCWr <= 0;
    //                        IRWr <= 0;
                            EXTOp <= 1'b1;
                        end
                        else if(T3)
                        begin
                            ALUOp <= `ADD;
                            ZeroG <= 0;
                            BSel <= 1'b1;
                        end
                        else if(T4)
                        begin
                            WRSel <= 2'b00;
                            WDSel <= 2'b00;
                            RFWr <= 1;
                            IRWr <= 0;
                            backsign <= 1;
                        end
                    end
                    6'b001100:
                    begin
                        if(T1)
                        begin
                            backsign2 <= 0;
                            NPCOp <= `PC4;
                            PCWr <= 1;
                            IRWr <= 1;
                            backsign <= 0;
                            RFWr <= 0;
                            DMWr <= 0;
                        end
                        else if(T2)
                        begin
                            PCWr <= 0;
    //                        IRWr <= 0;
                            EXTOp <= 1'b0;
                        end
                        else if(T3)
                        begin
                            ALUOp <= `AND;
                            ZeroG <= 0;
                            BSel <= 1'b1;
                        end
                        else if(T4)
                        begin
                            WRSel <= 2'b00;
                            WDSel <= 2'b00;
                            RFWr <= 1;
                            IRWr <= 0;
                            backsign <= 1;
                        end
                    end
                    6'b001101:
                    begin
                        if(T1)
                        begin
                            backsign2 <= 0;
                            NPCOp <= `PC4;
                            PCWr <= 1;
                            IRWr <= 1;
                            backsign <= 0;
                            RFWr <= 0;
                            DMWr <= 0;
                        end
                        else if(T2)
                        begin
                            PCWr <= 0;
    //                        IRWr <= 0;
                            EXTOp <= 1'b0;
                        end
                        else if(T3)
                        begin
                            ALUOp <= `OR;
                            ZeroG <= 0;
                            BSel <= 1'b1;
                        end
                        else if(T4)
                        begin
                            WRSel <= 2'b00;
                            WDSel <= 2'b00;
                            RFWr <= 1;
                            backsign <= 1;
                            IRWr <= 0;
                        end
                    end
                    6'b001110:
                    begin
                        if(T1)
                        begin
                            backsign2 <= 0;
                            NPCOp <= `PC4;
                            PCWr <= 1;
                            IRWr <= 1;
                            backsign <= 0;
                            RFWr <= 0;
                            DMWr <= 0;
                        end
                        else if(T2)
                        begin
                            PCWr <= 0;
    //                        IRWr <= 0;
                            EXTOp <= 1'b0;
                        end
                        else if(T3)
                        begin
                            ALUOp <= `XOR;
                            ZeroG <= 0;
                            BSel <= 1'b1;
                        end
                        else if(T4)
                        begin
                            WRSel <= 2'b00;
                            WDSel <= 2'b00;
                            RFWr <= 1;
                            IRWr <= 0;
                            backsign <= 1;
                        end
                    end
                    6'b001011:
                    begin
                        if(T1)
                        begin
                            backsign2 <= 0;
                            NPCOp <= `PC4;
                            PCWr <= 1;
                            IRWr <= 1;
                            backsign <= 0;
                            RFWr <= 0;
                            DMWr <= 0;
                        end
                        else if(T2)
                        begin
                            PCWr <= 0;
    //                        IRWr <= 0;
                            EXTOp <= 1'b1;
                        end
                        else if(T3)
                        begin
                            ALUOp <= `SLTI;
                            ZeroG <= 0;
                            BSel <= 1'b1;
                        end
                        else if(T4)
                        begin
                            WRSel <= 2'b00;
                            WDSel <= 2'b00;
                            RFWr <= 1;
                            IRWr <= 0;
                            backsign <= 1;
                        end
                    end
                    6'b001111:
                    begin
                        if(T1)
                        begin
                            WRSel <= 2'b11;
                            WDSel <= 2'b11;
                            backsign2 <= 0;
                            NPCOp <= `PC4;
                            PCWr <= 1;
                            IRWr <= 1;
                            backsign <= 0;
                            RFWr <= 0;
                            DMWr <= 0;
                        end
                        else if(T2)
                        begin
                            PCWr <= 0;
    //                        IRWr <= 0;
                            EXTOp <= 1'b1;
                        end
                        else if(T3)
                        begin
                            ALUOp <= `LUI;
                            ZeroG <= 0;
                            BSel <= 1'b1;
                        end
                        else if(T4)
                        begin
                            WRSel <= 2'b00;
                            WDSel <= 2'b00;
                            RFWr <= 1;
                            IRWr <= 0;
                            backsign <= 1;
                        end
                    end
                    6'b100011:
                    begin
                        if(T1)
                        begin
                            backsign2 <= 0;
                            NPCOp <= `PC4;
                            PCWr <= 1;
                            IRWr <= 1;
                            backsign <= 0;
                            RFWr <= 0;
                            DMWr <= 0;
                        end
                        else if(T2)
                        begin
                            PCWr <= 0;
    //                        IRWr <= 0;
                            EXTOp <= 1'b1;
                        end
                        else if(T3)
                        begin
                            ALUOp <= `ADD;
                            ZeroG <= 0;
                            BSel <= 1'b1;
                        end
                        else if(T5)
                        begin
                            WRSel <= 2'b00;
                            WDSel <= 2'b01;
                            RFWr <= 1;
                            backsign <= 1;
                            IRWr <= 0;
                        end
                        else
                        begin
    //                        EXTOp_reg <= 1'b1;
    //                        NPCOp_reg <= `PC4;
    //                        RFWr_reg <= 1;
    //                        DMWr_reg <= 0;
    //                        WRSel_reg <= 2'b00;
    //                        WDSel_reg <= 2'b01;
    //                        BSel_reg <= 1'b1;
    //                        ZeroG_reg <= 0;
    //                        ALUOp_reg <= `ADD;
                       end
                    end
                    6'b101011:
                    begin
                        if(T1)
                        begin
                            backsign2 <= 0;
                            NPCOp <= `PC4;
                            PCWr <= 1;
                            IRWr <= 1;
                            backsign <= 0;
                            RFWr <= 0;
                            DMWr <= 0;
                        end
                        else if(T2)
                        begin
                            PCWr <= 0;
    //                        IRWr <= 0;
                            EXTOp <= 1'b1;
                        end
                        else if(T3)
                        begin
                            ALUOp <= `ADD;
                            ZeroG <= 0;
                            BSel <= 1'b1;
                        end
                        else if(T4)
                        begin
                            DMWr <= 1;
                            backsign <= 1;
                            IRWr <= 0;
                        end
    //                    EXTOp_reg <= 1'b1;
    //                    NPCOp_reg <= `PC4;
    //                    RFWr_reg <= 0;
    //                    DMWr_reg <= 1;
    //                    WRSel_reg <= 2'bxx;
    //                    WDSel_reg <= 2'bXX;
    //                    BSel_reg <= 1'b1;
    //                    ZeroG_reg <= 0;
    //                    ALUOp_reg <= `ADD;
                    end
                    6'b000100:
                    begin
                        if(T1)
                        begin
                            backsign2 <= 0;
                            NPCOp <= `PC4;
                            PCWr <= 1;
                            IRWr <= 1;
                            backsign <= 0;
                            RFWr <= 0;
                            DMWr <= 0;
                        end
                        else if(T2)
                        begin
                            PCWr <= 0;
    //                        IRWr <= 0;
                            EXTOp <= 1;
                            ALUOp <= `SUB;
                            ZeroG <= 1;
                            BSel <= 1'b0;
                        end
                        else if(T3)
                        begin
                            PCWr <= 1;
                            IRWr <= 0;
                            backsign <= 1;
                            IRWr <= 0;
    //                        PCWr <= 1;
                            if( Zero == 1)
                            begin
                                NPCOp <= 2'b01;
                            end
                            else
                            begin
                                NPCOp <= `PC4;
                            end
                        end
                    end
                    6'b000101:
                    begin
                        if(T1)
                        begin
                            backsign2 <= 0;
                            NPCOp <= `PC4;
                            PCWr <= 1;
                            IRWr <= 1;
                            backsign <= 0;
                            RFWr <= 0;
                            DMWr <= 0;
                        end
                        else if(T2)
                        begin
                            PCWr <= 0;
    //                        IRWr <= 0;
                            EXTOp <= 1;
                            ALUOp <= `SUB;
                            ZeroG <= 1;
                            BSel <= 1'b0;
                        end
                        else if(T3)
                        begin
                            backsign <= 1;
                            PCWr <= 1;
                            IRWr <= 0;
                            if( Zero == 0)
                            begin
                                NPCOp <= 2'b01;
                            end
                            else
                            begin
                                NPCOp <= `PC4;
                            end
                        end
    //                    EXTOp_reg <= 1'b1;
    //                    if( Zero == 0)
    //                    begin
    //                        NPCOp_reg <= 2'b01;
    //                    end
    //                    else
    //                    begin
    //                        NPCOp_reg <= `PC4;
    //                    end
                        
    //                    RFWr_reg <= 0;
    //                    DMWr_reg <= 0;
    //                    WRSel_reg <= 2'bXX;
    //                    WDSel_reg <= 2'bXX;
    //                    BSel_reg <= 1'b0;
    //                    ZeroG_reg <= 1;
    //                    ALUOp_reg <= `SUB;
                    end
                    6'b000111:
                    begin
                        if(T1)
                        begin
                            backsign2 <= 0;
                            NPCOp <= `PC4;
                            PCWr <= 1;
                            IRWr <= 1;
                            backsign <= 0;
                            RFWr <= 0;
                            DMWr <= 0;
                        end
                        else if(T2)
                        begin
                            PCWr <= 0;
    //                        IRWr <= 0;
                            EXTOp <= 1;
                            ALUOp <= `BGTZ;
                            ZeroG <= 1;
                            BSel <= 1'bX;
                        end
                        else if(T3)
                        begin
                            backsign <= 1;
                            IRWr <= 0;
                            PCWr <= 1;
                            if( Zero == 0)
                            begin
                                NPCOp <= 2'b01;
                            end
                            else
                            begin
                                NPCOp <= `PC4;
                            end
                        end
    //                    EXTOp_reg <= 1'b1;
    //                    if( Zero == 0 )
    //                    begin
    //                        NPCOp_reg <= 2'b01;
    //                    end
    //                    else
    //                    begin
    //                        NPCOp_reg <= `PC4;
    //                    end
    //                    RFWr_reg <= 0;
    //                    DMWr_reg <= 0;
    //                    WRSel_reg <= 2'bXX;
    //                    WDSel_reg <= 2'bXX;
    //                    BSel_reg <= 1'bX;
    //                    ZeroG_reg <= 1;
    //                    ALUOp_reg <= `BGTZ;
                    end
                    6'b000010:
                    begin
                        if(T1)
                        begin
                            backsign2 <= 0;
                            NPCOp <= `PC4;
                            PCWr <= 1;
                            IRWr <= 1;
                            backsign <= 0;
                            RFWr <= 0;
                            DMWr <= 0;
                        end
                       else if(T2)
                       begin
                            PCWr <= 1;
                            IRWr <= 0;
                            ALUOp <= `J;
                            NPCOp <= 2'b11;
                            backsign <= 1;
                       end
    //                    EXTOp_reg <= 1'bX;
    //                    NPCOp_reg <= 2'b11;
    //                    RFWr_reg <= 0;
    //                    DMWr_reg <= 0;
    //                    WRSel_reg <= 2'bxx;
    //                    WDSel_reg <= 2'bXX;
    //                    BSel_reg <= 1'bX;
    //                    ZeroG_reg <= 0;
    //                    ALUOp_reg <= `J;  
                    end
                    6'b000011:
                    begin
                        if(T1)
                        begin
                            backsign2 <= 0;
                            NPCOp <= `PC4;
                            PCWr <= 1;
                            IRWr <= 1;
                            backsign <= 0;
                            RFWr <= 0;
                            DMWr <= 0;
                        end
                        if(T2)
                        begin
                            RFWr <= 1;
                            IRWr <= 0;
                            PCWr <= 1;
                            WRSel <= 2'b10;
                            WDSel <= 2'b10;
                            ALUOp <= `JAL;
                            NPCOp <= 2'b11;
                            ZeroG <= 0;
                            backsign <= 1;
                        end
                       
    //                    EXTOp_reg <= 1'bX;
    //                    NPCOp_reg <= 2'b11;
    //                    RFWr_reg <= 1;
    //                    DMWr_reg <= 0;
    //                    WRSel_reg <= 2'b10;
    //                    WDSel_reg <= 2'b10;
    //                    BSel_reg <= 1'bX;
    //                    ZeroG_reg <= 0;
    //                    ALUOp_reg <= `JAL;
                    end    
                endcase
            end
        end
endmodule
