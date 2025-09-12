local dadY = getProperty('dad.y')
local dadCam = false
local color = true
local bambi = true
local mad = false
local land = false
local shadows = 0
local playDialogue = true

local function bambiShadows() 
    shadows = shadows + 1 
    makeAnimatedLuaSprite('bambi_'..shadows, 'characters/joke/bambi_joke_mad', getProperty('dad.x'), getProperty('dad.y'))
    addAnimationByPrefix('bambi_'..shadows, 'animacion', getProperty('dad.animation.frameName'), 0, false)
    setProperty('bambi_'..shadows..'.offset.x', getProperty('dad.offset.x'))
    setProperty('bambi_'..shadows..'.offset.y', getProperty('dad.offset.y'))
    setProperty('bambi_'..shadows..'.alpha', 0.5)
    setProperty('bambi_'..shadows..'.flipX', true)
    doTweenAlpha('bambi_alpha_'..shadows, 'bambi_'..shadows, 0, 0.7, 'sineInOut')
    addLuaSprite('bambi_'..shadows, false)    
end

function onCreate()
    setProperty('introSoundsSuffix', '-bambi')
    loadGraphic('sky', 'bg/sky/sky_night')

    makeAnimatedLuaSprite('power', 'bg/power', getProperty('dad.x') - 400, getProperty('dad.y') - 230)
    addAnimationByPrefix('power', 'idle', 'burst', 24, false)
    setProperty('power.visible', false)
    addLuaSprite('power', true)

    makeLuaSprite('land', 'bg/dave/land', 300, 700)
    scaleObject('land', 1.3, 1.1)
    setProperty('land.color', getColorFromHex('696969'))
    setProperty('land.visible', false)
    addLuaSprite('land', false)

    createInstance('meme', 'flixel.addons.display.FlxBackdrop', {})
    loadGraphic('meme', 'bg/meme')
    setProperty('meme.velocity.y', -150)
    setScrollFactor('meme', 0.7, 0.7)
    setProperty('meme.alpha', 0)
    addLuaSprite('meme')
    setObjectOrder('meme', getObjectOrder('gate') - 1)
end

function onSongStart() color = false end 

function onUpdate(elapsed) 
    if color then for _, i in ipairs({'boyfriend', 'dad', 'gf', 'pasto', 'gate', 'pasto_fondo', 'montanas'}) do setProperty(i..'.color', getColorFromHex('696969')) end end
    if not mustHitSection and dadCam then cameraSetTarget('dad') end 
    if mad then bambiShadows() end
    if land then 
        setProperty('boyfriend.y', getProperty('land.y') - 400)
        setProperty('gf.y', getProperty('land.y') - 600)
    end
end

function onEvent(n,v1,v2)
    if n == 'song_events' and v1 == 'volar' then
        doTweenY('dad_Y', 'dad', dadY - 1200, 50, 'sineOut')
        dadCam = true
    elseif n == 'song_events' and v1 == 'normal' then
        doTweenY('dad_Y', 'dad', dadY, 1, 'sineOut')
    elseif n == 'song_events' and v1 == 'meme_alpha' then
        doTweenAlpha('meme_alpha', 'meme', v2, 1, 'sineOut')
    end
end

function onEndSong()
	if isStoryMode then
		if bambi then
            addCharacterToList('bambi_joke_mad', 'dad')
		    bambi = false
            playSound('glitch_cc/break_phone')
            playAnim('dad', 'bambi', true)
            setProperty('dad.specialAnim', true)
            cameraSetTarget('dad')
            runTimer('end_song', 13.5)
            runTimer('mad', 10)
            runTimer('land', 11)
            runTimer('bambi_joke', 12.5)
		    return Function_Stop
        end
    end
    return Function_Continue
end

function onTimerCompleted(tag)
    if tag == 'mad' then
        playAnim('power', 'idle', true)
        setProperty('power.visible', true)
        playSound('glitch_cc/burst')
        triggerEvent('Change Character', 'dad', 'bambi_joke_mad')
        setProperty('dad.color', getColorFromHex('696969'))
        doTweenZoom('camz', 'camGame', 0.6, 0.5, 'sineOut')
    elseif tag == 'land' then
        land = true
        cameraShake('game', 0.01, 0.5)
        playSound('glitch_cc/ascend')
        setProperty('land.visible', true)
        doTweenY('land_Y', 'land', -700, 0.5, 'sineOut')
    elseif tag == 'bambi_joke' then
        dadCam = false
        mad = true
        playSound('glitch_cc/shagFly')
        doTweenY('dad_Y', 'dad', dadY - 1200, 0.5, 'sineOut')
    elseif tag == 'end_song' then
        endSong()
    end
end

function onTweenCompleted(tag)
    if string.find(tag, 'bambi_alpha_') then 
        removeLuaSprite(tag:gsub('bambi_alpha_', 'bambi_'), true)
    end
end

function onStartCountdown()
	if isStoryMode and not seenCutscene then
		if playDialogue then
			startDialogue('dialogue_'..getPropertyFromClass('backend.ClientPrefs', 'data.language'), 'secret')
			playDialogue = false
		    return Function_Stop
        end
    end
    return Function_Continue
end