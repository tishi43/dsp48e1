onerror {resume}
quietly WaveActivateNextPane {} 0
add wave -noupdate /bitstream_tb/test_inst/DSP48E1_inst/carryinsel_in
add wave -noupdate /bitstream_tb/test_inst/DSP48E1_inst/ad_mult
add wave -noupdate /bitstream_tb/test_inst/DSP48E1_inst/b_mult
add wave -noupdate /bitstream_tb/test_inst/DSP48E1_inst/qad_o_mux
add wave -noupdate /bitstream_tb/test_inst/DSP48E1_inst/a_preaddsub
add wave -noupdate /bitstream_tb/a
add wave -noupdate /bitstream_tb/b
add wave -noupdate /bitstream_tb/c
add wave -noupdate /bitstream_tb/p
TreeUpdate [SetDefaultTree]
WaveRestoreCursors {{Cursor 1} {968389 ps} 0}
quietly wave cursor active 1
configure wave -namecolwidth 214
configure wave -valuecolwidth 183
configure wave -justifyvalue left
configure wave -signalnamewidth 1
configure wave -snapdistance 10
configure wave -datasetprefix 0
configure wave -rowmargin 4
configure wave -childrowmargin 2
configure wave -gridoffset 0
configure wave -gridperiod 1
configure wave -griddelta 40
configure wave -timeline 0
configure wave -timelineunits ps
update
WaveRestoreZoom {969665 ps} {1001597 ps}
