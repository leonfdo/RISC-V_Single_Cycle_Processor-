`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 10/08/2023 10:47:45 PM
// Design Name: 
// Module Name: controller_tst
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
module controller_tst();

logic [31:0]instruction;
logic wrten,memread,memwrt,alu2mem_sig,mux_rs2imm,branch;
logic [3:0]operation;
logic [2:0]space_sig;
logic [1:0]branch_type;


Control_unit Control_unit_blk(
    .instruction(instruction),
    .wrten(wrten),
    .memread(memread),
    .alu2mem_sig(alu2mem_sig),
    .mux_rs2imm(mux_rs2imm),
    .branch(branch),
    .operation(operation),
    .space_sig(space_sig),
    .branch_type(branch_type),
    .memwrt(memwrt)
);

initial begin
instruction=32'b0000000_00000_01000_000_00010_1100011;
#10;

end

endmodule