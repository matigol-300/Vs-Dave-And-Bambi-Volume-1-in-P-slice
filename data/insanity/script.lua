function onCreatePost()
    addLuaScript('scripts/extras/makeShader')
    
    makeLuaSprite('bg_3d', 'bg/dave_house/redsky_insanity', -350, -200)
    setScrollFactor('bg_3d', 0, 0)
    setProperty('bg_3d.visible', false)
    setProperty('bg_3d.antialiasing', false)
    addLuaSprite('bg_3d', false)

    makeLuaSprite('bg_3d_red', 'bg/dave_house/redsky', -350, -300)
    setScrollFactor('bg_3d_red', 0, 0)
    setProperty('bg_3d_red.visible', false)
    setProperty('bg_3d_red.antialiasing', false)
    addLuaSprite('bg_3d_red', false)

    callScript('scripts/extras/makeShader', 'makeShaderSprite', {'WavyBg', 'bg_3d'})   
    callScript('scripts/extras/makeShader', 'makeShaderSprite', {'WavyBg', 'bg_3d_red'}) 

    setShaderFloat('bg_3d', 'uWaveAmplitude', 0.1)
    setShaderFloat('bg_3d', 'uFrequency', 5)
    setShaderFloat('bg_3d', 'uSpeed', 5)

    setShaderFloat('bg_3d_red', 'uWaveAmplitude', 0.1)
    setShaderFloat('bg_3d_red', 'uFrequency', 3)
    setShaderFloat('bg_3d_red', 'uSpeed', 1.5)
end