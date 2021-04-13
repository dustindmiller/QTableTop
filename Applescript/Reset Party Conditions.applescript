tell application id "com.figure53.QLab.4" to tell front workspace
	set doubleChecker to (display dialog "Please Confirm Total Party Condition Reset..." with title "Reset Party Conditions" buttons {"Confirm", "Cancel"} default button "Confirm" giving up after 5)
	set doubleCheck to button returned of doubleChecker
	if doubleCheck is "Cancel" then return
	if doubleCheck is "Confirm" then
		set partyList to (q number of cues of cue "PARTY" & q number of cues of cue "PARTY A" & q number of cues of cue "PARTY B" & q number of cues of cue "PARTY C" & q number of cues of cue "PARTY D")
		repeat with message in partyList
			set text of cue (message & " CON") to " "
			set notes of cue (message & " CON") to "Normal"
		end repeat
	end if
end tell