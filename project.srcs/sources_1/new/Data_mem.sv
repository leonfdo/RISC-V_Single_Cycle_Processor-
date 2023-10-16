`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 10/06/2023 08:27:58 PM
// Design Name: 
// Module Name: Data_mem
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


module Data_mem#(width=32, addr_space=5)(
    input logic clk,
    input logic [width-1:0]data_addr,
    input logic signed [width-1:0] data_in,
    input logic memwrt,
    input logic memread,
    input logic [2:0]space_sig,
    output logic signed [width-1:0] data_out
);

logic signed [width-1:0]data[((2**addr_space)-1):0];
//assign data[0]=32'b10000000_00000001_10000001_10000011;





always_comb begin
    if(memread) begin
        unique case(space_sig)
            //lb (000)
            3'b000: data_out<={data[data_addr][7]? {24{1'b1}}:24'b0,data[data_addr][7:0]};
            //lbu (100)
            3'b100: data_out<={24'b0,data[data_addr][7:0]};
            //lh (001)
            3'b001: data_out<={data[data_addr][15]? {16{1'b1}}:16'b0,data[data_addr][15:0]};
            //lhu (101)
            3'b101: data_out<={16'b0,data[data_addr][15:0]};
            //lw  (010)
            3'b010: data_out<=data[data_addr];
        endcase
    end
end

always_ff @(posedge clk) begin
    if(memwrt)begin
        unique case(space_sig) 
            3'b000:data[data_addr]<={24'b0,data_in[7:0]};
            3'b001:data[data_addr]<={16'b0,data_in[15:0]};
            3'b010:data[data_addr]<=data_in[31:0];
        endcase
    end
end


endmodule
