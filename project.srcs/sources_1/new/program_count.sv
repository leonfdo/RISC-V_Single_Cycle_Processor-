`timescale 1ns / 1ps

module program_count #(parameter pc_width = 32)(
  input logic rst,
  input logic clk,
  input logic [pc_width-1:0] pc_in,
  output logic [pc_width-1:0] pc_out
);

  logic [pc_width-1:0] program_counter;

  always_ff @(posedge clk) begin
    if (!rst) begin
      program_counter <= 'b0;
    end else begin
      program_counter <= pc_in;
    end
  end

  assign pc_out = program_counter;

endmodule

