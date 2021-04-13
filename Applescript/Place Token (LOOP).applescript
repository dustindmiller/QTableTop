tell application id "com.figure53.QLab.4" to tell front workspace
	set partyList to (q number of cues of cue "PARTY" & q number of cues of cue "PARTY A" & q number of cues of cue "PARTY B" & q number of cues of cue "PARTY C" & q number of cues of cue "PARTY D")
	set beginning of partyList to "PARTY"
	set npcList to (q number of cues of cue "NPCs" & q number of cues of cue "NPC A" & q number of cues of cue "NPC B" & q number of cues of cue "NPC C" & q number of cues of cue "NPC D")
end tell
repeat
	set newTarg to (choose from list partyList & "——————————" & npcList with title "Place Token on Map" with prompt "Select Token..." default items "None" OK button name {"Place"} cancel button name {"Cancel | End Loop"}) as string
	if newTarg is "false" then return
	tell application id "com.figure53.QLab.4" to tell front workspace
		if newTarg is not "false" then
			start cue newTarg
		end if
	end tell
end repeat