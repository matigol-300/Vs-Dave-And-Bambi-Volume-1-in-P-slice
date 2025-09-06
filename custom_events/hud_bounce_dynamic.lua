local cant = false
local left = 0
local right = 0
function onEvent(n,v1,v2)
if n == 'hud_bounce_dynamic' then
left = v1
right = v2
if v1 == 0 and v2 == 0 then 
cant = false
else
cant = true
end
end
end
function onBeatHit()
if cant == true then
if curBeat % 2 == 0 then
setProperty('camHUD.angle', 2*left)
doTweenAngle('hudTween', 'camHUD', 0, 0.8, 'backOut')
triggerEvent('Add Camera Zoom', '0', '0.03' * left)
end	
if curBeat % 2 == 1 then
setProperty('camHUD.angle', 2*-right)
doTweenAngle('hudTween', 'camHUD', 0, 0.8, 'backOut')
triggerEvent('Add Camera Zoom', '0', '0.01' * right)
end	
end
end

