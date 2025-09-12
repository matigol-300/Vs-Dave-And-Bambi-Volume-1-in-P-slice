local bg = false
local camDad = true
local shader1 = 0
local shader2 = 0
local shader3 = 0
local circulo = -400 
local speed = 2
local mad = false
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
    addLuaScript('scripts/extras/makeShader')
end

function onUpdate(elapsed) 
    if not mustHitSection and camDad then cameraSetTarget('dad') end 
    if bg then 
        setShaderFloat('sky', 'uWaveAmplitude', shader1)
        setShaderFloat('sky', 'uFrequency', shader2)
        setShaderFloat('sky', 'uSpeed', shader3)
        if shader1 <= 0.1 then shader1 = shader1 + 0.0001 end
        if shader2 <= 3 then shader2 = shader2 + 0.08 end
        if shader3 <= 1.5 then shader3 = shader3 + 0.05 end
    end
    if mad then
        circulo = circulo + speed * elapsed
        local dadX = 800 + math.cos(circulo) * 850
        local dadY = 200 + math.sin(circulo) * 850
        setProperty('dad.x', dadX)
        setProperty('dad.y', dadY)
    end
end

function onTweenCompleted(tag)
    if tag == 'dad_X0' then
        doTweenX('dad_X1', 'dad', -100, 2, 'sineInOut')
    elseif tag == 'dad_X1' then
        doTweenX('dad_X0', 'dad', -400, 2, 'sineInOut')
    elseif tag == 'dad_Y0' then
        doTweenY('dad_Y1', 'dad', 200, 2, 'sineInOut')
    elseif tag == 'dad_Y1' then
        doTweenY('dad_Y0', 'dad', -100, 2, 'sineInOut')
    end
    if string.find(tag, 'bambi_alpha_') then 
        removeLuaSprite(tag:gsub('bambi_alpha_', 'bambi_'), true)
    end
end

function onStepHit() if mad then bambiShadows() end end

function onEvent(n,v1,v2)
    if n == 'song_events' and v1 == 'mad' then
        doTweenX('dad_X0', 'dad', -400, 2, 'sineInOut')
        doTweenY('dad_Y0', 'dad', -100, 1, 'sineInOut')
    elseif n == 'song_events' and v1 == 'bg' then
        callScript('scripts/extras/makeShader', 'makeShaderSprite', {'bg_3d', 'sky'}) 
        bg = true
    elseif n == 'song_events' and v1 == 'fire' then
        cancelTween('dad_X0')
        cancelTween('dad_X1')
        cancelTween('dad_Y0')
        cancelTween('dad_Y1')
        doTweenAlpha('fire_alpha', 'fire', 0.8, 15, 'sineOut')
        camDad = false
        mad = true
    elseif n == 'song_events' and v1 == 'fire_end' then
        cancelTween('fire_alpha')
        callScript('scripts/extras/makeShader', 'revomeShaderSprite', {'sky'}) 
        doTweenX('dad_X0', 'dad', -400, 2, 'sineInOut')
        doTweenY('dad_Y0', 'dad', -100, 1, 'sineInOut')
        setProperty('fire.alpha', 0)
        bg = false
        camDad = true
        mad = false
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