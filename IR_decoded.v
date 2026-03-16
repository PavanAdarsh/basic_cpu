`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 15.03.2026 16:44:55
// Design Name: 
// Module Name: IR_decoded
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


module IR_decoded(IR,imm_extend);
    input [15:0] IR;
    output reg [15:0] imm_extend;
    
    always@(*) begin
        case(IR[15:12])
            4'd0,4'd2,4'd4,4'd5: imm_extend = {{13{IR[2]}},IR[2:0]}; //ADD SUB NAND NOR
            4'd1,4'd6,4'd7,4'd10,4'd11: imm_extend = {{10{IR[5]}},IR[5:0]}; //ADDI LOAD STORE SHIFTS
            4'd8: imm_extend = {{7{IR[8]}},IR[8:0]}; //BEQZ
            4'd9: imm_extend = {{3{IR[11]}},IR[11:0]}; //JMP
            default: imm_extend = {{13{IR[2]}},IR[2:0]};
        endcase
    end

endmodule
