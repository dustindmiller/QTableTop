tell application id "com.figure53.QLab.4" to tell front workspace
	set musicList to (q number of cues of cue "Music Playlists")
	set activePlaylist to (q name of cue "Music Toggle")
	set newTarg to (choose from list musicList with title "Music Playlist" with prompt "Select Playlist..." default items activePlaylist OK button name {"Toggle"} cancel button name {"Cancel"}) as string
	if newTarg is "false" then
		return
	else if cue ("Start " & newTarg) is running then
		start cue ("Stop " & newTarg)
		delay 0.1
		set q color of cue "Music Toggle" to "Orange"
		set q name of cue "Music Toggle" to "Deactivating " & newTarg
		delay 5
		set q color of cue "Music Toggle" to "mauve"
		set q name of cue "Music Toggle" to "No Active Playlist"
	else if cue ("Start " & newTarg) is not running and newTarg is not equal to activePlaylist then
		start cue newTarg
		if (cue ("Start " & activePlaylist) exists) and (cue ("Start " & activePlaylist) is running) then
			start cue ("Stop " & activePlaylist)
		end if
		delay 0.1
		set q color of cue "Music Toggle" to "green"
		set q name of cue "Music Toggle" to newTarg
	else if cue ("Start " & newTarg) is not running and newTarg is equal to activePlaylist then
		start cue newTarg
		delay 0.1
		set q color of cue "Music Toggle" to "green"
		set q name of cue "Music Toggle" to newTarg
	end if
end tell