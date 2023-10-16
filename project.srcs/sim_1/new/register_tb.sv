`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 09/22/2023 10:11:12 AM
// Design Name: 
// Module Name: register_tb
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

module register_tb();

  localparam addr_width = 5;
  localparam width = 32;

  logic rst;
  logic wrt_en;
  logic [addr_width-1:0] reg1_addr;
  logic [addr_width-1:0] reg2_addr;
  logic [addr_width-1:0] wrt_addr;
  logic signed [width-1:0] wrt_data;
  logic signed [width-1:0] reg1_val;
  logic signed [width-1:0] reg2_val;



  // Instantiate the ClockGenerator module
  ClockGenerator #(10) clk_gen (.clk(clk));

  // Instantiate the reg_array module, using clk from the ClockGenerator
  reg_array dut (
    .clk(clk_gen.clk), // Use the clk signal from the ClockGenerator module
    .rst(rst),
    .wrt_en(wrt_en),
    .reg1_addr(reg1_addr),
    .reg2_addr(reg2_addr),
    .wrt_addr(wrt_addr),
    .wrt_data(wrt_data),
    .reg1_val(reg1_val),
    .reg2_val(reg2_val)
  );

  initial begin
    rst=0;
    #15;
    rst=1;
    #25
    wrt_en = 1;
    wrt_addr = 5; // Write to reg1
    wrt_data = 32'h00000001; // Write 1 to reg1
    #20;
    wrt_en=0;
    #20;
    wrt_en=1;
    wrt_addr=10;
    wrt_data=10;
    #20;
    $finish;
  end

endmodule