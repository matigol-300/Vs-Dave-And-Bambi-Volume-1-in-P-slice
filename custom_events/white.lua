function onCreate()
makeLuaSprite('white', nil, 0, 0)
makeGraphic('white', 2000, 2000, 'FFFFFF')
setProperty('white.scale.x', 3)
setProperty('white.scale.y', 3)
setProperty('white.alpha', 0)
addLuaSprite('white', true)	
end
function onEvent(n,v1,v2)
if n == 'white' then
doTweenAlpha('white_alpha', 'white', v1, v2, 'sineInOut')
end
end