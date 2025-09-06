local function rgbToHex(array) return string.format('%.2x%.2x%.2x', array[1], array[2], array[3]) end

local function colorScore() for _, i in ipairs({'songName', 'timeTxt', 'scoreTxt', 'botplayTxt'}) do setTextColor(i, rgbToHex(getProperty('dad.healthColorArray'))) end end

function onCreatePost()
    setProperty('gf.scrollFactor.y', 1); setProperty('gf.scrollFactor.x', 1)
    makeLuaText('songName', songName, 0, 0, screenHeight - 20); addLuaText('songName')
    setProperty('timeBar.x', -10000); setProperty('timeBarBG.x', -10000)
    colorScore()   
end

function onBeatHit() for i = 1,2 do setProperty('iconP'..i..'.angle',curBeat % 2 == 0 and -10 or 10); doTweenAngle('iconTween'..i,'iconP'..i,0,crochet/1000,'circOut') end end

function onEvent(eventName, value1, value2, strumTime) if eventName == 'Change Character' and value1 == 'gf' then setProperty('gf.scrollFactor.y', 1); setProperty('gf.scrollFactor.x', 1) end if eventName == 'Change Character' and value1 == 'dad' then colorScore() end end
