tell application id "com.figure53.QLab.4" to tell front workspace
	if cue "ALL PARTY" is not running and cue "ALL NPCs" is not running then
		display dialog "No Active Tokens" with title "Target Token for Movement" with icon 2 buttons "OK" default button "OK" giving up after 5
		return
	else
		set partyList to ((q number of cues of cue "PARTY" where running = true) & (q number of cues of cue "PARTY A" where running = true) & (q number of cues of cue "PARTY B" where running = true) & (q number of cues of cue "PARTY C" where running = true) & (q number of cues of cue "PARTY D" where running = true))
		if cue "ALL PARTY" is running then set beginning of partyList to "PARTY"

		## set beginning of partyList to "ÑÑÑÑÑÑÑÑÑÑ"
		## set beginning of partyList to "All Tokens"
		
		set npcList to ((q number of cues of cue "NPCs" where running = true) & (q number of cues of cue "NPC A" where running = true) & (q number of cues of cue "NPC B" where running = true) & (q number of cues of cue "NPC C" where running = true) & (q number of cues of cue "NPC D" where running = true))
		if cue "ALL NPCs" is running then set beginning of npcList to "NPCs"
		if cue "ALL PARTY" is running then set beginning of npcList to "ÑÑÑÑÑÑÑÑÑÑ"

	end if
end tell

display dialog "Reset or Remove?" with title "Token Reset/Remove" buttons {"Reset", "Remove", "Cancel"} default button "Reset" cancel button "Cancel"
set actionType to button returned of result
if actionType is "cancel" then return

if actionType is "Reset" then
	-- repeat
		set newTarg to (choose from list partyList & npcList with title "Reset Token Position" with prompt "Select Token..." default items "None" OK button name {"Reset"} cancel button name {"Cancel"} with multiple selections allowed)
		if newTarg is false then return
		-- if newTarg contains "All Tokens" then
		-- 	remove item 1 of partyList
		-- 	set newTarg to partyList
		-- 	set beginning of newTarg to npcList
		-- end if
		tell application id "com.figure53.QLab.4" to tell front workspace
			if newTarg is not "false" then
			repeat with message in newTarg
					reset cue message
					start cue message
				end repeat
			end if
		end tell
	-- end repeat

else if actionType is "Remove" then
	
	-- repeat
		set newTarg to (choose from list partyList & npcList with title "Reset or Remove Token from Map" with prompt "Select Token..." default items "Reset" OK button name {"Remove"} cancel button name {"Cancel"} with multiple selections allowed)
		if newTarg is false then return
		if newTarg contains "All Tokens" then
			set newTarg to partyList
			set beginning of newTarg to npcList
		end if

		
		tell application id "com.figure53.QLab.4" to tell front workspace
			if newTarg is not false then
				repeat with message in newTarg
					panic cue message
				end repeat
			end if
		end tell
	-- end repeat
	
end if
