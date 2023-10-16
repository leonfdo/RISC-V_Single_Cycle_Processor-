`timescale 1ns / 1ps

module ALU_tb();
localparam width=32;
localparam op_bits=4;

logic signed [width-1:0] reg1,reg2,out;
logic zero_bit,neg_bit;
logic unsigned [op_bits-1:0]operation;

ALU dut(
    .reg1(reg1),
    .reg2(reg2),
    .out(out),
    .operation(operation),
    .zero_bit(zero_bit),
    .neg_bit(neg_bit)
);

initial 
begin
   // testing add
   #10;
   reg1=10;
   reg2=5;
   operation='b0000;
   #10;
   //testing sub
   reg1=10;
   reg2=4;
   operation='b0001;
   #10;
   
   //testing the zero_bit
   reg1=20;
   reg2=20;
   operation='b0001;
   #10;
   
   //testing and operation
   reg1='b0001_1111;
   reg2='b0000_1010;
   operation='b0010;
   #10;
   
   //testing or operation
   reg1='b0001_1111;
   reg2='b0000_1010;
   operation='b0011;
   #10;
   
   //testing xor operation
   reg1='b0001_1111;
   reg2='b0000_1010;
   operation='b0100;
   #10;
   
   //teting sll operation
   reg1='d3;
   reg2='d2;
   operation='b0101;
   #10;
   
   //teting srl operation
   reg1='d16;
   reg2='d2;
   operation='b0110;
   #10;
   
   //teting sra operation
   reg1=32;
   reg2=4;
   operation='b0111;
   #10;
   
   //teting sra operation
   reg1=-32;
   reg2=2;
   operation='b0111;
   #10;
   
   //teting slt operation
   reg1=1;
   reg2=4;
   operation='b1000;
   #10;
   
   
  $display("leon");
  $finish;
end

endmodule
