`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2020/06/22 13:24:34
// Design Name: 
// Module Name: AR_reg
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


module AR_reg(
    input clock,
    input [31:0] ALU_C,
    output reg [31:0] AR
    );
    
    always@(posedge clock)
    begin
        AR = ALU_C;
    end
    
endmodule
