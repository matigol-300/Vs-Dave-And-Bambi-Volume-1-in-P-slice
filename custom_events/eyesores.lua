function onCreatePost()
    addLuaScript('scripts/extras/makeShader')
    callScript('scripts/extras/makeShader', 'makeShaderCam', {'eyesore', 'game'}) 
    setShaderFloat("camShader", "uSpeed", 3)
    setShaderFloat("camShader", "uFrequency", 1)
    setShaderFloat("camShader", "uWaveAmplitude", 0.8)
end

function onEvent(n, v1, v2) if n == 'eyesores' then setShaderBool("camShader", "uEnabled", (v1 == 'true')) end end

function onUpdate()
    songPos = getSongPosition()
    currentBeat = (songPos/5000)*(curBpm/60)
    setShaderFloat("camShader", "uTime", currentBeat)	
    if getShaderBool("camShader", "uEnabled") then
        setShaderFloat("camShader", "uampmul", 0.5)
        else
        setShaderFloat("camShader", "uampmul", getShaderFloat("camShader", "uampmul") - 0.01)
    end
end
