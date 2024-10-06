if [file exists "work"] {
    vdel -all
}
vlib work
vlog APB_Pack.svh APB_Top.sv +cover
vsim -batch work.APB_Top -coverage +UVM_TESTNAME=APB_Test
set NoQuitOnFinish 1
onbreak {resume}
log /* -r
run -all 
coverage report -codeAll -cvg -verbose

