`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 10.03.2026 13:55:05
// Design Name: 
// Module Name: instruction_mem
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


module instruction_mem(PC,IR); 
    input [7:0] PC; 
    output reg [15:0] IR;
    reg [15:0] instruction_memory [255:0];
    
    integer i;
    
    initial begin 
        for(i = 0;i < 256;i = i+1)
            instruction_memory[i] = 16'h0000;
            
        $display("Loading program memory . . .");
        $readmemh("program.mem", instruction_memory);
    end
    
    always@(*) begin
        IR = instruction_memory[PC];
    end
endmodule
