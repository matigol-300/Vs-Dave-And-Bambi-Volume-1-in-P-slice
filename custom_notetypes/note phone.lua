function onCreate()
    for i = 0, getProperty('unspawnNotes.length')-1 do
        if getPropertyFromGroup('unspawnNotes', i, 'noteType') == 'note phone' then	  	 
            setPropertyFromGroup('unspawnNotes', i, 'texture', 'notes_and_mechanics/NOTE_phone')
            setPropertyFromGroup('unspawnNotes', i, 'rgbShader.enabled', false)	
            if getPropertyFromGroup('unspawnNotes', i, 'mustPress') == false then
                if getPropertyFromGroup('unspawnNotes', i, 'noteData') == 0 or getPropertyFromGroup('unspawnNotes', i, 'noteData') == 3 then	
                    setPropertyFromGroup('unspawnNotes', i, 'animSuffix', '-alt')	  	  
                end
            end
            if getModSetting('phoneLOCO') == false and getPropertyFromGroup('unspawnNotes', i, 'mustPress') == true then 
                setPropertyFromGroup('unspawnNotes', i, 'multAlpha', 0)  
                setPropertyFromGroup('unspawnNotes', i, 'blockHit', true)	
                setPropertyFromGroup('unspawnNotes', i, 'ignoreNote', true)    
            end
        end
    end
end
function goodNoteHit(membersIndex, noteData, noteType, isSustainNote)
if noteType == 'note phone' then
playAnim('dad', 'ataque', true)
setProperty('dad.specialAnim', true)
if songName ~= 'Maze' then
setProperty('boyfriend.color', getColorFromHex('6EAAFF'))
doTweenColor('boyfriend_color', 'boyfriend', 'FFFFFF', 1.5, 'linear')
end
end
end
function noteMiss(membersIndex, noteData, noteType, isSustainNote)
if noteType == 'note phone' then
playAnim('dad', 'ataque', true)
setProperty('dad.specialAnim', true)
playAnim('boyfriend', 'hurt', true)
setProperty('boyfriend.specialAnim', true)
addHealth(-0.2)
if songName ~= 'Maze' then
setProperty('boyfriend.color', getColorFromHex('FF0000'))
doTweenColor('boyfriend_color', 'boyfriend', 'FFFFFF', 1.5, 'linear')
end
if noteData == 0 then
noteTweenAlpha('note_1_alpha', 4, 0, 0.01, 'sineInOut')
noteTweenAlpha('note_1_D_alpha', 4, 1, 5, 'sineInOut')
elseif noteData == 1 then
noteTweenAlpha('note_2_alpha', 5, 0, 0.01, 'sineInOut')
noteTweenAlpha('note_2_D_alpha', 5, 1, 5, 'sineInOut')
elseif noteData == 2 then
noteTweenAlpha('note_3_alpha', 6, 0, 0.01, 'sineInOut')
noteTweenAlpha('note_3_D_alpha', 6, 1, 5, 'sineInOut')
elseif noteData == 3 then
noteTweenAlpha('note_4_alpha', 7, 0, 0.01, 'sineInOut')
noteTweenAlpha('note_4_D_alpha', 7, 1, 5, 'sineInOut')
end
end
end