`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 10/11/2023 01:01:50 AM
// Design Name: 
// Module Name: Memcpy
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


module Memcpy #(parameter DATA_WIDTH = 32) (
    input clk,
    input logic [4:0] start_addr,
    input logic [4:0] destination_addr, 
    input logic unsigned [11:0] size,
    input logic memcop,
    output logic [31:0]mem_inst,
    output logic state=1'b0
);

localparam idle=1'b0;
localparam copying=1'b1;

//logic [31:0]Mem_rom[1:0];
logic [4:0]in1,in2;
logic [11:0]s;
logic [2:0]signal=3'b000;
logic [11:0]i;
//assign Mem_rom[0]={12'b0000000_00000,start_idx,3'b010,5'b0,7'b0000011};
//assign Mem_rom[1]={12'b0000000_00000,start_idx,3'b010,5'b0,7'b0000011};

//assign sig=2'b00;
always_ff @(posedge clk) begin
  if(memcop==1) begin
    if(signal==3'b000) begin
        i='b0;
        state=copying;
        in1=start_addr;
        in2=destination_addr;
        s=size;   
        signal=2'b001;  
    end
    end
    case(signal)
        3'b001: begin
            mem_inst={12'b0+i[11:0],in1,3'b010,5'b11111,7'b0000011};
            signal=3'b010;
        end
        3'b010: begin
            mem_inst={7'b0+i[11:5],5'b11111,in2,3'b010,5'b0+i[4:0],7'b0100011};
            i=i+1;
            if(i<s) begin
                signal=3'b001;
            end
            else begin
                signal=3'b100;
                
            end
        end
        3'b100: begin
        state<=0;
        end  
    endcase

end


endmodule



