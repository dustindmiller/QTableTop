tell application id "com.figure53.QLab.4" to tell front workspace
	set moveGroup to "NPC C"
	set doubleChecker to (display dialog ("What would you like to do with " & moveGroup & "?") with title moveGroup buttons {"Target", "Reset"} default button "Target" giving up after 5)
	set doubleCheck to button returned of doubleChecker
	if doubleCheck is "Reset" then
		set partyList to (q number of cues of cue moveGroup)
		repeat with message in partyList
			move cue id (uniqueID of cue message) of parent of cue message to end of cue "PARTY"
			set text of cue (message & " GROUP") to " "
		end repeat
		set q name of cue ("á " & moveGroup) to "Empty"
		set q color of cue ("á " & moveGroup) to "Grey"
		set armed of cue ("á " & moveGroup) to false
	else if doubleCheck is "Target" then
		set cue target of cue "RIGHT" to cue moveGroup
		set cue target of cue "LEFT" to cue moveGroup
		set cue target of cue "UP" to cue moveGroup
		set cue target of cue "DOWN" to cue moveGroup
		set cue target of cue "UP RIGHT" to cue moveGroup
		set cue target of cue "UP LEFT" to cue moveGroup
		set cue target of cue "DOWN RIGHT" to cue moveGroup
		set cue target of cue "DOWN LEFT" to cue moveGroup
		set q name of cue "Target" to moveGroup
	end if
end tell