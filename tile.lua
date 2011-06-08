module (..., package.seeall)
-- local util = require("util")

function drawImageTile(tX, tY, tW, tH, tG, sound, image, scalePercent, scaleAmplifier)
	print("draw image tile: ")
	util.print_r(image)

	local tile = display.newImage(image, tX, tY)
	tile:scale(scalePercent, scalePercent)
	tile.width = tW * scaleAmplifier
	tile.height = tH * scaleAmplifier
	tile.xOrigin = tX + (tW / 2)
	tile.yOrigin = tY + (tH / 2)

	local tileGroup = display.newGroup()
	tileGroup:insert(tile)
	tG:insert(tile)
	
	assignSound(tile, sound)

	return tile
end

function drawColorTile(tX, tY, tW, tH, tG, sound, color)
	-- print("draw color tile: ")
	-- util.print_r(color)
	--> tile

	local tile = display.newRect(tX, tY, tW, tH)
	tile:setFillColor(color[1], color[2], color[3])

	local tileGroup = display.newGroup()
	tileGroup:insert(tile)
	tG:insert(tileGroup)

	assignSound(tile, sound)
	
	return tile
end

-- TODO: After making OO, click to stop (toggling an is-playing instance var after playSound, removing the event handling and adding one to stop, and vice versa)
function assignSound(t, s)
	if s == nil then
		s = "noaudio.mp3"
	end
	t:addEventListener ("touch", function(event)
		media.stopSound()
		media.playSound(s)
	end)
end
