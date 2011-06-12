module(..., package.seeall)

function new()
	local localGroup = display.newGroup()
	--> This is how we start every single file or "screen" in our folder, except for main.lua
	-- and director.lua
	--> director.lua is NEVER modified, while only one line in main.lua changes, described in that file
------------------------------------------------------------------------------
------------------------------------------------------------------------------

-- Important! Add a background to the scroll view for a proper hit area
local background = display.newRect(0, 0, display.contentWidth, display.contentHeight)
background:setFillColor(210, 210, 210)
localGroup:insert(background)

--import the scrolling classes
local scrollView = require("scrollView") -- TODO: fix scrollbar looking weird, taking up full height

-- Setup a scrollable content group
-- local topBoundary = 0
-- local bottomBoundary = 0
-- local scrollView = scrollView.new{ top=topBoundary, bottom=bottomBoundary }
local scrollView = scrollView.new{}

-------------------------------------------

local tile = require("tile")

print("screen width: " .. display.contentWidth)
print("screen width / 3 = " .. (display.contentWidth / 3))

local data = {
	{image="image1.jpg", label="One", sound="audio1.mp3"},
	{image="image2.jpg", label="Two"},
	{image="image1.jpg", label="One"},
	{color={150, 255, 150}, label="Two", sound="audio2.mp3"},
	{image="image1.jpg", label="One"},
	{image="image2.jpg", label="Two"},
	{image="image1.jpg", label="One"},
	{image="image2.jpg", label="Two"},
	{label="Two"},
	{image="image1.jpg", label="One"}
}

-------------------------------------------

-- device settings
local colMax = 3
local colCount = 1
local scalePercent = .5
local scaleAmplifier = 2 -- can probably work this out programatically... round(1 % scalePercent)
local gutterSize = 2 -- pixels

-- grid init
local tileX = 0
local tileY = 0
local tileW = (display.contentWidth + colMax) / colMax
local tileH = tileW

-------------------------------------------

function incrementCol()
	colCount = colCount + 1
	tileX = tileX + tileW + gutterSize
end

function incrementRow()
	colCount = 1
	tileX = 0
	tileY = tileY + tileH + gutterSize
end

-------------------------------------------

-- local createButtonTile = tile.drawImageButtonTile(tileX, tileY, tileW, tileH, scrollView, "new.png", .5, scaleAmplifier, director)
local createButtonTile = display.newImage("new.png", tileX, tileY)
createButtonTile:scale(scalePercent, scalePercent)
createButtonTile.width = tileW * scaleAmplifier
createButtonTile.height = tileH * scaleAmplifier
createButtonTile.xOrigin = tileX + (tileW / 2)
createButtonTile.yOrigin = tileY + (tileH / 2)
scrollView:insert(createButtonTile)
-- localGroup:insert(createButtonTile)

local function pressRed (event)
	print("pressRed")
	if event.phase == "ended" then
		print("pressRed - ended")
		director:changeScene ("create")
	end
end
createButtonTile:addEventListener ("touch", pressRed)

localGroup:insert(scrollView)

------------------------------------------------------------------------------
------------------------------------------------------------------------------
	return localGroup
end
--> This is how we end every file except for director and main, as mentioned in my first comment