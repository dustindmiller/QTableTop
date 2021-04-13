on getPositionOfItemInList(theItem, theList)
	repeat with a from 1 to count of theList
		if item a of theList is theItem then return a
	end repeat
	return 0
end getPositionOfItemInList


tell application id "com.figure53.QLab.4" to tell front workspace
	if q name of cue "Initiative Tracker" is "No Active Combat" then return
	set currentTurn to q name of cue "Target"
	set currentTIDs to AppleScript's text item delimiters
	set AppleScript's text item delimiters to " | " -- Choose your delimiter
	set currentInit to notes of cue "Initiative Tracker"
	set intiList to every text item of currentInit
	set AppleScript's text item delimiters to currentTIDs
	
end tell

set currentPlace to getPositionOfItemInList(currentTurn, intiList)
if currentPlace is 1 then
	set prevTurn to item -1 of intiList
	set prevPrevTurn to item -2 of intiList
else
	set prevTurn to item (currentPlace - 1) of intiList
	if prevTurn is first item of intiList then
		set prevPrevTurn to item -1 of intiList
	else
		set prevPrevTurn to item (currentPlace - 2) of intiList
	end if
end if


tell application id "com.figure53.QLab.4" to tell front workspace
	set cue target of cue "RIGHT" to cue prevTurn
	set cue target of cue "LEFT" to cue prevTurn
	set cue target of cue "UP" to cue prevTurn
	set cue target of cue "DOWN" to cue prevTurn
	set cue target of cue "UP RIGHT" to cue prevTurn
	set cue target of cue "UP LEFT" to cue prevTurn
	set cue target of cue "DOWN RIGHT" to cue prevTurn
	set cue target of cue "DOWN LEFT" to cue prevTurn
	set q name of cue "Target" to prevTurn
	set q name of cue "Initiative Tracker" to prevTurn
	set q name of cue "Previous Turn" to prevPrevTurn
	set q name of cue "Next Turn" to currentTurn
	
end tell