tell application id "com.figure53.QLab.4" to tell front workspace
	if cue "Rain" is running then
		set defaultSelect to "Rain"
	end if
	if cue "Thunder" is running then
		set defaultSelect to "Thunder"
	end if
	if cue "Rain" is running and cue "Thunder" is running then
		set defaultSelect to "Rain & Thunder"
	end if
	if cue "Rain" is not running and cue "Thunder" is not running then
		set defaultSelect to "Rain & Thunder"
	end if
	start cue "Load Rain & Thunder"
	set toggleList to (display dialog "Select which to be toggled..." with title "Toggle Rain & Thunder" buttons {"Rain & Thunder", "Rain", "Thunder"} default button defaultSelect giving up after 5)
	set mySelection to button returned of toggleList
	if mySelection is "" then
		return
	else
		if cue mySelection is running then
			set q name of cue "Rain & Thunder Toggle" to "Deactivating " & mySelection
			set q color of cue "Rain & Thunder Toggle" to "orange"
		else
			set q name of cue "Rain & Thunder Toggle" to "Activating " & mySelection
			set q color of cue "Rain & Thunder Toggle" to "yellow"
		end if
		delay 0.5
		start cue mySelection
		delay 5.5
		if cue "Rain" is running then
			set q name of cue "Rain & Thunder Toggle" to "Rain Active"
			set q color of cue "Rain & Thunder Toggle" to "green"
		end if
		if cue "Thunder" is running then
			set q name of cue "Rain & Thunder Toggle" to "Thunder Active"
			set q color of cue "Rain & Thunder Toggle" to "green"
		end if
		if cue "Rain" is running and cue "Thunder" is running then
			set q name of cue "Rain & Thunder Toggle" to "Rain & Thunder Active"
			set q color of cue "Rain & Thunder Toggle" to "green"
		end if
		if cue "Rain" is not running and cue "Thunder" is not running then
			set q name of cue "Rain & Thunder Toggle" to "Not Active"
			set q color of cue "Rain & Thunder Toggle" to "lilac"
		end if
	end if
	##else if mySelection is "Grid & Paper" then
	##if cue mySelection is running then
	##	set q name of cue "Grid & Paper" to mySelection & " Fading Out"
	##set q color of cue "Grid & Paper" to "orange"
	##	else
	##	set q name of cue "Grid & Paper" to mySelection & " Fading Up"
	##	set q color of cue "Grid & Paper" to "yellow"
	##end if
	##delay 0.5
	##start cue mySelection
	##delay 5.5
	##if cue newTarg is running then
	##	set q name of cue "Maps & Masks" to newTarg & " Active"
	##	set q color of cue "Maps & Masks" to "green"
	##else
	##	set q name of cue "Maps & Masks" to "No Active Map"
	##set q color of cue "Maps & Masks" to "red"
	##end if
end tell