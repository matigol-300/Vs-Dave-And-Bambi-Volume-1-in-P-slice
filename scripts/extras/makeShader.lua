local spriteShader = {}
function makeShaderCam(shader, cam)
    if shadersEnabled then
        initLuaShader(shader)
        makeLuaSprite('camShader', '', screenWidth, screenHeight)
        setSpriteShader('camShader', shader)
        if cam == 'all' then
            runHaxeCode([[
            FlxG.game.setFilters([new ShaderFilter(game.getLuaObject('camShader').shader)]);
            ]])
        elseif cam == 'game' then
            runHaxeCode([[
            game.camGame.setFilters([new ShaderFilter(game.getLuaObject("camShader").shader)]);
            ]])
        end
    end
end
function revomeShaderCam(cam) runHaxeCode([[FlxG.]]..cam..[[.setFilters([]);]]) end
function makeShaderSprite(shader, sprite)
    if shadersEnabled then
        initLuaShader(shader)
        setSpriteShader(sprite, shader)
        table.insert(spriteShader, sprite)
    end
end
function revomeShaderSprite(sprite)
    if shadersEnabled then
        removeSpriteShader(sprite)
        for i = #spriteShader, 1, -1 do
            if spriteShader[i] == sprite then
                table.remove(spriteShader, i)
            break
            end
        end
    end
end
function onUpdate(elapsed)
    if shadersEnabled then
        setShaderFloat('camShader', 'iTime', os.clock())    
        for i, sprite in ipairs(spriteShader) do
            setShaderFloat(sprite, 'iTime', os.clock())
        end
    end
end
function onDestroy()
    if shadersEnabled then
        runHaxeCode([[
        FlxG.game.setFilters([]);
        FlxG.camGame.setFilters([]);
        ]])
    end
end