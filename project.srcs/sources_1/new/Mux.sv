`timescale 1ns / 1ps

module Mux#(parameter width=32)(
    input logic signed [width-1:0]input_1,input_2,
    input logic sig,
    output logic signed [width-1:0]mux_out
);

always_comb begin
    unique case(sig) 
        1'b0:mux_out<=input_1;
        1'b1:mux_out<=input_2;
    endcase
end
endmodule
