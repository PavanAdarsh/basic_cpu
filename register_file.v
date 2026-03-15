`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 10.03.2026 15:53:48
// Design Name: 
// Module Name: register_file
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


module register_file(clk,write_enable,read_addr1,read_addr2,read_data1,read_data2,write_addr,write_data);
    input clk, write_enable;
    input [2:0] read_addr1,read_addr2,write_addr; //3 bits to access 8 registers
    input [15:0] write_data;
    reg [15:0] register_file [7:0]; //8 registers of 16 bits each
    output reg [15:0] read_data1,read_data2;
    
    integer i;

    initial begin
        for (i=0;i<8;i=i+1)
            register_file[i] = 16'h0000;
    end
    
    always@(posedge clk) begin
        if(write_enable && write_addr) register_file[write_addr] <= write_data; //ignore writes to r0
    end
    
    always@(*) begin //reading register r0 gives 0
        read_data1 = (read_addr1) ? register_file[read_addr1] : 16'b0;
        read_data2 = (read_addr2) ? register_file[read_addr2] : 16'b0;
    end
    
endmodule
