local rtx = false

function onCreate()
    setProperty('introSoundsSuffix', '-dave')
    addLuaScript('scripts/extras/makeShader')
    addLuaScript('scripts/extras/3d_notes')
    loadGraphic('sky', 'bg/sky/sky_night')
    loadGraphic('time_sprite', 'hud/timer-3d')

    makeLuaSprite('bg_3d_red', 'bg/dave/3d/redsky', -400, -300)
    setScrollFactor('bg_3d_red', 0, 0)
    setProperty('bg_3d_red.antialiasing', false)
    addLuaSprite('bg_3d_red', false)

    callScript('scripts/extras/makeShader', 'makeShaderSprite', {'bg_3d', 'bg_3d_red'}) 

    setShaderFloat('bg_3d_red', 'uWaveAmplitude', 0.1)
    setShaderFloat('bg_3d_red', 'uFrequency', 3)
    setShaderFloat('bg_3d_red', 'uSpeed', 1.5)

    makeLuaSprite('rtx_ending', 'rtx_ending', 0, 0)
    setProperty('rtx_ending.visible', false)
    setObjectCamera('rtx_ending', 'other')
    addLuaSprite('rtx_ending', true)

    startTween('dad_Y', 'dad', {y = -50}, 2, {ease = 'sineInOut', type = 'PINGPONG'})
end

function onEvent(n,v1,v2)
    if n == 'eyesores' then rtx = (v1 == 'true') end
    if n == 'song_events' then
        cancelTween('dad_Y')
        triggerEvent('Change Character', 'dad', 'dave')
        playAnim('dad', 'huh', true)
        setProperty('dad.specialAnim', true)
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

function onUpdate(elapsed) if not mustHitSection then cameraSetTarget('dad') end end