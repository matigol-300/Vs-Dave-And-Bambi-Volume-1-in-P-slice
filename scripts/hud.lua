local function sprite(tag, file, x, y, size)
    makeLuaSprite(tag, 'hud/'..file, x, y)
    scaleObject(tag, size, size)
    setObjectCamera(tag, 'hud')
    addLuaSprite(tag, false)
end

local function text(tag, text, x, y, size)
    makeLuaText(tag, text, 0, x, y)
    setProperty(tag..'.antialiasing', true)
    setTextSize(tag, size)
    addLuaText(tag)
end

local function rgbToHex(array) return string.format('%.2x%.2x%.2x', array[1], array[2], array[3]) end

function hudColor(color) for _, i in ipairs({'misses_hud', 'misses_text', 'score_hud', 'score_text', 'accuracy_hud', 'accuracy_text', 'time_sprite_bg'}) do setProperty(i..'.color', getColorFromHex(color)) end end

function onCreate()
    sprite('misses_hud', 'misses', 0, downscroll and 120 or 675, 0.5)
    screenCenter('misses_hud', 'x')
    text('misses_text', misses, getProperty('misses_hud.x') + 50, downscroll and 120 or 675, 20)
    sprite('score_hud', 'score', getProperty('misses_hud.x') + 150, downscroll and 120 or 675, 0.5)
    text('score_text', score, getProperty('score_hud.x') + 50, downscroll and 125 or 675, 20)
    sprite('accuracy_hud', 'accuracy', getProperty('misses_hud.x') - 150, downscroll and 120 or 675, 0.5)
    text('accuracy_text', '???', getProperty('accuracy_hud.x') + 30, downscroll and 125 or 675, 20)
    if timeBarType == 'Time Left' and not middlescroll then
        sprite('time_bg', 'timer_bg', 0, downscroll and 580 or 60, 1)
        screenCenter('time_bg', 'x')
        setProperty('time_bg.color', getColorFromHex('787777'))
        sprite('time_sprite_bg', 'timer_bg', 0, 0, 1)
        screenCenter('time_sprite_bg', 'x')
        loadGraphic('time_sprite_bg', 'hud/timer_bg', 0, 0)
        sprite('time_sprite', 'timer', 0, downscroll and 550 or 30, 1)
        screenCenter('time_sprite', 'x')
    end
    hudColor(rgbToHex(getProperty('dad.healthColorArray')))
end

function onCreatePost()
    setProperty('scoreTxt.visible', false)
end

function onUpdate(elapsed)
    local songPosition = getSongPosition() / 1000
    local time = getPropertyFromClass('flixel.FlxG', 'sound.music.length') / 1000
    setProperty('time_sprite_bg.y', (downscroll and 665 or 140) - getProperty('time_sprite_bg.height'))
    if songPosition >= 5 then
        loadGraphic('time_sprite_bg', 'hud/timer_bg', 92, songPosition / time * 83)
    else 
        loadGraphic('time_sprite_bg', 'hud/timer_bg', 1, 1)
    end
end

function onUpdateScore(miss)
    setTextString('misses_text', misses)
    setTextString('score_text', score)
    setTextString('accuracy_text', callMethodFromClass('backend.CoolUtil', 'floorDecimal', {getProperty('ratingPercent') * 100, 2})..'%')
end

function onEvent(eventName, value1, value2, strumTime) if eventName == 'Change Character' and value1 == 'dad' then hudColor(rgbToHex(getProperty('dad.healthColorArray'))) end end