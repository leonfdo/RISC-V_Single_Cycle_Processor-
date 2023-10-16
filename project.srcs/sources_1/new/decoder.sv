`timescale 1ns / 1ps


module decoder(
    input logic [31:0]instruction,
    output logic [4:0]sig_rs1,
    output logic [4:0]sig_rs2,
    output logic [4:0]sig_rd,
    output logic [2:0]func3,
    output logic [6:0]func7,
    output logic [6:0]opcode
    );
    
      
    always_comb begin
        opcode=instruction[6:0];
        sig_rd=instruction[11:7];
        func3=instruction[14:12];
        sig_rs1=instruction[19:15];
        sig_rs2=instruction[24:20]; 
        func7=instruction[31:25];  
          
    end


endmodule