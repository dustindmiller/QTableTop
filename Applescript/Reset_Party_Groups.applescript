tell application id "com.figure53.QLab.4" to tell front workspace
	set doubleChecker to (display dialog "Please Confirm Total Party Movement Group Reset..." with title "Reset Party Movement Group" buttons {"Confirm", "Cancel"} default button "Confirm" giving up after 5)
	set doubleCheck to button returned of doubleChecker
	if doubleCheck is "Cancel" then return
	if doubleCheck is "Confirm" then
		set partyList to (q number of cues of cue "PARTY" & q number of cues of cue "PARTY A" & q number of cues of cue "PARTY B" & q number of cues of cue "PARTY C" & q number of cues of cue "PARTY D")
		
		set groupList to (q number of cues of cue "PARTY GROUPS")
		repeat with message in partyList
			move cue id (uniqueID of cue message) of parent of cue message to end of cue "PARTY"
			set text of cue (message & " GROUP") to " "
		end repeat
		repeat with messageTwo in groupList
			set currentTIDs to AppleScript's text item delimiters
			set AppleScript's text item delimiters to " | " -- Choose your delimiter
			set numList to q number of cues of cue messageTwo
			set q name of cue ("á " & messageTwo) to "Empty"
			set q color of cue ("á " & messageTwo) to "Grey"
			set armed of cue ("á " & messageTwo) to false
			set AppleScript's text item delimiters to currentTIDs -- It's good practice to set them back
		end repeat
	end if
end tell