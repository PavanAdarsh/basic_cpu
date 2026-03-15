`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 10.03.2026 13:15:53
// Design Name: 
// Module Name: alu
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


module alu(A,B,opcode,result,Z,C,N,V);
input [15:0] A,B;
input [3:0] opcode;
output reg [15:0] result;
output Z,N;
output reg C,V;

always@(*) begin
    result = 0;
    C = 0;
    V = 0;
    case(opcode)
        4'd0,4'd1,4'd6,4'd7: begin 
             {C,result} = A + B; 
             V = ((A[15]==B[15])&&(result[15]!=A[15])); //overflow occurs when result bit is different from A and B even when A and B are of same sign
            end
        4'd2: begin result = A-B; 
           V = ((A[15]==B[15])&&(result[15]!=A[15]));
           end
        //3: result = A*B; //multiplication, not implemented for the time being
        4'd4: result = ~(A&B); //NAND
        4'd5: result = ~(A|B); //NOR
        4'd10: result = A << B; //shift left
        4'd11: result = A >> B; //shift right
        default: result = 0; //for all other opcodes
    endcase
end

assign Z = (result == 16'b0);
assign N = result[15];

endmodule
