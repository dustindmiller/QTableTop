tell application id "com.figure53.QLab.4" to tell front workspace
	if cue "ALL PARTY" is not running and cue "ALL NPCs" is not running then
		display dialog "No Active Tokens" with title "Initiative Tracker" with icon 2 buttons "OK" default button "OK" giving up after 5
		return
	else
		set doubleChecker to (display dialog "Make Selection..." with title "Initiative Tracker" buttons {"Set", "Reset", "Cancel"} default button "Set" giving up after 5)
		set doubleCheck to button returned of doubleChecker as string
		if doubleCheck is "Cancel" or doubleCheck is "" then
			return
		else if doubleCheck is "Reset" then
			set notes of cue "Initiative Tracker" to "No Active Combat"
			set q name of cue "Initiative Tracker" to "No Active Combat"
			set q name of cue "Previous Turn" to "No Active Combat"
			set q name of cue "Next Turn" to "No Active Combat"
			set cue target of cue "RIGHT" to cue "ALL PARTY"
			set cue target of cue "LEFT" to cue "ALL PARTY"
			set cue target of cue "UP" to cue "ALL PARTY"
			set cue target of cue "DOWN" to cue "ALL PARTY"
			set cue target of cue "UP RIGHT" to cue "ALL PARTY"
			set cue target of cue "UP LEFT" to cue "ALL PARTY"
			set cue target of cue "DOWN RIGHT" to cue "ALL PARTY"
			set cue target of cue "DOWN LEFT" to cue "ALL PARTY"
			set q name of cue "Target" to "ALL PARTY"
			
			return
		else if doubleCheck is "Set" then
			set notes of cue "Initiative Tracker" to "No Active Combat"
			repeat
				set partyList to ((q number of cues of cue "PARTY" where running = true) & (q number of cues of cue "PARTY A" where running = true) & (q number of cues of cue "PARTY B" where running = true) & (q number of cues of cue "PARTY C" where running = true) & (q number of cues of cue "PARTY D" where running = true))
				set npcList to ((q number of cues of cue "NPCs" where running = true) & (q number of cues of cue "NPC A" where running = true) & (q number of cues of cue "NPC B" where running = true) & (q number of cues of cue "NPC C" where running = true) & (q number of cues of cue "NPC D" where running = true))
				set newTarg to (choose from list partyList & "——————————" & npcList with title "Set Initiative Order" with prompt "Select Token..." default items "None" OK button name {"Select"} cancel button name {"Cancel | End Loop"}) as string
				if newTarg is "false" then
					if notes of cue "Initiative Tracker" is not "No Active Combat" then
						set currentTIDs to AppleScript's text item delimiters
						set AppleScript's text item delimiters to " | "
						
						set intList to notes of cue "Initiative Tracker"
						set intListItems to every text item of intList
						set nextTurn to item 2 of intListItems
						set prevTurn to item -1 of intListItems
						set q name of cue "Initiative Tracker" to currentTurn
						set q name of cue "Previous Turn" to prevTurn
						set q name of cue "Next Turn" to nextTurn
						set cue target of cue "RIGHT" to cue currentTurn
						set cue target of cue "LEFT" to cue currentTurn
						set cue target of cue "UP" to cue currentTurn
						set cue target of cue "DOWN" to cue currentTurn
						set cue target of cue "UP RIGHT" to cue currentTurn
						set cue target of cue "UP LEFT" to cue currentTurn
						set cue target of cue "DOWN RIGHT" to cue currentTurn
						set cue target of cue "DOWN LEFT" to cue currentTurn
						set q name of cue "Target" to currentTurn
						set AppleScript's text item delimiters to currentTIDs
						return
					else
						return
					end if
				else
					set currentTIDs to AppleScript's text item delimiters
					
					set AppleScript's text item delimiters to " | "
					
					if notes of cue "Initiative Tracker" is "No Active Combat" then
						set numList1 to q number of cue newTarg as list
						set currentTurn to newTarg
					else
						set numList1 to notes of cue "Initiative Tracker" as list
						copy newTarg to the end of numList1
					end if
					set notes of cue "Initiative Tracker" to numList1 as text
					
					set AppleScript's text item delimiters to currentTIDs
				end if
			end repeat
			
		end if
	end if
end tell