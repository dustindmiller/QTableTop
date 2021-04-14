tell application id "com.figure53.QLab.4" to tell front workspace
	if cue "ALL PARTY" is not running and cue "ALL NPCs" is not running then
		display dialog "No Active Tokens" with title "Target Token for Movement" with icon 2 buttons "OK" default button "OK" giving up after 5
		return
	else
		set allPartyTokens to q number of cues of cue "ALL PARTY" where running = true
		set allNPCTokens to q number of cues of cue "ALL NPCs" where running = true
		set partyAndGroupsList to q number of cues of cue "PARTY + GROUPS" where running = true
		set partyList to q number of cues of cue "PARTY" where running = true
		set partyGroupList to q number of cues of cue "PARTY GROUPS" where running = true
		set partyGroupListContents to ((q number of cues of cue "PARTY A" where running = true) & (q number of cues of cue "PARTY B" where running = true) & (q number of cues of cue "PARTY C" where running = true) & (q number of cues of cue "PARTY D" where running = true))
		set npcsAndGroupsList to q number of cues of cue "NPCs + GROUPS" where running = true
		set npcList to q number of cues of cue "NPCs" where running = true
		set npcGroupList to q number of cues of cue "NPC GROUPS" where running = true
		set npcGroupListContents to ((q number of cues of cue "NPC A" where running = true) & (q number of cues of cue "NPC B" where running = true) & (q number of cues of cue "NPC C" where running = true) & (q number of cues of cue "NPC D" where running = true))
		if cue "ALL PARTY" is running then set beginning of allPartyTokens to "——————————"

		set beginning of allPartyTokens to "All Tokens"

		if cue "ALL NPCs" is running then set beginning of allNPCTokens to "——————————"

	end if
	
	set newTarg to (choose from list allPartyTokens & partyAndGroupsList & partyGroupList & partyGroupListContents & partyList & allNPCTokens & npcsAndGroupsList & npcGroupList & npcGroupListContents & npcList with title "Target Token For Movement" with prompt "Select Token..." default items "All Tokens" OK button name {"Target"} cancel button name {"Cancel"}) as string
	
	if newTarg is "false" then return
	if newTarg is "All Tokens" then set newTarg to "TOKENS"
	
	if newTarg is not "false" then
		set cue target of cue "RIGHT" to cue newTarg
		set cue target of cue "LEFT" to cue newTarg
		set cue target of cue "UP" to cue newTarg
		set cue target of cue "DOWN" to cue newTarg
		set cue target of cue "UP RIGHT" to cue newTarg
		set cue target of cue "UP LEFT" to cue newTarg
		set cue target of cue "DOWN RIGHT" to cue newTarg
		set cue target of cue "DOWN LEFT" to cue newTarg
		set q name of cue "Target" to newTarg
	end if
end tell