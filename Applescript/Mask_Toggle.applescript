tell application id "com.figure53.QLab.4" to tell front workspace
	##set mapList to (q number of cues of cue "MAPS")
	##set mapName to (choose from list mapList with title "Toggle Masks" with prompt "Select Map..." OK button name {"Select"} cancel button name {"Cancel"}) as string
	set mapName to q name of cue "Map Toggle"
	if mapName is "No Active Map" then
		return
	else if cue (mapName & " MASKS") exists then
		set maskList to (q number of cues of cue (mapName & " MASKS"))
		set maskSel to (choose from list maskList with title "Toggle " & mapName & " Masks" with prompt "Select Mask..." OK button name {"Select"} cancel button name {"Cancel"}) as string
		if maskSel is "false" then
			return
		else if maskSel is not "Cancel" then
			set maskName to q name of cue maskSel
			if opacity of cue maskSel is not 0 then
				set maskState to "(Active)"
				set defButton to "Disable"
			else
				set maskState to "(Not-Active)"
				set defButton to "Enable"
			end if
			set maskAction to (display dialog maskSel & " - " & maskName & " " & maskState with title "Toggle " & mapName & " Masks" buttons {"Enable", "Disable", "Cancel"} default button defButton giving up after 5)
			set maskAct to button returned of maskAction
			if maskAct is "Cancel" then
				return
			else if maskAct is "Enable" then
				set armed of cue "Mask Enabler" to true
				set opacity of cue maskSel to 0.01
				start cue "Mask Enabler"
				delay 3
				set armed of cue "Mask Enabler" to false
			else if maskAct is "Disable" then
				set opacity of cue maskSel to 0.0
			end if
		end if
	else
		display dialog "Map does not have any masks" with title "Toggle Masks" with icon 2 buttons "OK" default button "OK" giving up after 5
	end if
end tell