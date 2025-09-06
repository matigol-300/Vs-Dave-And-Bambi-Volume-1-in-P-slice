function onEvent(name, value1, value2)
if name == 'cam_rotate' then
doTweenAngle('CAM_rotate', 'camGame', value1, value2, 'sineInOut')
end
end