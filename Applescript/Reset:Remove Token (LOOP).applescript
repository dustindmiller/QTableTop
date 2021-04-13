
tell application id "com.figure53.QLab.4" to tell front workspace
	if cue "ALL PARTY" is not running and cue "ALL NPCs" is not running then
		display dialog "No Active Tokens" with title "Target Token for Movement" with icon 2 buttons "OK" default button "OK" giving up after 5
		return
	else
		set partyList to ((q number of cues of cue "PARTY" where running = true) & (q number of cues of cue "PARTY A" where running = true) & (q number of cues of cue "PARTY B" where running = true) & (q number of cues of cue "PARTY C" where running = true) & (q number of cues of cue "PARTY D" where running = true))
		set beginning of partyList to "PARTY"
		set beginning of partyList to "——————————"
		set beginning of partyList to "All Tokens"
		
		set npcList to ((q number of cues of cue "NPCs" where running = true) & (q number of cues of cue "NPC A" where running = true) & (q number of cues of cue "NPC B" where running = true) & (q number of cues of cue "NPC C" where running = true) & (q number of cues of cue "NPC D" where running = true))
		set beginning of npcList to "NPCs"
	end if
end tell

display dialog "Reset or Remove?" with title "Token Reset/Remove" buttons {"Reset", "Remove", "Cancel"} default button "Reset" cancel button "Cancel"
set actionType to button returned of result
if actionType is "cancel" then return

if actionType is "Reset" then
	repeat
		set newTarg to (choose from list partyList & "——————————" & npcList with title "Reset Token Position" with prompt "Select Token..." default items "None" OK button name {"Reset"} cancel button name {"Cancel | End Loop"}) as string
		if newTarg is "false" then return
		tell application id "com.figure53.QLab.4" to tell front workspace
			if newTarg is not "false" then
				reset cue newTarg
				start cue newTarg
			end if
		end tell
	end repeat
else if actionType is "Remove" then
	
	repeat
		set newTarg to (choose from list partyList & "——————————" & npcList with title "Reset or Remove Token from Map" with prompt "Select Token..." default items "Reset" OK button name {"Remove"} cancel button name {"Cancel | End Loop"}) as string
		if newTarg is "false" then return
		if newTarg is "All Tokens" then set newTarg to "TOKENS"
		
		tell application id "com.figure53.QLab.4" to tell front workspace
			if newTarg is not "false" then
				panic cue newTarg
			end if
		end tell
	end repeat
	
end if
