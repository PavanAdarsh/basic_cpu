`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 10.03.2026 15:38:09
// Design Name: 
// Module Name: data_memory
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


module data_memory(clk,data_addr,data_in,data_out,mem_read,mem_write);
    input [7:0] data_addr;
    input mem_read,mem_write,clk;
    input [15:0] data_in;
    reg [15:0] data_memory [255:0];
    output reg [15:0] data_out;
    
    always@(posedge clk) begin
        if(mem_write) data_memory[data_addr] <= data_in; //write has priority
    end
    always@(*) begin
        data_out = (mem_read) ? data_memory[data_addr] : 16'b0;
    end
    

endmodule
