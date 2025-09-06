local color = 'ffffff'
function onEvent(n,v1,v2)
if n == 'flash' then
if v2 == nil then
color = 'ffffff'
else
color = v2
end
makeLuaSprite('flash', nil, 0, 0);
makeGraphic('flash', 1280, 720, color)
setScrollFactor('flash', 0, 0)
setProperty('flash.scale.x',2)
setProperty('flash.scale.y',2)
doTweenAlpha('flash_alpha', 'flash', 0, v1, 'linear')
addLuaSprite('flash', true)		
end
end