`timescale 1ns / 1ps
//`define T1 3'b001
//`define T2 3'b010
//`define T3 3'b011
//`define T4 3'b100
//`define T5 3'b101
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2020/06/22 09:49:37
// Design Name: 
// Module Name: Period_record
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


module Period_record(
    input clock,
    output reg [5:0] Pero,
    input reset
    );
    
    always@(posedge clock)
    begin
        if(reset==1)
            Pero <= 5'b0;
        else
        begin
            if( Pero == 5'b0)
            begin
                Pero <= 5'b00001;
            end
            else if(Pero == 5'b00001)
            begin
                Pero <= 5'b00010;
            end
            else if(Pero == 5'b00010)
            begin
                Pero <= 5'b00100;
            end
            else if(Pero == 5'b00100)
            begin
                Pero <= 5'b01000;
            end
            else if(Pero == 5'b01000)
            begin
                Pero <= 5'b10000;
            end
            else if(Pero == 5'b10000)
            begin
                Pero <= 5'b000;
            end
        end
    end
endmodule












