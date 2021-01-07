`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2020/06/22 13:47:35
// Design Name: 
// Module Name: EXT_4_NPC
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


module EXT_4_NPC(
    input [15:0] IMM,
    input EXTOp,
    output [31:0] IMM_EX
    );
    reg [31:0] imm;
    
    assign IMM_EX = imm;
    always@(*)
    begin
        case(EXTOp)
        0: imm <= {16'b0,IMM};
        1: begin
            if( IMM[15] == 0 )
                imm <= {16'b0,IMM};
            else
                imm <={16'b1111111111111111,IMM};
           end
        default:  imm <= 32'b0;
        endcase
    end
endmodule
