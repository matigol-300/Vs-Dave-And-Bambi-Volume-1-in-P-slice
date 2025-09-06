function onEvent(n,v1,v2)
if n == 'hud_alpha' then
doTweenAlpha('hud_alpha', 'camHUD', v1, v2, 'sineInOut')
end
end