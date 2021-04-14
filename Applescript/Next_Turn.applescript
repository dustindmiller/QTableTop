on getPositionOfItemInList(theItem, theList)
	repeat with a from 1 to count of theList
		set lastItem to item -1 of theList
		if item a of theList is theItem then return a
		if item -1 of theList is theItem then return false
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
if currentPlace is false then
	set nextTurn to item 1 of intiList
	set nextNextTurn to item 2 of intiList
else
	set nextTurn to item (currentPlace + 1) of intiList
	if nextTurn is last item of intiList then
		set nextNextTurn to item 1 of intiList
	else
		set nextNextTurn to item (currentPlace + 2) of intiList
	end if
end if

tell application id "com.figure53.QLab.4" to tell front workspace
	set cue target of cue "RIGHT" to cue nextTurn
	set cue target of cue "LEFT" to cue nextTurn
	set cue target of cue "UP" to cue nextTurn
	set cue target of cue "DOWN" to cue nextTurn
	set cue target of cue "UP RIGHT" to cue nextTurn
	set cue target of cue "UP LEFT" to cue nextTurn
	set cue target of cue "DOWN RIGHT" to cue nextTurn
	set cue target of cue "DOWN LEFT" to cue nextTurn
	set q name of cue "Target" to nextTurn
	set q name of cue "Initiative Tracker" to nextTurn
	set q name of cue "Next Turn" to nextNextTurn
	set q name of cue "Previous Turn" to currentTurn
	
	
end tell