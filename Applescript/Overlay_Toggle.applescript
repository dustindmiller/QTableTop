tell application id "com.figure53.QLab.4" to tell front workspace
	set contentName to "Overlay"
	set mapNameList to (q number of cues of cue (contentName & "s"))
	set activeMap to q name of cue (contentName & " Toggle")
	set newTarg to (choose from list mapNameList with title "Toggle Overlay" with prompt "Select Overlay..." default items activeMap OK button name {"Toggle"} cancel button name {"Cancel"}) as string
	if newTarg is "Cancel" then
		return
	else
		if cue newTarg is running then
			set cue target of cue (contentName & " Fade Down") to cue newTarg
			set q name of cue (contentName & " Toggle") to "Deactivating " & newTarg
			set q color of cue (contentName & " Toggle") to "orange"
			start cue (contentName & " Fade Down")
		else
			set cue target of cue (contentName & " Fade Up") to cue newTarg
			set q name of cue (contentName & " Toggle") to "Activating " & newTarg
			set q color of cue (contentName & " Toggle") to "yellow"
			delay 0.1
			start cue newTarg
			start cue (contentName & " Fade Up")
		end if
	end if
	
	if (cue activeMap exists) and (cue activeMap is running) then
		start cue (contentName & " Fade Down")
	end if
	delay 5
	if cue newTarg is running then
		set q name of cue (contentName & " Toggle") to newTarg
		set q color of cue (contentName & " Toggle") to "green"
		set cue target of cue (contentName & " Fade Down") to cue newTarg
	else
		set q name of cue (contentName & " Toggle") to "No Active " & contentName
		set q color of cue (contentName & " Toggle") to "skyblue"
		
	end if
end tell