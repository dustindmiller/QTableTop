tell application id "com.figure53.QLab.4" to tell front workspace
	set doubleChecker to (display dialog "Please Confirm Total NPC Movement Group Reset..." with title "Reset NPC Movement Group" buttons {"Confirm", "Cancel"} default button "Confirm" giving up after 5)
	set doubleCheck to button returned of doubleChecker
	if doubleCheck is "Cancel" then return
	if doubleCheck is "Confirm" then
		set partyList to (q number of cues of cue "NPCs" & q number of cues of cue "NPC A" & q number of cues of cue "NPC B" & q number of cues of cue "NPC C" & q number of cues of cue "NPC D")
		set groupList to (q number of cues of cue "NPC GROUPS")
		repeat with message in partyList
			move cue id (uniqueID of cue message) of parent of cue message to end of cue "NPCs"
			set text of cue (message & " GROUP") to " "
		end repeat
		repeat with messageTwo in groupList
			set currentTIDs to AppleScript's text item delimiters
			set AppleScript's text item delimiters to " | " -- Choose your delimiter
			set numList to q number of cues of cue messageTwo
			set q name of cue ("· " & messageTwo) to numList as text
			set q color of cue ("· " & messageTwo) to "Grey"
			set armed of cue ("· " & messageTwo) to false
			set AppleScript's text item delimiters to currentTIDs -- It's good practice to set them back
		end repeat
	end if
end tell