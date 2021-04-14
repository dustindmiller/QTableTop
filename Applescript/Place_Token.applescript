tell application id "com.figure53.QLab.4" to tell front workspace
	set partyList to (q number of cues of cue "PARTY" & q number of cues of cue "PARTY A" & q number of cues of cue "PARTY B" & q number of cues of cue "PARTY C" & q number of cues of cue "PARTY D")
	set beginning of partyList to "PARTY"
	set npcList to (q number of cues of cue "NPCs" & q number of cues of cue "NPC A" & q number of cues of cue "NPC B" & q number of cues of cue "NPC C" & q number of cues of cue "NPC D")
	set beginning of npcList to "ÑÑÑÑÑÑÑÑÑÑ"

end tell
-- repeat
	set newTarg to (choose from list (partyList & npcList) with title "Place Token on Map" with prompt "Select Token..." default items "None" OK button name {"Place"} cancel button name {"Cancel"} with multiple selections allowed)
	if newTarg is false then return
	tell application id "com.figure53.QLab.4" to tell front workspace
		if newTarg is not false then
			repeat with message in newTarg
			start cue message
			end repeat
		end if
	end tell
-- end repeat