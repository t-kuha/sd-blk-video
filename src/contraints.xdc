# -----------------------------------------------------------------------------
# HDMI Out
# -----------------------------------------------------------------------------
# Data
set_property PACKAGE_PIN L19 [get_ports {hdmi_out_data[0]}]
set_property PACKAGE_PIN L20 [get_ports {hdmi_out_data[1]}]
set_property PACKAGE_PIN K19 [get_ports {hdmi_out_data[2]}]
set_property PACKAGE_PIN N17 [get_ports {hdmi_out_data[3]}]
set_property PACKAGE_PIN P18 [get_ports {hdmi_out_data[4]}]
set_property PACKAGE_PIN P15 [get_ports {hdmi_out_data[5]}]
set_property PACKAGE_PIN P16 [get_ports {hdmi_out_data[6]}]
set_property PACKAGE_PIN T17 [get_ports {hdmi_out_data[7]}]
set_property PACKAGE_PIN J19 [get_ports {hdmi_out_data[8]}]
set_property PACKAGE_PIN M17 [get_ports {hdmi_out_data[9]}]
set_property PACKAGE_PIN R18 [get_ports {hdmi_out_data[10]}]
set_property PACKAGE_PIN R16 [get_ports {hdmi_out_data[11]}]
set_property PACKAGE_PIN R17 [get_ports {hdmi_out_data[12]}]
set_property PACKAGE_PIN V17 [get_ports {hdmi_out_data[13]}]
set_property PACKAGE_PIN V18 [get_ports {hdmi_out_data[14]}]
set_property PACKAGE_PIN W18 [get_ports {hdmi_out_data[15]}]
set_property PACKAGE_PIN M18 [get_ports {hdmi_out_data[16]}]
set_property PACKAGE_PIN M19 [get_ports {hdmi_out_data[17]}]
set_property PACKAGE_PIN M20 [get_ports {hdmi_out_data[18]}]
set_property PACKAGE_PIN W19 [get_ports {hdmi_out_data[19]}]
set_property PACKAGE_PIN T20 [get_ports {hdmi_out_data[20]}]
set_property PACKAGE_PIN U20 [get_ports {hdmi_out_data[21]}]
set_property PACKAGE_PIN V16 [get_ports {hdmi_out_data[22]}]
set_property PACKAGE_PIN W16 [get_ports {hdmi_out_data[23]}]

# Timing
set_property PACKAGE_PIN P19 [get_ports hdmi_out_de]
set_property PACKAGE_PIN Y18 [get_ports hdmi_out_hs]
set_property PACKAGE_PIN Y19 [get_ports hdmi_out_vs]
set_property PACKAGE_PIN N18 [get_ports hdmi_out_pclk]

set_property IOSTANDARD LVCMOS33 [get_ports [list {hdmi_out_data[*]} hdmi_out_de hdmi_out_hs hdmi_out_vs hdmi_out_pclk]]
set_property SLEW FAST [get_ports [list {hdmi_out_data[*]} hdmi_out_de hdmi_out_hs hdmi_out_vs hdmi_out_pclk]]
