module(..., package.seeall)

function new()
	local localGroup = display.newGroup()
	--> This is how we start every single file or "screen" in our folder, except for main.lua
	-- and director.lua
	--> director.lua is NEVER modified, while only one line in main.lua changes, described in that file
------------------------------------------------------------------------------
------------------------------------------------------------------------------

-- local background = display.newImage ("bluebackground.png")
-- localGroup:insert(background)

local bluebutton = display.newImage ("bluebutton.png")
bluebutton.x = 160
bluebutton.y = 100
localGroup:insert(bluebutton)

local function pressblue (event)
	if event.phase == "ended" then
		print("pressblue")
		director:changeScene ("gallery")
	end
end
bluebutton:addEventListener ("touch", pressblue)

------------------------------------------------------------------------------
------------------------------------------------------------------------------
	return localGroup
end
--> This is how we end every file except for director and main, as mentioned in my first comment