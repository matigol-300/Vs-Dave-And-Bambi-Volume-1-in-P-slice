local dadY = getProperty('dad.y')
local dadCam = false
local playDialogue = true

function onCreate()
    setProperty('introSoundsSuffix', '-bambi')
end

function onUpdate(elapsed) if not mustHitSection and dadCam then cameraSetTarget('dad') end end

function onEvent(n,v1,v2)
    if n == 'song_events' and v1 == 'volar' then
        doTweenY('dad_Y', 'dad', dadY - 1000, 10, 'sineOut')
        dadCam = true
    elseif n == 'song_events' and v1 == 'normal' then
        doTweenY('dad_Y', 'dad', dadY, 1, 'sineOut')
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