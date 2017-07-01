
# PlanAhead Launch Script for Pre-Synthesis Floorplanning, created by Project Navigator

create_project -name elock -dir "C:/Users/Bunny/Desktop/verilog Workspace/elock/planAhead_run_2" -part xc3s700anfgg484-4
set_param project.pinAheadLayout yes
set srcset [get_property srcset [current_run -impl]]
set_property target_constrs_file "elock_init.ucf" [current_fileset -constrset]
set hdlfile [add_files [list {ecode.v}]]
set_property file_type Verilog $hdlfile
set_property library work $hdlfile
set_property top elock_init $srcset
add_files [list {elock_init.ucf}] -fileset [get_property constrset [current_run]]
open_rtl_design -part xc3s700anfgg484-4
