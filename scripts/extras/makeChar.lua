local multiplier = 1
local cam = 'camGame.scroll'
local personajes = {}
local iconos = {}
function makeCharacter(tag, character, esJugador, nota, x, y, layer)
createInstance(tag, 'objects.Character', {x, y, character, esJugador})
addInstance(tag, layer)
table.insert(personajes, {
tag = tag,
nota = nota,
esJugador = esJugador
})
end
function animarCanto(personaje, nota)
local anim = ''
if nota == 0 then anim = 'singLEFT'
elseif nota == 1 then anim = 'singDOWN'
elseif nota == 2 then anim = 'singUP'
elseif nota == 3 then anim = 'singRIGHT' end
callMethod(personaje.tag .. '.playAnim', {anim, true})
end
function goodNoteHit(membersIndex, noteData, noteType, isSustainNote)
for _, personaje in ipairs(personajes) do
if personaje.esJugador and tostring(noteType) == personaje.nota then
setProperty(personaje.tag .. '.holdTimer', 0)
animarCanto(personaje, noteData)
end
end
end
function opponentNoteHit(membersIndex, noteData, noteType, isSustainNote)
for _, personaje in ipairs(personajes) do
if not personaje.esJugador and tostring(noteType) == personaje.nota or not personaje.esJugador and personaje.nota == '' then
setProperty(personaje.tag .. '.holdTimer', 0)
animarCanto(personaje, noteData)
end
end
end
function onBeatHit()
if curBeat % 2 == 0 then 
for _, personaje in ipairs(personajes) do
callMethod(personaje.tag .. '.dance')
end
end
end
function setCamCharacter(tag, x, y) triggerEvent('Camera Follow Pos', getProperty(tag..'.x') + x, getProperty(tag..'.y') + y)  end
function removeCharacter(tag) callMethod('remove', {instanceArg(tag), true}) end
function makeCharacterIcon(tag, icon, player, x, y, size)
makeLuaSprite(tag, nil, 0, y)
loadGraphic(tag, 'icons/'..icon, 150)
addAnimation(tag, 'normal', {0}, 0, true)
addAnimation(tag, 'lose', {1}, 0, true)
setProperty(tag..'.flipX', player)
setObjectCamera(tag, 'camHUD')
addLuaSprite(tag, true)
table.insert(iconos, {
tag = tag,
isPlayer = player,
iconX = x,
size = size,
})
end
function onUpdate()
for _, icons in ipairs(iconos) do
if not icons.isPlayer then
setProperty(icons.tag ..'.x', getProperty('iconP1.x') + icons.iconX)
setProperty(icons.tag ..'.angle', getProperty('iconP1.angle'))
setProperty(icons.tag ..'.scale.x', getProperty('iconP1.scale.x') - icons.size)
setProperty(icons.tag ..'.scale.y', getProperty('iconP1.scale.y') - icons.size)
elseif icons.isPlayer then
setProperty(icons.tag ..'.x', getProperty('iconP2.x') + icons.iconX)
setProperty(icons.tag ..'.angle', getProperty('iconP2.angle'))
setProperty(icons.tag ..'.scale.x', getProperty('iconP2.scale.x') - icons.size)
setProperty(icons.tag ..'.scale.y', getProperty('iconP2.scale.y') - icons.size)
end
if icons.isPlayer and getProperty('healthBar.percent') < 20 then
playAnim(icons.tag, 'lose')
elseif not icons.isPlayer and getProperty('healthBar.percent') > 80 then
playAnim(icons.tag, 'lose')
else
playAnim(icons.tag, 'normal')
end
end
for _, personaje in ipairs(personajes) do
local camX = getProperty(cam .. '.x')
local camY = getProperty(cam .. '.y')
local anim = getProperty(personaje.tag.. '.animation.curAnim.name')
setProperty(cam .. '.x', camX)
setProperty(cam .. '.y', camY)
if not mustHitSection and not personaje.isPlayer then
if anim:find('singLEFT') then
setProperty(cam .. '.x', camX - multiplier)
elseif anim:find('singRIGHT') then
setProperty(cam .. '.x', camX + multiplier)
elseif anim:find('singUP') then
setProperty(cam .. '.y', camY - multiplier)
elseif anim:find('singDOWN') then
setProperty(cam .. '.y', camY + multiplier)
end
end
if mustHitSection and personaje.isPlayer then
if anim:find('singLEFT') then
setProperty(cam .. '.x', camX - multiplier)
elseif anim:find('singRIGHT') then
setProperty(cam .. '.x', camX + multiplier)
elseif anim:find('singUP') then
setProperty(cam .. '.y', camY - multiplier)
elseif anim:find('singDOWN') then
setProperty(cam .. '.y', camY + multiplier)
end
end
end
end