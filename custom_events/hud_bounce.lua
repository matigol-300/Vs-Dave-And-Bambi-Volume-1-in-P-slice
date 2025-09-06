local Salto = 0
local Caida = 0
function onEvent(n,v1,v2)
if n == 'hud_bounce' then
Salto = tonumber(v1)
Caida = tonumber(v2)
doTweenY('camHUDY0', 'camHUD', Salto, stepCrochet * 0.002, 'circOut')
if Salto == 0 and Caida == 0 then
cancelTween('camHUDY0')
cancelTween('camHUDY1')
doTweenY('camHUDY2', 'camHUD', 0, stepCrochet * 0.002, 'sineIn')
end
end
end
function onTweenCompleted(tag, vars)
if tag == 'camHUDY0' then
doTweenY('camHUDY1', 'camHUD', Caida, stepCrochet * 0.002, 'sineIn')
end
if tag == 'camHUDY1' then
doTweenY('camHUDY0', 'camHUD', Salto, stepCrochet * 0.002, 'circOut')
end
end