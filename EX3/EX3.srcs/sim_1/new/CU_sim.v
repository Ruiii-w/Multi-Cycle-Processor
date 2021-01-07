`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2020/06/22 14:05:58
// Design Name: 
// Module Name: CU_sim
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


module CU_sim(

    );
    
    wire reset;
    wire clock;
    wire [5:0]op;
    wire [5:0]func;
    wire Zero;
    

    reg [1:0] NPCOp;
    reg PCWr;
    reg IRWr;
    reg RFWr;
    reg[4:0] ALUOp;
    reg DMWr;
    reg [1:0] WRSel;
    reg [1:0] WDSel;
    reg BSel;
    reg ZeroG;
    reg EXTOp;
endmodule
