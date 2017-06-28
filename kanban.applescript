
# 
# Window Names
# ***

# USER SETTINGS
# HERE. Choose names for your lists 
set Wn1 to "Ideas"
set Wn2 to "Todo"
set Wn3 to "Doing"
set Wn4 to "Done"



# No Need to Change Anything Below
# ***
# ***
# ***


# WIDTH CONFIGURATION
# ***

# Get Width of the Screen
tell application "Finder"
	set myscreen to get bounds of window of desktop
end tell

# Width Windows Groups
set Aw to ((item 3 of myscreen) / 4) + 40 + 1
set Bw to ((item 3 of myscreen) / 4) - 40 + 1

# Horizontal Coordinates
set Pw2 to (Bw - 1)
set Pw3 to (Bw - 1) + (Aw - 1)
set Pw4 to (Bw - 1) + (Aw - 1) + (Aw - 1)

# Putting Together
set wins to {}
set wins to wins & {{name:Wn1, width:Bw - 1, height:380, pos1:0, pos2:0}}
set wins to wins & {{name:Wn2, width:Aw - 1, height:380, pos1:Pw2, pos2:0}}
set wins to wins & {{name:Wn3, width:Aw - 1, height:380, pos1:Pw3, pos2:0}}
set wins to wins & {{name:Wn4, width:Bw - 1, height:380, pos1:Pw4, pos2:0}}


# OPEN
# ***
tell application "Reminders" to quit
tell application "Reminders"
	set theWindow to the first item of "Reminders"
	
	repeat with T from 1 to count of wins
		show list (name of item T of wins)
		activate (name of item T of wins)
		
		tell application "System Events" to tell process "Reminders"
			click menu item "Open List in New Window" of menu 1 of menu bar item "Window" of menu bar 1
			click menu item "Reminders" of menu 1 of menu bar item "Window" of menu bar 1
		end tell
		
	end repeat
	
	# minimize main window
	tell application "Reminders"
		set miniaturized of window 1 to true
	end tell
	
end tell



# POSITION 
# ***
tell application "System Events" to tell application process "Reminders"
	
	# Get Windows ID with Right Name Names
	# set WindowsNumbers to 
	repeat with N from 1 to count of {1, 2, 3, 4, 5, 6, 7, 8, 9, 10}
		try
			set wname to name of window N as text
			
			# Find & Set Coordinates for this Window
			repeat with T from 1 to count of wins
				set t_name to (name of item T of wins)
				set pos1 to (pos1 of item T of wins)
				set pos2 to (pos2 of item T of wins)
				set height to (height of item T of wins)
				set width to (width of item T of wins)
				
				if (wname contains t_name) then
					set position of window N to {pos1, pos2}
					set size of window N to {width, height}
				end if
			end repeat
			
		end try
	end repeat
	
end tell