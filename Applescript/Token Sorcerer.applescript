tell application id "com.figure53.QLab.4" to tell front workspace
	
	set originalCueList to q name of current cue list
	
	
	## SELECT WHAT ACTION YOU WISH TO PERFORM
	display dialog "Create or Modify?" with title "Token Sorcerer" with icon 1 buttons {"Create", "Modify", "Cancel"} default button "Create" cancel button "Cancel"
	set actionType to button returned of result
	if actionType is "cancel" then return
	
	if actionType is "Create" then
		## SELECT WHAT GROUP THE TOKEN BELONGS IN
		display dialog "Token Group..." with title "New Token Wizard" with icon 1 buttons {"PARTY", "NPCs", "Cancel"} default button "PARTY" cancel button "Cancel"
		set tokenType to button returned of result
		if tokenType is "cancel" then return
		
		## SELECT TOKEN IMAGE FILE
		set theTarget to choose file with prompt "Please select Token image file (100x100 pixels, PNG only!)"
		
		## SET TOKEN NAME
		display dialog "Token Name" default answer "" with title "Token Wizard" with icon 1 buttons {"Cancel", "Set"} default button "Set" cancel button "Cancel"
		set tokenName to text returned of result
		
		## SELECT CREATURE SIZE
		set sizeList to {"Small/Medium", "Large", "Huge", "Gargantuan"}
		set tokenSizeChoice to (choose from list sizeList with title "Token Wizard" with prompt "Creature Size" default items "Small/Medium") as string
		if tokenSizeChoice is "false" then
			return
		else if tokenSizeChoice is "Small/Medium" then
			set tokenSize to 0.5
			set tokenPos to -25
			set tokenShift to 20
		else if tokenSizeChoice is "Large" then
			set tokenSize to 1
			set tokenPos to 0
			set tokenShift to 40
		else if tokenSizeChoice is "Huge" then
			set tokenSize to 1.5
			set tokenPos to 25
			set tokenShift to 60
		else if tokenSizeChoice is "Gargantuan" then
			set tokenSize to 2
			set tokenPos to 50
			set tokenShift to 80
		end if
		
		## COUNT OF NPCs TO CREATE
		if tokenType is "NPCs" then
			display dialog "Token Count" default answer "1" with title "Token Wizard" with icon 1 buttons {"Cancel", "Create"} default button "Create" cancel button "Cancel"
			set tokenCount to text returned of result
		else
			set tokenCount to "1"
		end if
		
		if tokenCount is "1" then
			
			## MAKES QTableTop - List ACTIVE FOR CUE CREATION
			set current cue list to first cue list whose q name is "QTableTop - List"
			
			## MAKE TOKEN VIDEO CUE
			make type "Video"
			set tokenCue to last item of (selected as list)
			set the file target of tokenCue to theTarget
			set q name of tokenCue to "Token"
			set the q number of tokenCue to tokenName & " TOKEN"
			set layer of tokenCue to 600
			set full screen of tokenCue to false
			set scale x of tokenCue to tokenSize
			set scale y of tokenCue to tokenSize
			set translation x of tokenCue to tokenPos
			set translation y of tokenCue to tokenPos
			
			## MAKE CONDITION TEXT CUE
			make type "Text"
			set conCue to last item of (selected as list)
			set layer of conCue to 601
			set q name of conCue to "Condition"
			set the q number of conCue to tokenName & " CON"
			set scale x of conCue to 0.4
			set scale y of conCue to 0.4
			set translation x of conCue to tokenPos
			set translation y of conCue to tokenPos
			set text of conCue to ""
			
			## MAKE LABEL TEXT CUE
			make type "Text"
			set labelCue to last item of (selected as list)
			set layer of labelCue to 601
			set q name of labelCue to "Label"
			set the q number of labelCue to tokenName & " LABEL"
			set scale x of labelCue to 0.4
			set scale y of labelCue to 0.4
			set translation x of labelCue to (tokenPos + tokenShift)
			set translation y of labelCue to (tokenPos - tokenShift)
			set text of labelCue to ""
			
			## MAKE MOVE GROUP TEXT CUE
			make type "Text"
			set moveCue to last item of (selected as list)
			set layer of moveCue to 602
			set q name of moveCue to "Group"
			set the q number of moveCue to tokenName & " GROUP"
			set scale x of moveCue to 0.4
			set scale y of moveCue to 0.4
			set translation x of moveCue to (tokenPos - tokenShift)
			set translation y of moveCue to (tokenPos + tokenShift)
			set text of moveCue to ""
			
			## MOVE ALL NEW CUES TO TOKEN GROUP CUE
			set cuesToGroup to {tokenCue, conCue, labelCue, moveCue}
			make type "Group"
			set groupCue to last item of (selected as list)
			set q number of groupCue to tokenName
			set mode of groupCue to fire_all
			set q name of groupCue to tokenName
			repeat with eachCue in cuesToGroup
				set eachCueID to uniqueID of eachCue
				move cue id eachCueID of parent of eachCue to end of groupCue
			end repeat
			collapse groupCue
			
			## MOVE NEW TOKEN TO PARTY OR NPC GROUP
			set cueID to uniqueID of groupCue
			move cue id cueID of parent of groupCue to end of cue tokenType
			
		else if tokenCount is not "1" then
			set tokenNum to 1
			repeat
				if exists cue (tokenName & " " & tokenNum) then
					set tokenNum to (tokenNum + 1)
				else
					exit repeat
				end if
			end repeat
			
			## MAKES QTableTop - List ACTIVE FOR CUE CREATION
			set current cue list to first cue list whose q name is "QTableTop - List"
			
			repeat tokenCount times
				
				## MAKE TOKEN VIDEO CUE
				make type "Video"
				set tokenCue to last item of (selected as list)
				set the file target of tokenCue to theTarget
				set q name of tokenCue to "Token"
				set the q number of tokenCue to tokenName & " " & tokenNum & " TOKEN"
				set layer of tokenCue to 600
				set full screen of tokenCue to false
				set scale x of tokenCue to tokenSize
				set scale y of tokenCue to tokenSize
				set translation x of tokenCue to tokenPos
				set translation y of tokenCue to tokenPos
				
				## MAKE CONDITION TEXT CUE
				make type "Text"
				set conCue to last item of (selected as list)
				set layer of conCue to 601
				set q name of conCue to "Condition"
				set the q number of conCue to tokenName & " " & tokenNum & " CON"
				set scale x of conCue to 0.4
				set scale y of conCue to 0.4
				set translation x of conCue to tokenPos
				set translation y of conCue to tokenPos
				set text of conCue to ""
				
				## MAKE LABEL TEXT CUE
				make type "Text"
				set labelCue to last item of (selected as list)
				set layer of labelCue to 601
				set q name of labelCue to "Label"
				set the q number of labelCue to tokenName & " " & tokenNum & " LABEL"
				set scale x of labelCue to 0.4
				set scale y of labelCue to 0.4
				set translation x of labelCue to (tokenPos + tokenShift)
				set translation y of labelCue to (tokenPos - tokenShift)
				set text of labelCue to tokenNum
				
				## MAKE MOVE GROUP TEXT CUE
				make type "Text"
				set moveCue to last item of (selected as list)
				set layer of moveCue to 602
				set q name of moveCue to "Group"
				set the q number of moveCue to tokenName & " " & tokenNum & " GROUP"
				set scale x of moveCue to 0.4
				set scale y of moveCue to 0.4
				set translation x of moveCue to (tokenPos - tokenShift)
				set translation y of moveCue to (tokenPos + tokenShift)
				set text of moveCue to ""
				
				## MOVE ALL NEW CUES TO TOKEN GROUP CUE
				set cuesToGroup to {tokenCue, conCue, labelCue, moveCue}
				make type "Group"
				set groupCue to last item of (selected as list)
				set q number of groupCue to tokenName & " " & tokenNum
				set mode of groupCue to fire_all
				set q name of groupCue to tokenName & " " & tokenNum
				repeat with eachCue in cuesToGroup
					set eachCueID to uniqueID of eachCue
					move cue id eachCueID of parent of eachCue to end of groupCue
				end repeat
				collapse groupCue
				
				## MOVE NEW TOKEN TO PARTY OR NPC GROUP
				set cueID to uniqueID of groupCue
				move cue id cueID of parent of groupCue to end of cue tokenType
				
				set tokenNum to (tokenNum + 1)
			end repeat
			
		end if
		
	else if actionType is "Modify" then
		set tokenList to (q number of cues of cue "PARTY" & q number of cues of cue "PARTY A" & q number of cues of cue "PARTY B" & q number of cues of cue "PARTY C" & q number of cues of cue "PARTY D" & q number of cues of cue "NPCs" & q number of cues of cue "NPC A" & q number of cues of cue "NPC B" & q number of cues of cue "NPC C" & q number of cues of cue "NPC D")
		set partyList to (q number of cues of cue "PARTY" & q number of cues of cue "PARTY A" & q number of cues of cue "PARTY B" & q number of cues of cue "PARTY C" & q number of cues of cue "PARTY D")
		set npcList to (q number of cues of cue "NPCs" & q number of cues of cue "NPC A" & q number of cues of cue "NPC B" & q number of cues of cue "NPC C" & q number of cues of cue "NPC D")
		set toggleList to (display dialog "Select Group" with title "Token Setup" buttons {"All Tokens", "Party", "NPCs"} default button "All Tokens" giving up after 5)
		set mySelection to button returned of toggleList as string
		
		if mySelection is "" then
			return
		else if mySelection is "All Tokens" then
			set selectList to tokenList
		else if mySelection is "Party" then
			set selectList to partyList
		else if mySelection is "NPCs" then
			set selectList to npcList
		end if
		
		if mySelection is not "All Tokens" then
			set choiceList to (display dialog "Which Tokens?" with title "Token Setup" buttons {"Individual Token", "All Tokens"} default button "All Tokens" giving up after 5)
			set mySelect to button returned of choiceList as string
			if mySelect is not "All Tokens" then
				set newTarg to (choose from list selectList with title "Token Setup" with prompt "Select Token..." default items "None" OK button name {"Select"} cancel button name {"Cancel"}) as string
			else if mySelect is "All Tokens" then
				set newTarg to ""
			else if mySelect is "false" then
				return
			end if
		end if
		
		if newTarg is not "" then
			set commandList to (display dialog "Select Task" with title "Token Setup" buttons {"Token Positions", "Token Cue Names", "Manual Move"} default button "Token Positions" giving up after 5)
			set myChoice to button returned of commandList as string
		else
			set commandList to (display dialog "Select Task" with title "Token Setup" buttons {"Token Positions", "Token Cue Names"} default button "Token Positions" giving up after 5)
			set myChoice to button returned of commandList as string
		end if
		
		if myChoice is "" then
			return
		else if myChoice is "Token Positions" and newTarg is "" then
			
			repeat with message in selectList
				set currentPosX to (translation x of cue (message & " TOKEN")) as real
				set currentPosY to (translation y of cue (message & " TOKEN")) as real
				
				if scale x of cue (message & " TOKEN") is 1.0 then
					set roundX to (round (currentPosX / 50))
					set roundY to (round (currentPosY / 50))
					set translation x of cue (message & " TOKEN") to (roundX * 50)
					set translation y of cue (message & " TOKEN") to (roundY * 50)
				else
					set roundX to (round ((currentPosX - 25) / 50))
					set roundY to (round ((currentPosY - 25) / 50))
					set translation x of cue (message & " TOKEN") to ((roundX * 50) + 25)
					set translation y of cue (message & " TOKEN") to ((roundY * 50) + 25)
				end if
				
				set translation x of cue (message & " CON") to translation x of cue (message & " TOKEN")
				set translation y of cue (message & " CON") to translation y of cue (message & " TOKEN")
				
				if exists cue (message & " LABEL") then
					if scale x of cue (message & " TOKEN") is 1.0 then
						set translation x of cue (message & " LABEL") to ((translation x of cue (message & " TOKEN")) + 40)
						set translation y of cue (message & " LABEL") to ((translation y of cue (message & " TOKEN")) - 40)
					else
						set translation x of cue (message & " LABEL") to ((translation x of cue (message & " TOKEN")) + 20)
						set translation y of cue (message & " LABEL") to ((translation y of cue (message & " TOKEN")) - 20)
					end if
				end if
				if exists cue (message & " GROUP") then
					if scale x of cue (message & " TOKEN") is 1.0 then
						set translation x of cue (message & " GROUP") to ((translation x of cue (message & " TOKEN")) - 40)
						set translation y of cue (message & " GROUP") to ((translation y of cue (message & " TOKEN")) + 40)
					else
						set translation x of cue (message & " GROUP") to ((translation x of cue (message & " TOKEN")) - 20)
						set translation y of cue (message & " GROUP") to ((translation y of cue (message & " TOKEN")) + 20)
					end if
				end if
			end repeat
			
		else if myChoice is "Token Positions" and newTarg is not "" then
			
			
			set currentPosX to (translation x of cue (newTarg & " TOKEN")) as real
			set currentPosY to (translation y of cue (newTarg & " TOKEN")) as real
			
			if scale x of cue (newTarg & " TOKEN") is 1.0 then
				set roundX to (round (currentPosX / 50))
				set roundY to (round (currentPosY / 50))
				set translation x of cue (newTarg & " TOKEN") to (roundX * 50)
				set translation y of cue (newTarg & " TOKEN") to (roundY * 50)
			else
				set roundX to (round ((currentPosX - 25) / 50))
				set roundY to (round ((currentPosY - 25) / 50))
				set translation x of cue (newTarg & " TOKEN") to ((roundX * 50) + 25)
				set translation y of cue (newTarg & " TOKEN") to ((roundY * 50) + 25)
			end if
			
			set translation x of cue (newTarg & " CON") to translation x of cue (newTarg & " TOKEN")
			set translation y of cue (newTarg & " CON") to translation y of cue (newTarg & " TOKEN")
			
			if exists cue (newTarg & " LABEL") then
				if scale x of cue (newTarg & " TOKEN") is 1.0 then
					set translation x of cue (newTarg & " LABEL") to ((translation x of cue (newTarg & " TOKEN")) + 40)
					set translation y of cue (newTarg & " LABEL") to ((translation y of cue (newTarg & " TOKEN")) - 40)
				else
					set translation x of cue (newTarg & " LABEL") to ((translation x of cue (newTarg & " TOKEN")) + 20)
					set translation y of cue (newTarg & " LABEL") to ((translation y of cue (newTarg & " TOKEN")) - 20)
				end if
			end if
			if exists cue (newTarg & " GROUP") then
				if scale x of cue (newTarg & " TOKEN") is 1.0 then
					set translation x of cue (newTarg & " GROUP") to ((translation x of cue (newTarg & " TOKEN")) - 40)
					set translation y of cue (newTarg & " GROUP") to ((translation y of cue (newTarg & " TOKEN")) + 40)
				else
					set translation x of cue (newTarg & " GROUP") to ((translation x of cue (newTarg & " TOKEN")) - 20)
					set translation y of cue (newTarg & " GROUP") to ((translation y of cue (newTarg & " TOKEN")) + 20)
				end if
			end if
			
		else if myChoice is "Token Cue Names" and newTarg is "" then
			
			repeat with message in selectList
				set thisCue to message as string
				set q name of cue thisCue to thisCue
				set theList to cues of cue thisCue
				
				repeat with message in theList
					set eachCue to uniqueID of message
					
					if q name of cue id eachCue is "Token" then
						set q number of cue id eachCue to thisCue & " TOKEN"
					else if q name of cue id eachCue is "Condition" then
						set q number of cue id eachCue to thisCue & " CON"
					else if q name of cue id eachCue is "Label" then
						set q number of cue id eachCue to thisCue & " LABEL"
					else if q name of cue id eachCue is "Group" then
						set s to quoted form of thisCue
						do shell script "sed s/[a-zA-Z\\']//g <<< " & s
						set dx to the result
						set numList to {}
						repeat with i from 1 to count of words in dx
							set this_item to word i of dx
							try
								set this_item to this_item as number
								set the end of numList to this_item
							end try
						end repeat
						
						set text of cue (thisCue & " LABEL") to numList as string
						
						set q number of cue id eachCue to thisCue & " GROUP"
					else
						return
					end if
					
				end repeat
				
				
			end repeat
			
		else if myChoice is "Token Cue Names" and newTarg is not "" then
			
			set thisCue to newTarg as string
			set q name of cue thisCue to thisCue
			set theList to cues of cue thisCue
			
			repeat with message in theList
				set eachCue to uniqueID of message
				
				if q name of cue id eachCue is "Token" then
					set q number of cue id eachCue to thisCue & " TOKEN"
				else if q name of cue id eachCue is "Condition" then
					set q number of cue id eachCue to thisCue & " CON"
				else if q name of cue id eachCue is "Label" then
					set q number of cue id eachCue to thisCue & " LABEL"
				else if q name of cue id eachCue is "Group" then
					set s to quoted form of thisCue
					do shell script "sed s/[a-zA-Z\\']//g <<< " & s
					set dx to the result
					set numList to {}
					repeat with i from 1 to count of words in dx
						set this_item to word i of dx
						try
							set this_item to this_item as number
							set the end of numList to this_item
						end try
					end repeat
					
					set text of cue (thisCue & " LABEL") to numList as string
					
					set q number of cue id eachCue to thisCue & " GROUP"
				else
					return
				end if
				
			end repeat
		else if myChoice is "Manual Move" and newTarg is not "" then
			set selected to cue (newTarg & " TOKEN")
			return
		end if
		
		
	end if
	## RETURNS TO PREVIOUS ACTIVE CUE LIST
	set current cue list to first cue list whose q name is originalCueList
	return
end tell
