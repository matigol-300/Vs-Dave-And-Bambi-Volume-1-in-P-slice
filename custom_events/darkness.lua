function onCreate()
makeLuaSprite('darkness', nil, 0, 0)
makeGraphic('darkness', 2000, 2000, '000000')
setProperty('darkness.scale.x', 3)
setProperty('darkness.scale.y', 3)
setProperty('darkness.alpha', 0)
addLuaSprite('darkness', true)	
end
function onEvent(n,v1,v2)
if n == 'darkness' then
doTweenAlpha('darkness_alpha', 'darkness', v1, v2, 'sineInOut')
end
end