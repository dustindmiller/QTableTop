tell application id "com.figure53.QLab.4" to tell front workspace
	if q name of cue "Handout Toggle" is not "No Active Handout" then
		set activeImage to q name of cue "Handout Toggle"
	else
		set activeImage to "None" as string
	end if
	set creatureList to (q number of cues of cue "Handouts")
	set newTarg to (choose from list creatureList with title "Toggle Handout" with prompt "Select Handout..." default items activeImage OK button name {"Toggle"} cancel button name {"Cancel"}) as string
	if newTarg is "false" then
		return

	else if cue newTarg is running
		hardStop cue newTarg
	else if (cue newTarg is not running) and (activeImage is "None")
		start cue newTarg
	else if (cue newTarg is not running) and (cue activeImage exists)
		start cue newTarg
		hardStop cue activeImage
	else if (cue activeImage exists) and (cue activeImage is running) then
		hardStop cue activeImage
	end if
	delay 0.1
	if cue newTarg is running then
		set q name of cue "Handout Toggle" to "Deactivating " & newTarg
		set q color of cue "Handout Toggle" to "Yellow"
	else
		set q name of cue "Handout Toggle" to "Not Active"
		set q color of cue "Handout Toggle" to "vermilion"
	end if
	delay 0.2
	if cue newTarg is running then
		set q name of cue "Handout Toggle" to newTarg
		set q color of cue "Handout Toggle" to "green"
	else
		set q name of cue "Handout Toggle" to "No Active Handout"
		set q color of cue "Handout Toggle" to "vermilion"
	end if
end tell
