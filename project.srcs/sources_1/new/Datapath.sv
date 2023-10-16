`timescale 1ns / 1ps

module Datapath#(parameter width=32,pc_width=32)(
    input logic clk,rst,
    output logic [31:0]ALU_result   
);


//three buses
logic signed [width-1:0]bus_A,bus_B,bus_C;

//wires in between the modules
logic [pc_width-1:0]pc_out;
logic [31:0]memcp_inst;
logic [width-1:0]instruction;
logic signed [width-1:0]reg1_val,reg2_val,ALU_out;
logic zero_bit;
logic [31:0]Imm_out;
logic [31:0]rs2imm_mux_out;
logic signed [31:0]memdata;
logic signed [31:0]alu2mux_data;
logic [31:0]br_imm_out;
logic signed[31:0]pc_next;
logic signed [31:0]pc_final;
logic mux_pc2branch;
logic signed [1:0] branch_type;
logic wrt_en;
logic[3:0]operation;
logic mux_rs2imm;
logic memread,memwrt;
logic alu2mem_sig;
logic [2:0]space_sig;
logic branch;
logic jump;
logic [31:0]final_data;
logic [31:0]pc_last;
logic state;
logic [31:0]final_inst,pc_memcp;
logic memcop;

//program counter (clk,rst)
program_count program_count_blk (
    .rst(rst),
    .clk(clk),
    .pc_in(pc_last),
    .pc_out(pc_out)
);

//Pc+1 next pc  
Adder Adder_blk_pc(
    .add_input1(pc_out),
    .add_input2(32'd4),
    .out(pc_next)
);

//Branch instruction adder
Adder Adder_blk_branch(
    .add_input1(pc_out),
    .add_input2(Imm_out),
    .out(br_imm_out)
);


//checking whether branch condition satisfied
Branch_pre Branch_pre_blk(
    .is_zero(zero_bit),
    .branch(branch),
    .out_last_bit(ALU_out[0]),
    .branch_type(branch_type),
    .mux_pc2branch(mux_pc2branch)
);

//to selec between branch and pc (branch)
Mux Mux_blk_3(
    .input_1(pc_next),
    .input_2(br_imm_out),
    .mux_out(pc_final), 
    .sig(mux_pc2branch)
);

//to select jump
Mux Mux_blk_jmp(
    .input_1(pc_final),
    .input_2(ALU_out),
    .mux_out(pc_memcp),
    .sig(jump)
);


Mux Mux_blk_memcp(
    .input_1(pc_memcp),
    .input_2(pc_out),
    .mux_out(pc_last),
    .sig(state)
);

//instruction memory
Instruction_mem Instruction_mem_blk(
    .pc(pc_out),
    .instruction(instruction)
);

//use this mux when using the memcpy
Mux mux_memcpy(
    .input_1(instruction),
    .input_2(memcp_inst),
    .sig(state),
    .mux_out(final_inst)
);

//control unit
Microprograming control_unit_blk(
    .instruction(final_inst),
    .wrten(wrt_en),
    .operation(operation),
    .mux_rs2imm(mux_rs2imm),
    .memread(memread),
    .memwrt(memwrt),
    .alu2mem_sig(alu2mem_sig),
    .space_sig(space_sig),
    .branch(branch),
    .branch_type(branch_type),
    .jump(jump),
    .memcop(memcop)
);

//jalr the pc+1 is written
Mux mux_jmp(
    .input_1(bus_C),
    .input_2(pc_next),
    .sig(jump),
    .mux_out(final_data)
);


//registers (include wrt data) (clk,rst,wrt_en)
reg_array register_blk(
    .reg1_addr(final_inst[19:15]),
    .reg2_addr(final_inst[24:20]),
    .wrt_addr(final_inst[11:7]),
    .reg1_val(reg1_val),
    .reg2_val(reg2_val),
    .clk(clk),
    .rst(rst),
    .wrt_en(wrt_en),
    .wrt_data(final_data)   
); 



//sign extender 
Imm_gen Imm_gen_blk (
    .instruction(final_inst),
    .Imm_out(Imm_out)
);

Memcpy Memcpy_blk(
    .clk(clk),
    .start_addr(instruction[19:15]),
    .destination_addr(instruction[24:20]),
    .size(Imm_out[11:0]),
    .memcop(memcop),
    .mem_inst(memcp_inst),
    .state(state)
);



//MUX to select between Imm_gen and rs2 output(sig)
Mux Mux_blk (
    .input_1(reg2_val),
    .input_2(Imm_out),
    .sig(mux_rs2imm),
    .mux_out(rs2imm_mux_out)
);


//assigning the outputs of reg1 and reg2 to buses
assign bus_A=reg1_val;
assign bus_B=rs2imm_mux_out;


//ALU (operation)
ALU ALU_blk(
    .reg1(bus_A),
    .reg2(bus_B),
    .out(ALU_out),
    .operation(operation),
    .zero_bit(zero_bit)
);

assign ALU_result=ALU_out;


//data memory  (memwrt,memread)
Data_mem Data_mem_blk(
    .clk(clk),
    .data_addr(ALU_out),
    .data_in(reg2_val),
    .memwrt(memwrt),
    .memread(memread),
    .data_out(memdata),
    .space_sig(space_sig)
);

//Mux to select from mem and ALU (alu2mux_sig)
Mux Mux_blk_2(
    .input_1(ALU_out),
    .input_2(memdata),
    .sig(alu2mem_sig),
    .mux_out(alu2mux_data)
);

assign bus_C=alu2mux_data;

endmodule
