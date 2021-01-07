`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2020/06/05 15:14:24
// Design Name: 
// Module Name: PC
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


module PC(
    input clk,
    input reset,
    input [31:0] DI,
    input PCWr,
    output [31:0] DO
    );
    reg [31:0] D =32'b0;
    assign DO = D;
    
    always@(posedge clk)
    begin
        if(!reset && PCWr )
            begin
                D <= DI;
            end
        else
            D <= D;
            
    end
endmodule
