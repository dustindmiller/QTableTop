tell application id "com.figure53.QLab.4" to tell front workspace
	repeat
		if cue "ALL PARTY" is not running and cue "ALL NPCs" is not running then
			display dialog "No active Tokens" with title "Target Token for Movement" with icon 2 buttons "OK" default button "OK" giving up after 5
			return
		else
			set partyList to ((q number of cues of cue "PARTY" where running = true) & (q number of cues of cue "PARTY A" where running = true) & (q number of cues of cue "PARTY B" where running = true) & (q number of cues of cue "PARTY C" where running = true) & (q number of cues of cue "PARTY D" where running = true))
			set beginning of partyList to "PARTY"
			set npcList to ((q number of cues of cue "NPCs" where running = true) & (q number of cues of cue "NPC A" where running = true) & (q number of cues of cue "NPC B" where running = true) & (q number of cues of cue "NPC C" where running = true) & (q number of cues of cue "NPC D" where running = true))
			set beginning of npcList to "NPCs"
			set newTarg to (choose from list partyList & "——————————" & npcList with title "Set Creature Condition" with prompt "Select Token..." default items "None" OK button name {"Place"} cancel button name {"Cancel | End Loop"}) as string
			if newTarg is "false" then return
			if newTarg is not "false" then
				set creatureCon to newTarg & " CON" as string
				set currentCON to notes of cue creatureCon
				set newConList to {"Normal", "Custom...", "Blinded", "Charmed", "Deafened", "Exhausted...", "Frightened", "Grappled", "Incapacitated", "Invisible", "Paralyzed", "Petrified", "Poisoned", "Prone", "Restrained", "Stunned", "Unconscious", "Dead"}
				set newCon to (choose from list newConList with title "Set Creature Condition" with prompt "Select Condition..." default items currentCON OK button name {"Set"} cancel button name {"Cancel | End Loop"}) as string
				if newCon is "false" then return
				if newCon is "Blinded" then
					set text of cue creatureCon to "BLIND"
				end if
				if newCon is "Normal" then
					set text of cue creatureCon to " "
				end if
				if newCon is "Charmed" then
					set text of cue creatureCon to "CHARM"
				end if
				if newCon is "Deafened" then
					set text of cue creatureCon to "DEAF"
				end if
				if newCon is "Exhausted..." then
					set exhaustList to {"Level I", "Level II", "Level III", "Level IV", "Level V", "Level VI"}
					set newLevel to (choose from list exhaustList with title "Creature Condition" with prompt "Set Level of Exhaustion..." default items "None" OK button name {"Set"} cancel button name {"Cancel"}) as string
					if newLevel is "Level I" then
						set text of cue creatureCon to "EX 1"
					end if
					if newLevel is "Level II" then
						set text of cue creatureCon to "EX 2"
					end if
					if newLevel is "Level III" then
						set text of cue creatureCon to "EX 3"
					end if
					if newLevel is "Level IV" then
						set text of cue creatureCon to "EX 4"
					end if
					if newLevel is "Level V" then
						set text of cue creatureCon to "EX 5"
					end if
					if newLevel is "Level VI" then
						set text of cue creatureCon to "EX 6 DEAD"
					end if
				end if
				if newCon is "Frightened" then
					set text of cue creatureCon to "FRIGHT"
				end if
				if newCon is "Grappled" then
					set text of cue creatureCon to "GRAPP"
				end if
				if newCon is "Incapacitated" then
					set text of cue creatureCon to "INCAP"
				end if
				if newCon is "Invisible" then
					set text of cue creatureCon to "INVIS"
				end if
				if newCon is "Paralyzed" then
					set text of cue creatureCon to "PARA"
				end if
				if newCon is "Petrified" then
					set text of cue creatureCon to "PETRI"
				end if
				if newCon is "Poisoned" then
					set text of cue creatureCon to "POISON"
				end if
				if newCon is "Prone" then
					set text of cue creatureCon to "PRONE"
				end if
				if newCon is "Restrained" then
					set text of cue creatureCon to "RESTR"
				end if
				if newCon is "Stunned" then
					set text of cue creatureCon to "STUN"
				end if
				if newCon is "Unconscious" then
					set text of cue creatureCon to "UNCON"
				end if
				if newCon is "Dead" then
					set text of cue creatureCon to "DEAD"
				end if
				if newCon is "Custom..." then
					set the customCon to the text returned of (display dialog "Custom Condition" default answer "")
					set text of cue creatureCon to customCon
				end if
				set notes of cue creatureCon to newCon
				
			end if
		end if
	end repeat
end tell