tell application id "com.figure53.QLab.4" to tell front workspace
	if q name of current cue list is "QTableTop - List" or q name of current cue list is "QTableTop - Cart" then
		set current cue list to first cue list whose q name is "Adventure Content"
		set q name of cue "Cue List Toggle" to "Adventure Content"
		return
	end if
	if q name of current cue list is "Adventure Content" then
		set current cue list to first cue list whose q name is "QTableTop - List"
		set q name of cue "Cue List Toggle" to "QTableTop - List"
		return
	end if
	return
end tell