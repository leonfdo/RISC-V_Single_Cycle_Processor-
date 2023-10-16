`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 09/22/2023 11:10:40 AM
// Design Name: 
// Module Name: root_tb
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


module root_tb();

  localparam inst_width = 32;
  localparam inst_space = 2;
  localparam addr_width = 5;
  localparam width = 32;
  localparam op_bits=4;

  logic [inst_space-1:0] pc;
  logic [inst_width-1:0] instruction;
  logic clk;
  logic rst;
  logic wrt_en;
  //logic [addr_width-1:0] wrt_addr;
  //logic signed [width-1:0] wrt_data;
  logic signed [width-1:0] reg1_val;
  logic signed [width-1:0] reg2_val;
  
  logic signed [31:0]Imm_out;
  
  logic signed [width-1:0] out;
  logic zero_bit,neg_bit;
  logic unsigned [op_bits-1:0]operation;


  // Instantiate the ClockGenerator module
  ClockGenerator #(10) clk_gen (.clk(clk));

  // Instantiate the Instruction_mem module
  Instruction_mem dut (
    .pc(pc),
    .instruction(instruction)
  );

  // Instantiate the reg_array module
  reg_array dut_reg_array (
    .clk(clk_gen.clk), // Use the clk signal from the ClockGenerator module
    .rst(rst),
    .wrt_en(wrt_en),
    .reg1_addr(instruction[19:15]), // Verify that these are valid register addresses
    .reg2_addr(instruction[4:0]), // Verify that these are valid register addresses
    .wrt_addr(instruction[11:7]),
    .wrt_data(out),
    .reg1_val(reg1_val),
    .reg2_val(reg2_val)
  );
  
 Imm_gen dut_imm_gen (
    .instruction(instruction),
    .Imm_out(Imm_out)
  );
  
  
  ALU ALU_dut(
    .reg1(reg1_val),
    .reg2(Imm_out),
    .out(out),
    .operation(operation),
    .zero_bit(zero_bit),
    .neg_bit(neg_bit)
);
 
initial begin
rst = 0;
#10;
rst=1;
wrt_en = 1;
operation=0;
#10;

pc=0;

#10;

end 

  // Add your test sequence here to initialize and control signals

endmodule

