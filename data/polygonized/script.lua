local rtx = false
function onCreatePost()
    addLuaScript('scripts/extras/makeShader')
    addLuaScript('scripts/extras/3d_notes')

    makeLuaSprite('bg_3d_red', 'bg/dave_house/redsky', -400, -300)
    setScrollFactor('bg_3d_red', 0, 0)
    setProperty('bg_3d_red.antialiasing', false)
    addLuaSprite('bg_3d_red', false)
    callScript('scripts/extras/makeShader', 'makeShaderSprite', {'WavyBg', 'bg_3d_red'}) 
    setShaderFloat('bg_3d_red', 'uWaveAmplitude', 0.1)
    setShaderFloat('bg_3d_red', 'uFrequency', 1)
    setShaderFloat('bg_3d_red', 'uSpeed', 3)

    loadGraphic('fondo', 'bg/sky/sky_night')
    startTween('dad_Y', 'dad', {y = -100}, 2, {ease = 'sineInOut', type = 'PINGPONG'})

    makeLuaSprite('rtx_ending', 'bg/dave_house/rtx_ending', 0, 0)
    setProperty('rtx_ending.visible', false)
    setObjectCamera('rtx_ending', 'other')
    addLuaSprite('rtx_ending', true)
end
function onUpdate(elapsed) if not mustHitSection then cameraSetTarget('dad') end end
function onEvent(n,v1,v2)
    if n == 'eyesores' then rtx = (v1 == 'true') end
    if n == 'song_events' then
        cancelTween('dad_Y')
        triggerEvent('Change Character', 'dad', 'dave')
        triggerEvent('Hey!', 'bf', 1)
        triggerEvent('Hey!', 'gf', 1)
        removeLuaSprite('bg_3d_red', true)
        for _, i in ipairs({'boyfriend', 'dad', 'gf', 'pasto', 'gate', 'pasto_fondo', 'montanas'}) do setProperty(i..'.color', getColorFromHex('696969')) end
    end
end
function onGameOver() if rtx == true then openCustomSubstate('rtxEnding', true); return Function_Stop end end
function onCustomSubstateCreatePost(name)
    if name == 'rtxEnding' then
        unlockAchievement('rtx')
        cameraShake('camGAME', 0.01, 0.01)
        runHaxeCode([[game.camGame.setFilters([]); game.camHUD.setFilters([]);]]);
        setProperty('rtx_ending.visible', true)
        playMusic('rtx', 0.8, true)
    end
end
function onCustomSubstateUpdatePost(name)
    if name == 'rtxEnding' then
        if keyJustPressed('accept') then
            playSound('confirmMenu')
            endSong()
        end
    end
end