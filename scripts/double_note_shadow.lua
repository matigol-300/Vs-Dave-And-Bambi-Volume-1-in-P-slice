local dadGhostBool = true
local bfGhostBool = true
local hitNoteNum = 0
function bfGhostHide(bool) bfGhostBool = bool end
function dadGhostHide(bool) dadGhostBool = bool end
local function rgbToHex(array) return string.format('%.2x%.2x%.2x', array[1], array[2], array[3]) end
local function ghost(tag,ch,X,Y)
	makeAnimatedLuaSprite(tag, getProperty(ch..'.imageFile'):gsub(',.*', ''), getProperty(ch..'.x'), getProperty(ch..'.y'))
	local nameAnim = getProperty(ch..'.animation.frameName'):gsub('%.png$', '')
	addAnimationByPrefix(tag, 'animacion', nameAnim:gsub('0', '', 3), 25, false)
	addLuaSprite(tag,false)
	for _,i in pairs({'flipX','angle','offset.x','offset.y','scale.x','scale.y'}) do setProperty(tag..'.'..i, getProperty(ch..'.'..i)) end
	setProperty(tag..'.color', getColorFromHex(rgbToHex(getProperty(ch..'.healthColorArray'))))
	doTweenAlpha(tag..'_alpha',tag, 0, 0.7, 'sineInOut')
	doTweenX(tag..'_x', tag, getProperty(ch..'.x') + X, 0.5, 'cubeOut')
	doTweenY(tag..'_y', tag, getProperty(ch..'.y') + Y, 0.5, 'cubeOut')
	setObjectOrder(tag, getObjectOrder(ch..'Group') - 1)
end
function opponentNoteHit(id,d,t,s)
local strumTime = getPropertyFromGroup('notes', id, 'strumTime')    
	for i = 0, getProperty('notes.length')-1 do
		if i ~= id and not getPropertyFromGroup('notes', i, 'mustPress') and dadGhostBool then
		local otherStrumTime = getPropertyFromGroup('notes', i, 'strumTime')
		local otherNoteData = getPropertyFromGroup('notes', i, 'noteData')
		if math.abs(strumTime - otherStrumTime) < 0.05 and d ~= otherNoteData and not s then
			if d == 0 then ghost('dad_ghost', 'dad', -150, 0) end
			if d == 1 then ghost('dad_ghost', 'dad', 0, 150) end
			if d == 2 then ghost('dad_ghost', 'dad', 0, -150) end 
			if d == 3 then ghost('dad_ghost', 'dad', 150, 0) end
			break
end
end
end
end
function goodNoteHit(id, direction, noteType, isSustainNote)
local strumTime = getPropertyFromGroup("notes", id, "strumTime")
for i = 0, getProperty('notes.length')-1 do
     if i ~= id and getPropertyFromGroup('notes', i, 'mustPress') and bfGhostBool then
        local otherStrumTime = getPropertyFromGroup('notes', i, 'strumTime')
        local otherNoteData = getPropertyFromGroup('notes', i, 'noteData')
        if math.abs(strumTime - otherStrumTime) < 0.05 and direction ~= otherNoteData and not isSustainNote then
   		    if direction == 0 then ghost('bf_ghost', 'boyfriend', -150, 0) end
			if direction == 1 then ghost('bf_ghost', 'boyfriend', 0, 150) end
			if direction == 2 then ghost('bf_ghost', 'boyfriend', 0, -150) end 
			if direction == 3 then ghost('bf_ghost', 'boyfriend', 150, 0) end
        	break
end
end 
end
end