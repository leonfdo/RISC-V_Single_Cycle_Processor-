`timescale 1ns / 1ps

module Datapath_test();

localparam width=32;
localparam pc_width=5;

//logic [pc_width-1:0]pc_in;
logic clk=1'b0;
logic rst;
logic [31:0]ALU_result;



always #10 clk=~clk;

Datapath dut(
    .clk(clk),
    .rst(rst),
    .ALU_result(ALU_result)
);

initial begin
    rst=0;
    
    #15;
   
    rst=1;
    #20;
    

    #20;
    

    #20;

    #20;

    #20;

    
   #20;

    
   #20;
   #20;
   #960;
    
    $finish;    
end

endmodule
