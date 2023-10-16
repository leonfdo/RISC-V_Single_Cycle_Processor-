`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 09/22/2023 05:43:05 AM
// Design Name: 
// Module Name: Imm_gen_tb
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


module Imm_gen_tb();
logic [31:0]instruction;
logic signed [31:0]Imm_out;

Imm_gen dut(.instruction(instruction),.Imm_out(Imm_out));
initial begin
    instruction=32'b000000000001_00001_111_00001_0010011;
    #10;
    $display("the Imm_out is, %b ",Imm_out);
end
endmodule
