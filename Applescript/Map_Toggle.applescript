tell application id "com.figure53.QLab.4" to tell front workspace
	set areaNameList to (q number of cues of cue "MAPS")
	if notes of cue "Map Toggle" is not " " then
		set mapMaster to notes of cue "Map Toggle"
	end if
	if q name of cue "Map Toggle" is not "No Active Map" then
		set activeMap to q name of cue "Map Toggle" as string
		set beginning of areaNameList to "——————————"
		set beginning of areaNameList to activeMap
	else
		set activeMap to ""
	end if
	set selectedArea to (choose from list areaNameList with title "Toggle Map" with prompt "Select Area..." default items activeMap OK button name {"Select"} cancel button name {"Cancel"}) as string
	if selectedArea is "false" then
		return
	else if selectedArea is activeMap then
		start cue "Map Fade Down"
		set q name of cue "Map Toggle" to "Deactivating " & activeMap
		set q color of cue "Map Toggle" to "orange"
		delay 5.1
		set q name of cue "Map Toggle" to "No Active Map"
		set q name of cue "Mask Toggle" to "No Active Map w/ Masks"
		set q color of cue "Map Toggle" to "red"
		set q color of cue "Mask Toggle" to "rufous"
		return
	else
		set mapNameList to (q number of cues of cue selectedArea)
		if notes of cue "Map Toggle" is not " " then
			set varMap to activeMap
			set activeMap to mapMaster
		else
			set activeMap to q name of cue "Map Toggle"
		end if
		set newTarg to (choose from list mapNameList with title "Toggle Map" with prompt "Select Map..." default items activeMap OK button name {"Toggle"} cancel button name {"Cancel"}) as string
		if notes of cue "Map Toggle" is not " " then
			set activeMap to varMap
		end if
		set floorExists to exists of cue (newTarg & " FLOORS")
		set maskExists to exists cue (newTarg & " MASKS")
		if newTarg is "Cancel" then
			return
		else
			if floorExists = true then
				set mapTarg to newTarg
				set notes of cue "Map Toggle" to mapTarg
				set notes of cue "Map Toggle" to mapTarg
				set floorList to (q number of cues of cue (newTarg & " FLOORS"))
				set newTarg to (choose from list floorList with title "Toggle Map" with prompt "Select Floor..." default items activeMap OK button name {"Toggle"} cancel button name {"Cancel"}) as string
				set maskExists to exists cue (newTarg & " MASKS")
				if newTarg is "Cancel" then
					return
				end if
			else
				set notes of cue "Map Toggle" to " "
			end if
			if cue newTarg is running then ##and floorExists = false then
				set cue target of cue "Map Fade Down" to cue newTarg
				set q name of cue "Map Toggle" to "Deactivating " & newTarg
				set q color of cue "Map Toggle" to "orange"
				start cue "Map Fade Down"
			else if cue newTarg is not running then ##and floorExists = false then
				set cue target of cue "Map Fade Up" to cue newTarg
				set q name of cue "Map Toggle" to "Activating " & newTarg
				set q color of cue "Map Toggle" to "yellow"
				start cue newTarg
				delay 0.1
				if maskExists = true then
					set cue target of cue "Mask Enabler" to cue (newTarg & " MASKS")
					set armed of cue "Mask Enabler" to true
					start cue "Mask Enabler"
				end if
				start cue "Map Fade Up"
				delay 0.1
				set armed of cue "Mask Enabler" to false
				
				##	else if cue newTarg is not running and floorExists = true and cue target of cue "Map Fade Down" is not cue mapTarg then
				##		set cue target of cue "Map Fade Up" to cue newTarg
				##		set q name of cue "Map Toggle" to "Activating " & newTarg
				##		set q color of cue "Map Toggle" to "yellow"
				##		start cue mapTarg
				##		delay 0.1
				##		if maskExists = true then
				##			set cue target of cue "Mask Enabler" to cue (newTarg & " MASKS")
				##			set armed of cue "Mask Enabler" to true
				##			start cue "Mask Enabler"
				##		end if
				##		start cue "Map Fade Up"
				##		start cue "Map Fade Down"
				##		delay 0.1
				##		set armed of cue "Mask Enabler" to false
				
				##	else if cue newTarg is not running and floorExists = true and cue target of cue "Map Fade Down" is cue mapTarg then
				##		set cue target of cue "Map Fade Up" to cue newTarg
				##		set q name of cue "Map Toggle" to "Activating " & newTarg
				##		set q color of cue "Map Toggle" to "yellow"
				##		start cue mapTarg
				##		delay 0.1
				##		if maskExists = true then
				##			set cue target of cue "Mask Enabler" to cue (newTarg & " MASKS")
				##			set armed of cue "Mask Enabler" to true
				##			start cue "Mask Enabler"
				##		end if
				##		start cue "Map Fade Up"
				##		delay 0.1
				##		set armed of cue "Mask Enabler" to false
				
				##else if (cue newTarg is running) and (floorExists = true) and (cue target of cue "Floor Disabler" is cue newTarg) then
				##	set cue target of cue "Map Fade Down" to cue newTarg
				##		set q name of cue "Map Toggle" to "Deactivating " & newTarg
				##		set q color of cue "Map Toggle" to "orange"
				##		start cue "Map Fade Down"
				##else if (cue newTarg is running) and (floorExists = true) and (cue target of cue "Floor Disabler" is not cue newTarg) then
				##		set cue target of cue "Map Fade Up" to cue newTarg
				##		set q name of cue "Map Toggle" to "Activating " & newTarg
				##		set q color of cue "Map Toggle" to "yellow"
				##		if maskExists = true then
				##			set cue target of cue "Mask Enabler" to cue (newTarg & " MASKS")
				##			set armed of cue "Mask Enabler" to true
				##			start cue "Mask Enabler"
				##		end if
				##		start cue "Map Fade Up"
				##		start cue "Floor Disabler"
				##		delay 0.1
				##		set armed of cue "Mask Enabler" to false
			end if
		end if
		
		if (cue activeMap exists) and (cue activeMap is running) then ##and (floorExists = false) then
			start cue "Map Fade Down"
		end if
		delay 5
		if cue newTarg is running then
			set q name of cue "Map Toggle" to newTarg
			set q color of cue "Map Toggle" to "green"
			if floorExists = true then
				set armed of cue "Floor Disabler" to true
				set cue target of cue "Floor Disabler" to cue newTarg
				set cue target of cue "Map Fade Down" to cue newTarg
			else
				set armed of cue "Floor Disabler" to false
				set cue target of cue "Map Fade Down" to cue newTarg
			end if
		else
			set q name of cue "Map Toggle" to "No Active Map"
			set q name of cue "Mask Toggle" to "No Active Map w/ Masks"
			set q color of cue "Map Toggle" to "red"
			set q color of cue "Mask Toggle" to "rufous"
			
		end if
		if (maskExists = true) and (cue (newTarg & " MASKS") is running) then
			set cue target of cue "Mask Enabler" to cue (newTarg & " MASKS")
			set q name of cue "Mask Toggle" to (newTarg & " Masks")
			set q color of cue "Mask Toggle" to "green"
		else if (maskExists = false) and (cue newTarg is running) then
			set q name of cue "Mask Toggle" to "Active Map Has No Masks"
			set q color of cue "Mask Toggle" to "rufous"
		else
			set q name of cue "Mask Toggle" to "No Active Map w/ Masks"
			set q color of cue "Mask Toggle" to "rufous"
		end if
	end if
end tell