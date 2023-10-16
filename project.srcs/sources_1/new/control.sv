`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 09/26/2023 06:10:21 PM
// Design Name: 
// Module Name: control
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


module control(
    input logic [31:0]instruction,
    output logic [4:0]sig_rs1,
    output logic [4:0]sig_rs2,
    output logic [4:0]sig_rd,
    output logic [2:0]fun3,
    output logic [6:0]fun7,
    output logic [6:0]opcode
    );
    
    assign opcode=instruction[6:0];
    
    always_comb begin
    unique case(opcode[6:2])
    (7'b01100 || 7'b00100):begin
        sig_rd=instruction[11:7];
        fun3=instruction[14:12];
        sig_rs1=instruction[19:15];
        if(opcode[6:4]==001) sig_rs2=instruction[24:20];
    end
    endcase
    
    
    end
    
    
    
    
    
    
    
endmodule
