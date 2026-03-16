`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 10.03.2026 21:35:14
// Design Name: 
// Module Name: main
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


module main(clk);
    input clk;
    wire branch_taken;
    
    //pc.v
    wire [7:0] PC, NPC;
    
    //instruction_mem.v plus decoding
    wire [15:0] IR;
    wire [3:0] opcode;
    wire [2:0] rs,rt,rd;
    wire [2:0] immediate;
    wire [15:0] imm_extend;
    
    //register_file.v
    wire [2:0] read_addr1, read_addr2, write_addr;
    wire [15:0] read_data1, read_data2, write_data;
    
    //alu.v
    wire [15:0] A,B,ALUout;
    wire Z,C,V,N;
    
    //data_memory.v
    wire [7:0] data_addr;
    wire [15:0] data_in, data_out;
    wire mem_read,mem_write;
    
    //control_unit.v
    wire ALUsrc1,ALUsrc2,reg_write,reg_dst,mem_to_reg,branch,halt;
    
    
    //decoding instruction
    assign opcode = IR[15:12];
    assign rs = IR[11:9];
    assign rt = IR[8:6];
    assign rd = IR[5:3];
    assign immediate = IR[2:0];
    
    //assign imm_extend = {{13{immediate[2]}},immediate}; //sign extension
    
    assign data_in = read_data2;
    assign data_addr = ALUout[7:0];
    
    //declaring multiplexers
    assign branch_taken = branch && (read_data1 == 16'b0);
    assign NPC = branch_taken ? PC+imm_extend[7:0] : PC+1; //mux 1
    
    assign A = (ALUsrc1)? NPC:read_data1; //mux 2
    assign B = (ALUsrc2)? imm_extend:read_data2; //mux 3
    
    assign write_addr = (reg_dst) ? rt:rd; //mux 4
    assign write_data = (mem_to_reg) ? data_out:ALUout; //mux 5
    
    
    //inputs are clk and npc, outputs pc
    pc PC0(.clk(clk),.NPC(NPC),.PC(PC),.halt(halt));
    
    //inputs are pc, outputs ir
    instruction_mem IM(.PC(PC),.IR(IR));
    
    //inputs are IR, outputs sign-extended immediate
    IR_decoded IRD(.IR(IR),.imm_extend(imm_extend));
    
    //inputs opcode, output all control signals
    control_unit CU(.opcode(opcode),.ALUsrc1(ALUsrc1),.ALUsrc2(ALUsrc2),.reg_write(reg_write),.reg_dst(reg_dst),.mem_read(mem_read),.mem_write(mem_write),.mem_to_reg(mem_to_reg),.branch(branch),.halt(halt));
    
    //inputs clk, write_enable, write addr and write data, read addresses and outputs read data
    register_file RF(.clk(clk),.write_enable(reg_write),.read_addr1(rs),.read_addr2(rt),.read_data1(read_data1),.read_data2(read_data2),.write_addr(write_addr),.write_data(write_data));
    
    //inputs A and B along with opcode, outputs ALUout along with 4 flags
    alu ALU0(.A(A),.B(B),.opcode(opcode),.result(ALUout),.Z(Z),.C(C),.N(N),.V(V));
    
    //inputs are clk, data_addr, mem_read, mem_write, data_in, outputs data_out
    data_memory DM(.clk(clk),.data_addr(data_addr),.data_in(data_in),.data_out(data_out),.mem_read(mem_read),.mem_write(mem_write));
    
endmodule
