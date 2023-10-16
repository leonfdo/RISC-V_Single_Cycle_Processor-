# 
# Synthesis run script generated by Vivado
# 

set TIME_start [clock seconds] 
proc create_report { reportName command } {
  set status "."
  append status $reportName ".fail"
  if { [file exists $status] } {
    eval file delete [glob $status]
  }
  send_msg_id runtcl-4 info "Executing : $command"
  set retval [eval catch { $command } msg]
  if { $retval != 0 } {
    set fp [open $status w]
    close $fp
    send_msg_id runtcl-5 warning "$msg"
  }
}
set_param synth.incrementalSynthesisCache C:/Users/leonf/AppData/Roaming/Xilinx/Vivado/.Xil/Vivado-23536-DESKTOP-TA3S8JV/incrSyn
set_msg_config -id {Synth 8-256} -limit 10000
set_msg_config -id {Synth 8-638} -limit 10000
set_msg_config  -id {Synth 8-2576}  -string {{ERROR: [Synth 8-2576] procedural assignment to a non-register mux_out is not permitted [C:/Users/leonf/OneDrive/Documents/processor/project/project.srcs/sources_1/new/Mux.sv:11]}}  -suppress 
set_msg_config  -id {Synth 8-2576}  -string {{ERROR: [Synth 8-2576] procedural assignment to a non-register mux_out is not permitted [C:/Users/leonf/OneDrive/Documents/processor/project/project.srcs/sources_1/new/Mux.sv:12]}}  -suppress 
create_project -in_memory -part xc7z010clg400-1

set_param project.singleFileAddWarning.threshold 0
set_param project.compositeFile.enableAutoGeneration 0
set_param synth.vivado.isSynthRun true
set_property webtalk.parent_dir C:/Users/leonf/OneDrive/Documents/processor/project/project.cache/wt [current_project]
set_property parent.project_path C:/Users/leonf/OneDrive/Documents/processor/project/project.xpr [current_project]
set_property default_lib xil_defaultlib [current_project]
set_property target_language Verilog [current_project]
set_property ip_output_repo c:/Users/leonf/OneDrive/Documents/processor/project/project.cache/ip [current_project]
set_property ip_cache_permissions {read write} [current_project]
read_verilog -library xil_defaultlib -sv {
  C:/Users/leonf/OneDrive/Documents/processor/project/project.srcs/sources_1/new/ALU.sv
  C:/Users/leonf/OneDrive/Documents/processor/project/project.srcs/sources_1/new/Adder.sv
  C:/Users/leonf/OneDrive/Documents/processor/project/project.srcs/sources_1/new/Branch_pre.sv
  C:/Users/leonf/OneDrive/Documents/processor/project/project.srcs/sources_1/new/Data_mem.sv
  C:/Users/leonf/OneDrive/Documents/processor/project/project.srcs/sources_1/new/Imm_gen.sv
  C:/Users/leonf/OneDrive/Documents/processor/project/project.srcs/sources_1/new/Instruction_mem.sv
  C:/Users/leonf/OneDrive/Documents/processor/project/project.srcs/sources_1/new/Memcpy.sv
  C:/Users/leonf/OneDrive/Documents/processor/project/project.srcs/sources_1/new/Microprograming.sv
  C:/Users/leonf/OneDrive/Documents/processor/project/project.srcs/sources_1/new/Mux.sv
  C:/Users/leonf/OneDrive/Documents/processor/project/project.srcs/sources_1/new/program_count.sv
  C:/Users/leonf/OneDrive/Documents/processor/project/project.srcs/sources_1/new/register.sv
  C:/Users/leonf/OneDrive/Documents/processor/project/project.srcs/sources_1/new/Datapath.sv
}
# Mark all dcp files as not used in implementation to prevent them from being
# stitched into the results of this synthesis run. Any black boxes in the
# design are intentionally left as such for best results. Dcp files will be
# stitched into the design at a later time, either when this synthesis run is
# opened, or when it is stitched into a dependent implementation run.
foreach dcp [get_files -quiet -all -filter file_type=="Design\ Checkpoint"] {
  set_property used_in_implementation false $dcp
}
set_param ips.enableIPCacheLiteLoad 1
close [open __synthesis_is_running__ w]

synth_design -top Datapath -part xc7z010clg400-1


# disable binary constraint mode for synth run checkpoints
set_param constraints.enableBinaryConstraints false
write_checkpoint -force -noxdef Datapath.dcp
create_report "synth_1_synth_report_utilization_0" "report_utilization -file Datapath_utilization_synth.rpt -pb Datapath_utilization_synth.pb"
file delete __synthesis_is_running__
close [open __synthesis_is_complete__ w]
