tell application id "com.figure53.QLab.4" to tell front workspace
	set doubleChecker to (display dialog "Please Confirm Total NPC Condition Reset..." with title "Reset NPC Conditions" buttons {"Confirm", "Cancel"} default button "Confirm" giving up after 5)
	set doubleCheck to button returned of doubleChecker
	if doubleCheck is "Cancel" then return
	if doubleCheck is "Confirm" then
		set npcList to (q number of cues of cue "NPCs" & q number of cues of cue "NPC A" & q number of cues of cue "NPC B" & q number of cues of cue "NPC C" & q number of cues of cue "NPC D")
		repeat with message in npcList
			set text of cue (message & " CON") to " "
			set notes of cue (message & " CON") to "Normal"
			
		end repeat
	end if
end tell