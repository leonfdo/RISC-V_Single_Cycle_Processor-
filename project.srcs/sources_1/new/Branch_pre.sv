`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 10/08/2023 12:15:58 PM
// Design Name: 
// Module Name: Branch_pre
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


module Branch_pre(
input logic is_zero,branch,
input logic out_last_bit,
input logic [1:0]branch_type,
output logic mux_pc2branch
);

always_comb begin
    unique case(branch_type)
        2'b00: mux_pc2branch<=((branch & is_zero)); //beq , jalr
        2'b01: mux_pc2branch<=(branch & (!is_zero)); //bne
        2'b10: mux_pc2branch<=(branch & (out_last_bit)); //blt , bltu
        2'b11: mux_pc2branch<=(branch & !(out_last_bit)); //bgt,bgtu   
        default: mux_pc2branch<='b0; 
    endcase
end


endmodule
