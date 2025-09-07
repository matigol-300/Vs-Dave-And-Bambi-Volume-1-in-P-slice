function onCreate()
for i = 0, getProperty('unspawnNotes.length')-1 do
if getPropertyFromGroup('unspawnNotes', i, 'noteType') == 'note bambi break' then	  	 
setPropertyFromGroup('unspawnNotes', i, 'texture', 'notes_and_mechanics/NOTE_phone')
setPropertyFromGroup('unspawnNotes', i, 'rgbShader.enabled', false)	  	  
end
end
end
function opponentNoteHit(membersIndex, noteData, noteType, isSustainNote)
if noteType == 'note bambi break' then
playAnim('dad', 'singPhone', true)
end
end