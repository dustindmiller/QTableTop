tell application id "com.figure53.QLab.4" to tell front workspace
	set originalCueList to q name of current cue list
	
	set areaList to q number of cues of cue "MAPS"
	
	## SET AREA NAME
	display dialog "Map Area..." with title "Map Druid" with icon 1 buttons {"New Area", "Existing Area", "Cancel"} default button "Existing Area" cancel button "Cancel"
	set areaChoice to button returned of result
	if areaChoice is "cancel" then return
	if areaChoice is "New Area" then
		set newArea to true
		display dialog "Area Name" default answer "" with title "Map Druid" with icon 1 buttons {"Cancel", "Set"} default button "Set" cancel button "Cancel"
		set areaName to text returned of result
	else if areaChoice is "Existing Area" then
		set newArea to false
		set areaName to (choose from list areaList with title "Map Druid" with prompt "Area Name" default items "Utility") as string
		if areaName is "false" then return
	end if
	
	## MAKE MASKS SECTION ##
	
	## SET MAP NAME
	display dialog "Map Name" default answer "" with title "Token Druid" with icon 1 buttons {"Cancel", "Set"} default button "Set" cancel button "Cancel"
	set mapName to text returned of result
	
	## COUNT OF FLOORS TO CREATE
	display dialog "Floor Count" default answer "1" with title "Map Druid" with icon 1 buttons {"Cancel", "Create"} default button "Create" cancel button "Cancel"
	set tokenCount to text returned of result
	
	## MASK CHECKER
	display dialog "Masks?" with title "Map Druid" with icon 1 buttons {"Yes", "No", "Cancel"} default button "No" cancel button "Cancel"
	set maskChoice to button returned of result
	if maskChoice is "cancel" then return
	
	## MAKE MAP CUES	
	if tokenCount is not "0" then
		set mapCounter to 1
		if tokenCount is greater than 1 then
			set primaryMap to mapName
			
			## MAKES QTableTop - List ACTIVE FOR CUE CREATION
			set current cue list to first cue list whose q name is "QTableTop - List"
			
			make type "Group"
			set groupCue to last item of (selected as list)
			set q number of groupCue to primaryMap
			set q name of groupCue to primaryMap
			set priGroup to groupCue
			
			make type "Group"
			set groupCue to last item of (selected as list)
			set q number of groupCue to primaryMap & " FLOORS"
			set q name of groupCue to "Floors"
			set floorGroup to groupCue
			
			## MOVE PRIMARY FLOOR CUE TO PRIMARY GROUP CUE
			set cuesToGroup to {floorGroup}
			repeat with eachCue in cuesToGroup
				set eachCueID to uniqueID of eachCue
				move cue id eachCueID of parent of eachCue to end of priGroup
			end repeat
			
			repeat tokenCount times
				display dialog ("Floor " & mapCounter & " Name") default answer "" with title "Map Druid" with icon 1 buttons {"Cancel", "Set"} default button "Set" cancel button "Cancel"
				set floorName to text returned of result
				
				## SELECT MAP IMAGE FILE
				set theTarget to choose file with prompt "Please select " & floorName & " Map image file (Ensure Grid is 50x50 pixels!)"
				
				if maskChoice is "Yes" then
					set maskCount to 1
					set endLoop to false
					repeat while endLoop is false
						display dialog ("Mask " & maskCount & " Name") default answer "" with title "Map Druid" with icon 1 buttons {"Cancel", "Set"} default button "Set" cancel button "Cancel"
						set maskName to text returned of result
						if maskName is "cancel" then return
						
						
						display dialog ("Mask " & maskCount & " Number (UNIQUE TO WORKSPACE!)") default answer "" with title "Map Druid" with icon 1 buttons {"Cancel", "Set"} default button "Set" cancel button "Cancel"
						set maskNum to text returned of result
						if maskNum is "cancel" then return
						
						## SELECT MAP IMAGE FILE
						set theTarget to choose file with prompt "Please select " & maskName & " Mask image file (Ensure Grid is 50x50 pixels!)"
						
						## MAKES QTableTop - List ACTIVE FOR CUE CREATION
						set current cue list to first cue list whose q name is "QTableTop - List"
						
						## MAKE MAP VIDEO CUE
						make type "Video"
						set mapCue to last item of (selected as list)
						set the file target of mapCue to theTarget
						set q name of mapCue to maskName
						set the q number of mapCue to maskNum
						set opacity of mapCue to 0.01
						set layer of mapCue to 1
						set full screen of mapCue to false
						
						## CREATE PRIMARY MASK GROUP
						if maskCount is 1 then
							make type "Group"
							set groupCue to last item of (selected as list)
							set q number of groupCue to mapName & " - " & floorName & " MASKS"
							set mode of groupCue to fire_all
							set q name of groupCue to "Masks"
						end if
						
						## MOVE FLOOR VIDEO CUE TO FLOOR GROUP CUE
						set cuesToGroup to {mapCue}
						repeat with eachCue in cuesToGroup
							set eachCueID to uniqueID of eachCue
							move cue id eachCueID of parent of eachCue to end of groupCue
						end repeat
						set maskCount to maskCount + 1
						
						display dialog "More Masks?" with title "Map Druid" with icon 1 buttons {"Yes", "No", "Cancel"} default button "No" cancel button "Cancel"
						set moreMaskChoice to button returned of result
						if moreMaskChoice is "cancel" then return
						if moreMaskChoice is "No" then
							set endLoop to true
						else
							set endLoop to false
							
						end if
					end repeat
					collapse groupCue
					set maskCue to groupCue
				end if
				
				
				## MAKE MAP VIDEO CUE
				make type "Video"
				set mapCue to last item of (selected as list)
				set the file target of mapCue to theTarget
				set q name of mapCue to mapName & " - " & floorName
				set the q number of mapCue to mapName & " - " & floorName & " BASE"
				set opacity of mapCue to 0.01
				set layer of mapCue to 1
				set full screen of mapCue to false
				
				## CREATE PRIMARY MAP GROUP
				make type "Group"
				set groupCue to last item of (selected as list)
				set q number of groupCue to mapName & " - " & floorName
				set mode of groupCue to fire_all
				set q name of groupCue to floorName
				
				## MOVE FLOOR AND/OR MASK VIDEO CUE TO FLOOR GROUP CUE
				if maskChoice is "Yes" then
					set cuesToGroup to {mapCue, maskCue}
				else
					set cuesToGroup to {mapCue}
				end if
				repeat with eachCue in cuesToGroup
					set eachCueID to uniqueID of eachCue
					move cue id eachCueID of parent of eachCue to end of groupCue
				end repeat
				collapse groupCue
				
				## MOVE FLOOR GROUP CUE TO PRIMARY FLOOR CUE
				set cuesToGroup to {groupCue}
				repeat with eachCue in cuesToGroup
					set eachCueID to uniqueID of eachCue
					move cue id eachCueID of parent of eachCue to end of floorGroup
				end repeat
				
				set mapCounter to (mapCounter + 1)
				
			end repeat
			
			if newArea = true then
				set mapCue to priGroup
				set cuesToGroup to {mapCue}
				make type "Group"
				set groupCue to last item of (selected as list)
				set q number of groupCue to areaName
				set mode of groupCue to fire_first_enter_group
				set q name of groupCue to areaName
				repeat with eachCue in cuesToGroup
					set eachCueID to uniqueID of eachCue
					move cue id eachCueID of parent of eachCue to end of groupCue
				end repeat
				collapse groupCue
			end if
			
			## MOVE NEW MAP TO AREA
			if newArea = false then
				set cueID to uniqueID of priGroup
				move cue id cueID of parent of priGroup to end of cue areaName
				
			else if newArea = true then
				set cueID to uniqueID of groupCue
				move cue id cueID of parent of groupCue to end of cue "MAPS"
			end if
			
			return
		else
			
			## SELECT MAP IMAGE FILE
			set theTarget to choose file with prompt "Please select " & mapName & " Map image file (Ensure Grid is 50x50 pixels!)"
			
			if maskChoice is "Yes" then
				set maskCount to 1
				set endLoop to false
				repeat while endLoop is false
					display dialog ("Mask " & maskCount & " Name") default answer "" with title "Map Druid" with icon 1 buttons {"Cancel", "Set"} default button "Set" cancel button "Cancel"
					set maskName to text returned of result
					if maskName is "cancel" then return
					
					
					display dialog ("Mask " & maskCount & " Number (UNIQUE TO WORKSPACE!)") default answer "" with title "Map Druid" with icon 1 buttons {"Cancel", "Set"} default button "Set" cancel button "Cancel"
					set maskNum to text returned of result
					if maskNum is "cancel" then return
					
					## SELECT MAP IMAGE FILE
					set theTarget to choose file with prompt "Please select " & maskName & " Mask image file (Ensure Grid is 50x50 pixels!)"
					
					## MAKES QTableTop - List ACTIVE FOR CUE CREATION
					set current cue list to first cue list whose q name is "QTableTop - List"
					
					## MAKE MAP VIDEO CUE
					make type "Video"
					set mapCue to last item of (selected as list)
					set the file target of mapCue to theTarget
					set q name of mapCue to maskName
					set the q number of mapCue to maskNum
					set opacity of mapCue to 0.01
					set layer of mapCue to 1
					set full screen of mapCue to false
					
					## CREATE PRIMARY MASK GROUP
					if maskCount is 1 then
						make type "Group"
						set groupCue to last item of (selected as list)
						set q number of groupCue to mapName & " MASKS"
						set mode of groupCue to fire_all
						set q name of groupCue to "Masks"
					end if
					
					## MOVE FLOOR VIDEO CUE TO FLOOR GROUP CUE
					set cuesToGroup to {mapCue}
					repeat with eachCue in cuesToGroup
						set eachCueID to uniqueID of eachCue
						move cue id eachCueID of parent of eachCue to end of groupCue
					end repeat
					set maskCount to maskCount + 1
					
					display dialog "More Masks?" with title "Map Druid" with icon 1 buttons {"Yes", "No", "Cancel"} default button "No" cancel button "Cancel"
					set moreMaskChoice to button returned of result
					if moreMaskChoice is "cancel" then return
					if moreMaskChoice is "No" then
						set endLoop to true
					else
						set endLoop to false
						
					end if
				end repeat
				collapse groupCue
				set maskCue to groupCue
			end if
			
			## MAKES QTableTop - List ACTIVE FOR CUE CREATION
			set current cue list to first cue list whose q name is "QTableTop - List"
			
			## MAKE MAP VIDEO CUE
			make type "Video"
			set mapCue to last item of (selected as list)
			set the file target of mapCue to theTarget
			set q name of mapCue to mapName
			set the q number of mapCue to mapName & " BASE"
			set opacity of mapCue to 0.01
			set layer of mapCue to 1
			set full screen of mapCue to false
			
			## MOVE ALL NEW CUES TO MAP GROUP CUE
			if maskChoice is "Yes" then
				set cuesToGroup to {mapCue, maskCue}
			else
				set cuesToGroup to {mapCue}
			end if
			make type "Group"
			set groupCue to last item of (selected as list)
			set q number of groupCue to mapName
			set mode of groupCue to fire_all
			set q name of groupCue to mapName
			repeat with eachCue in cuesToGroup
				set eachCueID to uniqueID of eachCue
				move cue id eachCueID of parent of eachCue to end of groupCue
			end repeat
			collapse groupCue
			
			
			if newArea = true then
				set mapCue to groupCue
				set cuesToGroup to {mapCue}
				make type "Group"
				set groupCue to last item of (selected as list)
				set q number of groupCue to areaName
				set mode of groupCue to fire_first_enter_group
				set q name of groupCue to areaName
				repeat with eachCue in cuesToGroup
					set eachCueID to uniqueID of eachCue
					move cue id eachCueID of parent of eachCue to end of groupCue
				end repeat
				collapse groupCue
			end if
			
			## MOVE NEW MAP TO AREA
			if newArea = false then
				set cueID to uniqueID of groupCue
				move cue id cueID of parent of groupCue to end of cue areaName
				
			else if newArea = true then
				set cueID to uniqueID of groupCue
				move cue id cueID of parent of groupCue to end of cue "MAPS"
			end if
		end if
	else if tokenCount is "0" then
		return
	end if
	
	## RETURNS TO PREVIOUS ACTIVE CUE LIST
	set current cue list to first cue list whose q name is originalCueList
	return
	
end tell
