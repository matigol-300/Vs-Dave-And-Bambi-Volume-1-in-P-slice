function onCreate()
    for i = 0, getProperty('unspawnNotes.length') - 1 do
        if getPropertyFromGroup('unspawnNotes', i, 'noteType') == 'note shape' then	
            if getModSetting('shapeLOCO') then    
                makeLuaSprite('avertencialoca', 'notes_and_mechanics/shapeNoteWarning', 0, 800)
                setObjectCamera('avertencialoca', 'other')
                addLuaSprite('avertencialoca', true)
                setPropertyFromGroup('unspawnNotes', i, 'texture', 'notes_and_mechanics/note_shape')	
                setPropertyFromGroup('unspawnNotes', i, 'rgbShader.enabled', false)	
            end
        end
    end	 
end

function onSongStart()
    if getModSetting('shapeLOCO') then
        doTweenY('avertencialocaY', 'avertencialoca', 450, 1, 'elasticOut')	
        runTimer('avertencialocafin', 4)
    end
end

function onTimerCompleted(tag, loops, loopsLeft) if tag == 'avertencialocafin' then doTweenY('avertencialocaYfin', 'avertencialoca', 800, 1, 'elasticIn') end end

function onTweenCompleted(tag, vars) if tag == 'avertencialocaYfin' then removeLuaSprite('avertencialoca', true) end end

function onUpdatePost(elapsed)
    if not botPlay then
        for i = 0, getProperty('notes.length') - 1 do
            if getModSetting('shapeLOCO') then
                if keyboardPressed('SPACE') then
                    for i = 0,3 do 
                        setPropertyFromGroup('playerStrums', i, 'texture', 'notes_and_mechanics/note_shape') 
                        setPropertyFromGroup('playerStrums', i, 'rgbShader.enabled', false)	
                    end
                    if getPropertyFromGroup('notes', i, 'mustPress') then
                        setPropertyFromGroup('notes', i, 'multAlpha', 0.5)
                        setPropertyFromGroup('notes', i, 'blockHit', true)
                        if getPropertyFromGroup('notes', i, 'noteType') == 'note shape' then
                            setPropertyFromGroup('notes', i, 'multAlpha', 1)
                            setPropertyFromGroup('notes', i, 'blockHit', false)
                        end
                    end
                else
                    for i = 0,3 do 
                        setPropertyFromGroup('playerStrums', i, 'texture', 'noteSkins/NOTE_assets'..noteSkinPostfix) 
                    end
                    if getPropertyFromGroup('notes', i, 'mustPress') then
                        setPropertyFromGroup('notes', i, 'multAlpha', 1)
                        setPropertyFromGroup('notes', i, 'blockHit', false)
                        if getPropertyFromGroup('notes', i, 'noteType') == 'note shape' then
                            setPropertyFromGroup('notes', i, 'multAlpha', 0.5)
                            setPropertyFromGroup('notes', i, 'blockHit', true)
                        end
                    end
                end
            end
        end
    end
end