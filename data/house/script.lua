local playDialogue = true

function onCreate()
    setProperty('introSoundsSuffix', '-dave')
end

function onStartCountdown()
	if isStoryMode and not seenCutscene then
		if playDialogue then
			startDialogue('dialogue_'..getPropertyFromClass('backend.ClientPrefs', 'data.language'), 'DaveDialogue')
			playDialogue = false
		    return Function_Stop
        end
    end
    return Function_Continue
end