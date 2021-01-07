`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2020/06/22 09:46:27
// Design Name: 
// Module Name: IR_reg
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


module IR_reg(
    input clock,
    input IRWr,
    input [31:0] ins_in,
    output reg [31:0] ins_out
    );
    
    always@(posedge clock)
    begin
        if(IRWr==1)
        begin
            ins_out <= ins_in ; 
        end
        else
        begin
            ins_out <= ins_out ; 
        end
    end
    
endmodule
