`timescale 1ns / 1ps

module pc_testbench();

  localparam pc_width = 32;
  logic clk = 0;   // Initialize clk and rst
  logic rst = 0;
  logic [pc_width-1:0] pc_in, pc_out;

  always #5 clk = ~clk;  // Toggle the clock every 5 time units

  program_count dut (
    .pc_in(pc_in),
    .pc_out(pc_out),
    .clk(clk),
    .rst(rst)
  );

  initial begin
    rst = 0;  // Assert reset initially
    #10;
    rst = 1;  // Deassert reset
    #5;
    pc_in = 32'b1;
    #10;
    pc_in = 32'b1010;
    #15;
    pc_in = 32'b11111111111;
    #20;     // Run the simulation for a sufficient duration
    $finish; // Finish the simulation
  end

endmodule

