`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 10/08/2023 10:11:49 AM
// Design Name: 
// Module Name: Control_unit
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


module Control_unit(
    input logic [31:0]instruction,
    output logic wrten,
    output logic jump,
    output logic [3:0]operation,
    output logic mux_rs2imm,
    output logic memread,
    output logic memwrt,
    output logic alu2mem_sig,
    output logic [2:0]space_sig,
    output logic branch,
    output logic [1:0]branch_type
);

//logic [6:0]opcode;
logic [2:0]func3;
logic func7;

//assign opcode=instruction[6:0];
assign func3=instruction[14:12];
assign func7=instruction[30];

//logic [6:0] R, LW, SW, RTypeI, BR, JALR, JAL,AUIPC,LUI;
localparam  B = 7'b1100011;
localparam  R = 7'b0110011;
localparam  Load = 7'b0000011;
localparam  Store = 7'b0100011;
localparam  I = 7'b0010011; 
localparam  JALR = 7'b1100111;
localparam mul = 7'b0101011;
//localparam memcpy=7'


assign wrten=((instruction[6:0]==R) || (instruction[6:0]==Load)||(instruction[6:0]==I)||(instruction[6:0]==JALR)||(instruction[6:0]==mul));
assign memread=((instruction[6:0]==Load));
assign memwrt =((instruction[6:0]==Store));
assign branch=(instruction[6:0]==B);
assign mux_rs2imm=((instruction[6:0]==I) || (instruction[6:0]==Load) || (instruction[6:0]==Store)||(instruction[6:0]==JALR));
assign alu2mem_sig = (instruction[6:0]==Load);
assign jump=(instruction[6:0]==JALR);

always_comb begin
    if(instruction[6:0]==B )begin
        operation<=4'b0001;
        unique case(func3)
           3'b000: branch_type<=2'b00; //beq
           3'b001: branch_type<=2'b01; //bne
           3'b100: begin //blt
                branch_type<=2'b10;
                operation<=4'b1000;
           end
           3'b110:begin //bltu
                branch_type<=2'b10;
                operation<=4'b1001;
           end
           3'b101:begin //bgt
                branch_type<=2'b11;
                operation<=4'b1000;
            end
            3'b111:begin //bgtu
                branch_type<=2'b11;
                operation<=4'b1001;
            end
        endcase
    end
end



always_comb begin
if(instruction[6:0]==Load || instruction[6:0]==Store)begin
        operation<=4'b0000;
         unique case(func3)
            3'b000: space_sig<=3'b000; //lb,sb
            3'b100: space_sig<=3'b100; //lbu
            3'b001: space_sig<=3'b001; //lh,sh
            3'b101: space_sig<=3'b101; //lhu
            3'b010: space_sig<=3'b010; //lw,sw
         endcase
     end
end

always_comb begin
    if(instruction[6:0]==R || instruction[6:0]==I||instruction[6:0]==JALR)begin
            unique case(func3)
                3'b000: begin   
                            if(instruction[6:0]==R) operation<=(func7)?4'b0001:4'b0;
                            else operation<=4'b0; 
                        end
                3'b001: operation<=4'b0101;
                3'b010: operation<=4'b1000;
                3'b011: operation<=4'b1001;
                3'b100: operation<=4'b0100;
                3'b101: operation<=(func7)?4'b0110:4'b0111;
                3'b110: operation<=4'b0011;
                3'b111: operation<=4'b0010;
            endcase
    end
end

always_comb begin
    if(instruction[6:0]==mul) operation<=4'b1010;
end

endmodule
