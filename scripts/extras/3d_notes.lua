function onCountdownStarted()
    for i = 0,3 do 
        setPropertyFromGroup('opponentStrums', i, 'texture', 'notes_and_mechanics/note_3d')
        setPropertyFromGroup('opponentStrums', i, 'rgbShader.enabled', false)
    end
    for i = 0, getProperty('unspawnNotes.length')-1 do 
        if not getPropertyFromGroup('unspawnNotes', i, 'mustPress') and getPropertyFromGroup('unspawnNotes', i, 'texture') ~= 'notes_and_mechanics/note_shape' then 
            setPropertyFromGroup('unspawnNotes', i, 'texture', 'notes_and_mechanics/note_3d')
            setPropertyFromGroup('unspawnNotes', i, 'rgbShader.enabled', false)
        end
    end
end