`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 10.03.2026 13:53:15
// Design Name: 
// Module Name: pc
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


module pc(clk,NPC,PC,halt);
    input clk,halt;
    input [7:0] NPC;
    output reg [7:0] PC;
    
    initial begin 
        PC = 0; 
        end
    
    always@(posedge clk) begin
        if(halt)
            PC <= PC;
        else 
            PC <= NPC;
    end

endmodule
