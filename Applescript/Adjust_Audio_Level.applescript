tell application id "com.figure53.QLab.4" to tell front workspace
	set cueChoose to (display dialog "Select Sound Source..." with title "Adjust Audio Level" buttons {"Music", "SFX", "Cancel"} default button "Cancel" giving up after 5)
	set cueChoice to button returned of cueChoose as string
	if cueChoice is "Cancel" then
		return
	else
		set volAdjust to (display dialog "Select Level..." with title "Adjust " & cueChoice & " Level" buttons {"+5db", "-5db", "Cancel"} default button "Cancel" giving up after 5)
		set adjustLevel to button returned of volAdjust as string
		if adjustLevel is "Cancel" then return
		if adjustLevel is "+5db" then
			start cue (cueChoice & " +5")
		else if adjustLevel is "-5db" then
			start cue (cueChoice & " -5")
		end if
	end if
end tell