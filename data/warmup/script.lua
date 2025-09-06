function onCreate()
    setProperty('introSoundsSuffix', '-dave')
end

function onEndSong()
    if rating == 1 then 
        unlockAchievement('warmup') 
    end
end