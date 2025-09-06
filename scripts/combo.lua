local colores = {0, 0, 0}
local function rgbToHex(array) return string.format('%.2x%.2x%.2x', array[1], array[2], array[3]) end
function onCreatePost()
    setProperty('showRating', false)
    setProperty('showComboNum', false)
    setProperty('showCombo', false)

    makeLuaText('combo_text', combo, 0, 0, (downscroll and 620 or 60))
    setTextSize('combo_text', 40)
    setObjectCamera('combo_text', 'camHUD')
    screenCenter('combo_text', 'x')
    setProperty('combo_text.alpha', 0)
    addLuaText('combo_text')

    makeLuaText('rating_text', 'test', 0, 0, (downscroll and 580 or 110))
    setTextSize('rating_text', 30)
    setObjectCamera('rating_text', 'camHUD')
    screenCenter('rating_text', 'x')
    setProperty('rating_text.alpha', 0)
    addLuaText('rating_text')
end
function actualizarCombo(text)
    colores = {getRandomInt(0, 255),getRandomInt(0, 255), getRandomInt(0, 255)}
    setTextString('rating_text', text)
    setTextString('combo_text', combo)
    for _, i in ipairs({'combo_text', 'rating_text'}) do
        screenCenter(i, 'x')
        setTextColor(i, rgbToHex(colores))
        setProperty(i..'.alpha', 1)
        setProperty(i..'.scale.x', 1.3)
        setProperty(i..'.scale.y', 1.3)
        setProperty(i..'.angle', getRandomFloat(-5, 5))
        doTweenAlpha(i..'_alpha', i, 0, 1.5, 'sineOut')
        doTweenAngle(i..'_angle', i, 0, 1, 'cubeOut')
        doTweenX(i..'_scale_X', i..'.scale', 1, 2, 'cubeOut')
        doTweenY(i..'_scale_Y', i..'.scale', 1, 2, 'cubeOut')	
    end
end
function goodNoteHit(membersIndex, noteData, noteType, isSustainNote)
    if not botPlay then
        if getPropertyFromGroup('notes', membersIndex, 'rating') == 'sick' then actualizarCombo('Perfect')
        elseif getPropertyFromGroup('notes', membersIndex, 'rating') == 'good' then actualizarCombo('Cool')
        elseif getPropertyFromGroup('notes', membersIndex, 'rating') == 'bad' then actualizarCombo('Bad')
        elseif getPropertyFromGroup('notes', membersIndex, 'rating') == 'shit' then actualizarCombo('You suck!!!') end
        else 
        actualizarCombo('BotPlay Bro')
    end
    if combo == 100 then 
        playAnim('gf', 'cheer', true)
        setProperty('gf.specialAnim', true)
    end
    if combo >= 100 then 
        if noteData == 0 then playAnim('boyfriend', 'singLEFT-alt', true)
        elseif noteData == 1 then playAnim('boyfriend', 'singDOWN-alt', true)
        elseif noteData == 2 then playAnim('boyfriend', 'singUP-alt', true)
        elseif noteData == 3 then playAnim('boyfriend', 'singRIGHT-alt', true) end
    end
end
function noteMiss(membersIndex, noteData, noteType, isSustainNote) actualizarCombo('Miss!!!') end