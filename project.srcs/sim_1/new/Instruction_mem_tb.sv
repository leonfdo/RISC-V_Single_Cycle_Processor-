`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 09/22/2023 03:55:56 AM
// Design Name: 
// Module Name: Instruction_mem_tb
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


module Instruction_mem_tb();
localparam inst_width=32;
localparam inst_space=2;


logic [inst_space-1:0] pc;
logic [inst_width-1:0]instruction;

Instruction_mem dut(.pc(pc),.instruction(instruction));

initial begin
    pc='b0;
    #10;
    $display("Fetched instruction: %b",instruction);;
    #10;
    $finish;
end
endmodule
