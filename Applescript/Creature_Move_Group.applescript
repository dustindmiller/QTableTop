tell application id "com.figure53.QLab.4" to tell front workspace
	repeat
		set doubleChecker to (display dialog "Make Selection..." with title "Set Creature Move Group" buttons {"Place", "Reset", "Cancel | End Loop"} default button "Place" giving up after 5)
		set doubleCheck to button returned of doubleChecker as string
		if doubleCheck is "Cancel | End Loop" or doubleCheck is "" then
			return
		else if doubleCheck is "Reset" then
			set partyList to (q number of cues of cue "PARTY" & q number of cues of cue "PARTY A" & q number of cues of cue "PARTY B" & q number of cues of cue "PARTY C" & q number of cues of cue "PARTY D")
			set npcList to (q number of cues of cue "NPCs" & q number of cues of cue "NPC A" & q number of cues of cue "NPC B" & q number of cues of cue "NPC C" & q number of cues of cue "NPC D")
			set newTarg to (choose from list partyList & "——————————" & npcList with title "Reset Creature Movement Group" with prompt "Select Token..." default items "None" OK button name {"Reset"} cancel button name {"Cancel | End Loop"}) as string
			if newTarg is "false" then return
			if newTarg is in partyList then
				move cue id (uniqueID of cue newTarg) of parent of cue newTarg to end of cue "PARTY"
				set groupList to q number of cues of cue "PARTY GROUPS"
			else
				move cue id (uniqueID of cue newTarg) of parent of cue newTarg to end of cue "NPCs"
				set groupList to q number of cues of cue "NPC GROUPS"
			end if
			set text of cue (newTarg & " GROUP") to " "
			repeat with eachItem in groupList
				set currentTIDs to AppleScript's text item delimiters
				set AppleScript's text item delimiters to " | " -- Choose your delimiter
				set numList1 to q number of cues of cue eachItem
				set q name of cue ("· " & eachItem) to numList1 as text
				if q name of cue ("· " & eachItem) as string is not equal to "" then
					if newTarg is in partyList then
						set q color of cue ("· " & eachItem) to "Fuchsia"
					else
						set q color of cue ("· " & eachItem) to "Viridian"
						
					end if
					set armed of cue ("· " & eachItem) to true
					
				else
					set q name of cue ("· " & eachItem) to "Empty"
					set q color of cue ("· " & eachItem) to "Grey"
					set armed of cue ("· " & eachItem) to false
					
				end if
				set AppleScript's text item delimiters to currentTIDs -- It's good practice to set them back
			end repeat
		else if doubleCheck is "Place" then
			set partyList to (q number of cues of cue "PARTY" & q number of cues of cue "PARTY A" & q number of cues of cue "PARTY B" & q number of cues of cue "PARTY C" & q number of cues of cue "PARTY D")
			set npcList to (q number of cues of cue "NPCs" & q number of cues of cue "NPC A" & q number of cues of cue "NPC B" & q number of cues of cue "NPC C" & q number of cues of cue "NPC D")
			
			set newTarg to (choose from list partyList & "——————————" & npcList with title "Set Creature Move Group" with prompt "Select Token..." default items "None" OK button name {"Select"} cancel button name {"Cancel | End Loop"}) as string
			if newTarg is "false" then return
			if newTarg is in partyList then
				set groupList to q number of cues of cue "PARTY GROUPS"
			else if newTarg is in npcList then
				set groupList to q number of cues of cue "NPC GROUPS"
			end if
			
			set newGroup to (choose from list groupList with title "Set Creature Move Group" with prompt "Select Group..." default items "None" OK button name {"Place"} cancel button name {"Cancel | End Loop"}) as string
			if newGroup is "false" then return
			if newGroup is not "false" then
				move cue id (uniqueID of cue newTarg) of parent of cue newTarg to end of cue newGroup
				set text of cue (newTarg & " GROUP") to (text -1 of newGroup)
				repeat with eachItem in groupList
					set currentTIDs to AppleScript's text item delimiters
					set AppleScript's text item delimiters to " | "
					set numList1 to q number of cues of cue eachItem
					set q name of cue ("· " & eachItem) to numList1 as text
					if q name of cue ("· " & eachItem) as string is not equal to "" then
						if newTarg is in partyList then
							set q color of cue ("· " & eachItem) to "Fuchsia"
						else
							set q color of cue ("· " & eachItem) to "Viridian"
						end if
						set armed of cue ("· " & eachItem) to true
					else
						set q name of cue ("· " & eachItem) to "Empty"
						set q color of cue ("· " & eachItem) to "Grey"
						set armed of cue ("· " & eachItem) to false
					end if
					set AppleScript's text item delimiters to currentTIDs
				end repeat
			end if
		end if
	end repeat
end tell