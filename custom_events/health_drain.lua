local drain = 0
function onEvent(n, v1, v2)
if n == 'health_drain' then
drain = v1
end
end
function opponentNoteHit(membersIndex, noteData, noteType, isSustainNote)
if getModSetting('healthdrainLOCO') then
if getProperty('health') > 0.1 then
addHealth(drain)
end
end
end