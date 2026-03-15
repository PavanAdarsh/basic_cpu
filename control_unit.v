`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 10.03.2026 19:03:14
// Design Name: 
// Module Name: control_unit
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


module control_unit(opcode,ALUsrc1,ALUsrc2,reg_write,reg_dst,mem_read,mem_write,mem_to_reg,branch,halt);
    
    input [3:0] opcode;
    output reg ALUsrc1, ALUsrc2; //0 for register, 1 for immediate/program counter value
    output reg reg_write; //1 for writing into register file, 0 if not
    output reg mem_read, mem_write;
    output reg branch, halt;
    output reg reg_dst; //0 for r type, 1 for i type 
    output reg mem_to_reg; //1 for writing memory value into register file, instead of ALU op
    
    always@(*) begin
        ALUsrc1 = 0; ALUsrc2 = 0; reg_write = 0; mem_to_reg = 0;
        mem_read = 0; mem_write = 0; branch = 0; halt = 0; reg_dst = 0;
        case(opcode)
            4'd0,4'd2,4'd4,4'd5: begin //add sub nand nor
                    reg_write = 1;
                    end
            4'd1,4'd10,4'd11: begin //add immediate, shift left and right
                    reg_write = 1;
                    ALUsrc2 = 1;
                    reg_dst = 1;
                    end
            4'd6: begin //loading data from data memory into register file
                    reg_write = 1;
                    mem_read = 1;
                    mem_to_reg = 1;
                    reg_dst = 1;
                    ALUsrc2 = 1;
                    end
            4'd7: begin //storing data into the data memory
                    mem_write = 1;
                    reg_dst = 1;
                    ALUsrc2 = 1;
                    end
            4'd8: branch = 1;
            4'd15: halt = 1;
        endcase
    end
endmodule
