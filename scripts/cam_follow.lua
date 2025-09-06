local multiplier = 1.5
local cam = 'camGame.scroll'
function changeMultiplier(num) multiplier = num end
function onUpdate()
local camX = getProperty(cam .. '.x')
local camY = getProperty(cam .. '.y')
local char = mustHitSection and 'boyfriend' or 'dad'
local anim = getProperty(char .. '.animation.curAnim.name')
setProperty(cam .. '.x', camX)
setProperty(cam .. '.y', camY)
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