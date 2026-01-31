transcript on
if {[file exists gate_work]} {
	vdel -lib gate_work -all
}
vlib gate_work
vmap work gate_work

vlog -vlog01compat -work work +incdir+. {t1c_riscv_cpu.vo}

vlog -vlog01compat -work work +incdir+/home/maruthi/intelFPGA_lite/20.1/quartus/t1c_riscv_cpu/.test {/home/maruthi/intelFPGA_lite/20.1/quartus/t1c_riscv_cpu/.test/tb_1.v}

vsim -t 1ps -L altera_ver -L altera_lnsim_ver -L fiftyfivenm_ver -L gate_work -L work -voptargs="+acc"  tb_1

add wave *
view structure
view signals
run -all
