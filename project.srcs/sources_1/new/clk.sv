`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 09/22/2023 10:45:46 AM
// Design Name: 
// Module Name: clk
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


module ClockGenerator#(parameter half_period = 5)(
  output reg clk = 0 // Clock output // Half clock period in time units (adjust as needed)
);
  
  always begin
    #half_period; // Half clock period delay
    clk <= ~clk; // Invert the clock signal
  end
  
endmodule