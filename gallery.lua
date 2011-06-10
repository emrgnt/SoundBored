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

--import the scrolling classes
local scrollView = require("scrollView") -- TODO: fix scrollbar looking weird, taking up full height
local util = require("util")

print(display.screenOriginY + display.contentHeight)

-- Setup a scrollable content group
-- local topBoundary = 0
-- local bottomBoundary = 0
-- local scrollView = scrollView.new{ top=topBoundary, bottom=bottomBoundary }
local scrollView = scrollView.new{}

---------------------------------
--> BEGIN dan code
---------------------------------

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

function incrementCol()
	colCount = colCount + 1
	tileX = tileX + tileW + gutterSize
end

function incrementRow()
	colCount = 1
	tileX = 0
	tileY = tileY + tileH + gutterSize
end

local createButtonTile = tile.drawImageButtonTile(tileX, tileY, tileW, tileH, scrollView, "new.png", .5, scaleAmplifier)
incrementCol()

for i=2,#data do
	-- has image
	if data[i-1]["image"] then
		data[i-1]["tile"] = tile.drawImageTile(tileX, tileY, tileW, tileH, scrollView, data[i-1]["sound"], data[i-1]["image"], scalePercent, scaleAmplifier)
		
	-- has colour
	elseif data[i-1]["color"] then
		data[i-1]["tile"] = tile.drawColorTile(tileX, tileY, tileW, tileH, scrollView, data[i-1]["sound"], data[i-1]["color"])

	-- has neither
	else
		data[i-1]["tile"] = tile.drawColorTile(tileX, tileY, tileW, tileH, scrollView, data[i-1]["sound"], {200, 200, 200})
	end
	
	-- next in row
	if colCount < colMax then
		incrementCol()
	-- new row
	else
		incrementRow()
	end
end

---------------------------------
--> END dan code
---------------------------------

-- -- add some text to the scrolling screen
-- local lotsOfText = "Lorem ipsum dolor sit amet, consectetur adipiscing elit. Curabitur imperdiet consectetur euismod. Phasellus non ipsum vel eros vestibulum consequat. Integer convallis quam id urna tristique eu viverra risus eleifend.\n\nAenean suscipit placerat venenatis. Pellentesque faucibus venenatis eleifend. Nam lorem felis, rhoncus vel rutrum quis, tincidunt in sapien. Proin eu elit tortor. Nam ut mauris pellentesque justo vulputate convallis eu vitae metus. Praesent mauris eros, hendrerit ac convallis vel, cursus quis sem. Lorem ipsum dolor sit amet, consectetur adipiscing elit. Quisque fermentum, dui in vehicula dapibus, lorem nisi placerat turpis, quis gravida elit lectus eget nibh. Mauris molestie auctor facilisis.\n\nCurabitur lorem mi, molestie eget tincidunt quis, blandit a libero. Cras a lorem sed purus gravida rhoncus. Cras vel risus dolor, at accumsan nisi. Morbi sit amet sem purus, ut tempor mauris.\n\nLorem ipsum dolor sit amet, consectetur adipiscing elit. Curabitur imperdiet consectetur euismod. Phasellus non ipsum vel eros vestibulum consequat. Integer convallis quam id urna tristique eu viverra risus eleifend.\n\nAenean suscipit placerat venenatis. Pellentesque faucibus venenatis eleifend. Nam lorem felis, rhoncus vel rutrum quis, tincidunt in sapien. Proin eu elit tortor. Nam ut mauris pellentesque justo vulputate convallis eu vitae metus. Praesent mauris eros, hendrerit ac convallis vel, cursus quis sem. Lorem ipsum dolor sit amet, consectetur adipiscing elit. Quisque fermentum, dui in vehicula dapibus, lorem nisi placerat turpis, quis gravida elit lectus eget nibh. Mauris molestie auctor facilisis.\n\nCurabitur lorem mi, molestie eget tincidunt quis, blandit a libero. Cras a lorem sed purus gravida rhoncus. Cras vel risus dolor, at accumsan nisi. Morbi sit amet sem purus, ut tempor mauris. "
-- 
-- local lotsOfTextObject = util.wrappedText( lotsOfText, 39, 14, native.systemFont, {0,0,0} )
-- scrollView:insert(lotsOfTextObject)
-- lotsOfTextObject.x = 24
-- lotsOfTextObject.y = math.floor(myText.y + myText.height)

-- Important! Add a background to the scroll view for a proper hit area
local scrollBackground = display.newRect(0, 0, display.contentWidth, scrollView.height+64)
scrollBackground:setFillColor(255, 255, 255)
scrollView:insert(1, scrollBackground)

scrollView:addScrollBar()


------------------------------------------------------------------------------
------------------------------------------------------------------------------
	return localGroup
end
--> This is how we end every file except for director and main, as mentioned in my first comment