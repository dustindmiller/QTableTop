## SET HANDOUT NAME
display dialog "Handout Name" default answer "" with title "Handout Merchant" with icon 1 buttons {"Cancel", "Set"} default button "Set" cancel button "Cancel"
set handoutName to text returned of result

## SELECT HANDOUT IMAGE FILE
set theTarget to choose file with prompt "Please select " & handoutName & " Handout image file (PNG or Transparent Backgrounds Supported)"

## TELL QLAB TO DO STUFF
tell application id "com.figure53.QLab.4" to tell front workspace

    ## SET ORIGINATING CUE LIST
    set originalCueList to q name of current cue list
    
    ## MAKES QTableTop - List ACTIVE FOR CUE CREATION
	set current cue list to first cue list whose q name is "QTableTop - List"

    ## MAKE HANDOUT VIDEO CUE
    make type "Video"
	set handoutCue to last item of (selected as list)
	set the file target of handoutCue to theTarget
	set q name of handoutCue to handoutName
	set the q number of handoutCue to handoutName & " Handout"
	set opacity of handoutCue to 1.00scr
	set layer of handoutCue to 1000
	set full screen of handoutCue to true

    ## MOVE HANDOUT VIDEO CUE TO HANDOUT GROUP CUE
    set handoutGroup to cue "Handouts"
	set cuesToGroup to {handoutCue}
	repeat with eachCue in cuesToGroup
		set eachCueID to uniqueID of eachCue
		move cue id eachCueID of parent of eachCue to end of handoutGroup
	end repeat

    ## COLLAPSE HANOUT GROUP CUE
    collapse handoutGroup

    ## RETURNS TO PREVIOUS ACTIVE CUE LIST
	set current cue list to first cue list whose q name is originalCueList
	return

end tell