# Clock signal
set_property PACKAGE_PIN W5 [get_ports CLOCK]							
	set_property IOSTANDARD LVCMOS33 [get_ports CLOCK]
	create_clock -add -name sys_clk_pin -period 10.00 -waveform {0 5} [get_ports CLOCK]
 
## Switches

set_property PACKAGE_PIN T1 [get_ports {FrequencyInputVector[0]}]					
	set_property IOSTANDARD LVCMOS33 [get_ports {FrequencyInputVector[0]}]
set_property PACKAGE_PIN R2 [get_ports {FrequencyInputVector[1]}]					
	set_property IOSTANDARD LVCMOS33 [get_ports {FrequencyInputVector[1]}]
 

# LEDs
set_property PACKAGE_PIN U16 [get_ports {TestVector[0]}]					
	set_property IOSTANDARD LVCMOS33 [get_ports {TestVector[0]}]
set_property PACKAGE_PIN E19 [get_ports {TestVector[1]}]					
	set_property IOSTANDARD LVCMOS33 [get_ports {TestVector[1]}]
set_property PACKAGE_PIN U19 [get_ports {TestVector[2]}]					
	set_property IOSTANDARD LVCMOS33 [get_ports {TestVector[2]}]
set_property PACKAGE_PIN V19 [get_ports {TestVector[3]}]					
	set_property IOSTANDARD LVCMOS33 [get_ports {TestVector[3]}]
	
	
#7 segment display
set_property PACKAGE_PIN W7 [get_ports {Segment_Select[0]}]                    
    set_property IOSTANDARD LVCMOS33 [get_ports {Segment_Select[0]}]
set_property PACKAGE_PIN W6 [get_ports {Segment_Select[1]}]                    
    set_property IOSTANDARD LVCMOS33 [get_ports {Segment_Select[1]}]
set_property PACKAGE_PIN U8 [get_ports {Segment_Select[2]}]                    
    set_property IOSTANDARD LVCMOS33 [get_ports {Segment_Select[2]}]
set_property PACKAGE_PIN V8 [get_ports {Segment_Select[3]}]                    
    set_property IOSTANDARD LVCMOS33 [get_ports {Segment_Select[3]}]
set_property PACKAGE_PIN U5 [get_ports {Segment_Select[4]}]                    
    set_property IOSTANDARD LVCMOS33 [get_ports {Segment_Select[4]}]
set_property PACKAGE_PIN V5 [get_ports {Segment_Select[5]}]                    
    set_property IOSTANDARD LVCMOS33 [get_ports {Segment_Select[5]}]
set_property PACKAGE_PIN U7 [get_ports {Segment_Select[6]}]                    
    set_property IOSTANDARD LVCMOS33 [get_ports {Segment_Select[6]}]

#For selecting the seven segmented displays
set_property PACKAGE_PIN U2 [get_ports {Display_Select[0]}]                    
    set_property IOSTANDARD LVCMOS33 [get_ports {Display_Select[0]}]
set_property PACKAGE_PIN U4 [get_ports {Display_Select[1]}]                    
    set_property IOSTANDARD LVCMOS33 [get_ports {Display_Select[1]}]
set_property PACKAGE_PIN V4 [get_ports {Display_Select[2]}]                    
    set_property IOSTANDARD LVCMOS33 [get_ports {Display_Select[2]}]
set_property PACKAGE_PIN W4 [get_ports {Display_Select[3]}]                    
    set_property IOSTANDARD LVCMOS33 [get_ports {Display_Select[3]}]


#Buttons
set_property PACKAGE_PIN U18 [get_ports NoteInputVector[4]]						
	set_property IOSTANDARD LVCMOS33 [get_ports NoteInputVector[4]]
set_property PACKAGE_PIN T18 [get_ports NoteInputVector[1]]						
	set_property IOSTANDARD LVCMOS33 [get_ports NoteInputVector[1]]
set_property PACKAGE_PIN W19 [get_ports NoteInputVector[0]]						
	set_property IOSTANDARD LVCMOS33 [get_ports NoteInputVector[0]]
set_property PACKAGE_PIN T17 [get_ports NoteInputVector[3]]						
	set_property IOSTANDARD LVCMOS33 [get_ports NoteInputVector[3]]
set_property PACKAGE_PIN U17 [get_ports NoteInputVector[2]]						
	set_property IOSTANDARD LVCMOS33 [get_ports NoteInputVector[2]]
 


#VGA Connector
set_property PACKAGE_PIN G19 [get_ports {VGA_R[0]}]				
	set_property IOSTANDARD LVCMOS33 [get_ports {VGA_R[0]}]
set_property PACKAGE_PIN H19 [get_ports {VGA_R[1]}]				
	set_property IOSTANDARD LVCMOS33 [get_ports {VGA_R[1]}]
set_property PACKAGE_PIN J19 [get_ports {VGA_R[2]}]				
	set_property IOSTANDARD LVCMOS33 [get_ports {VGA_R[2]}]
set_property PACKAGE_PIN N19 [get_ports {VGA_R[3]}]				
	set_property IOSTANDARD LVCMOS33 [get_ports {VGA_R[3]}]
set_property PACKAGE_PIN N18 [get_ports {VGA_B[0]}]				
	set_property IOSTANDARD LVCMOS33 [get_ports {VGA_B[0]}]
set_property PACKAGE_PIN L18 [get_ports {VGA_B[1]}]				
	set_property IOSTANDARD LVCMOS33 [get_ports {VGA_B[1]}]
set_property PACKAGE_PIN K18 [get_ports {VGA_B[2]}]				
	set_property IOSTANDARD LVCMOS33 [get_ports {VGA_B[2]}]
set_property PACKAGE_PIN J18 [get_ports {VGA_B[3]}]				
	set_property IOSTANDARD LVCMOS33 [get_ports {VGA_B[3]}]
set_property PACKAGE_PIN J17 [get_ports {VGA_G[0]}]				
	set_property IOSTANDARD LVCMOS33 [get_ports {VGA_G[0]}]
set_property PACKAGE_PIN H17 [get_ports {VGA_G[1]}]				
	set_property IOSTANDARD LVCMOS33 [get_ports {VGA_G[1]}]
set_property PACKAGE_PIN G17 [get_ports {VGA_G[2]}]				
	set_property IOSTANDARD LVCMOS33 [get_ports {VGA_G[2]}]
set_property PACKAGE_PIN D17 [get_ports {VGA_G[3]}]				
	set_property IOSTANDARD LVCMOS33 [get_ports {VGA_G[3]}]
set_property PACKAGE_PIN P19 [get_ports H_SYNC]						
	set_property IOSTANDARD LVCMOS33 [get_ports H_SYNC]
set_property PACKAGE_PIN R19 [get_ports V_SYNC]						
	set_property IOSTANDARD LVCMOS33 [get_ports V_SYNC]
#JA 1 for the sound pin
set_property PACKAGE_PIN J1 [get_ports {Sound_Actual_Top}]					
    set_property IOSTANDARD LVCMOS33 [get_ports {Sound_Actual_Top}]

