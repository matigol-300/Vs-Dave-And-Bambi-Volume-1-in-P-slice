local function rgbToHex(array) return string.format('%.2x%.2x%.2x', array[1], array[2], array[3]) end

local function colorScore() for _, i in ipairs({'songName', 'timeTxt', 'scoreTxt', 'botplayTxt'}) do setTextColor(i, rgbToHex(getProperty('dad.healthColorArray'))) end end

function onCreatePost()
    setProperty('gf.scrollFactor.y', 1); setProperty('gf.scrollFactor.x', 1)
    makeLuaText('songName', songName, 0, 0, screenHeight - 20); addLuaText('songName')
    setProperty('timeBar.x', -10000); setProperty('timeBarBG.x', -10000)
    colorScore()   
	if not isStoryMode then
		if getModSetting('charBF') == 'Boyfriend 3D' then
			triggerEvent('Change Character', 'bf', 'bf_3d')
			setPropertyFromClass('substates.GameOverSubstate', 'characterName', 'bf_3d_die')
		elseif getModSetting('charBF') == 'Girlfriend' then
			triggerEvent('Change Character', 'bf', 'gf_player')
			setPropertyFromClass('substates.GameOverSubstate', 'characterName', 'gf_player_game_over')
			setPropertyFromClass('substates.GameOverSubstate', 'deathSoundName', 'gameOverStart-gf')
			setPropertyFromClass('substates.GameOverSubstate', 'loopSoundName',  'gameOver-gf') 
			setPropertyFromClass('substates.GameOverSubstate', 'endSoundName',   'gameOverEnd-gf')
		end
		if getModSetting('charGF') == 'Girlfriend 3D' then
			triggerEvent('Change Character', 'gf', 'gf_3d')
		elseif getModSetting('charGF') == 'Boyfriend' then
			triggerEvent('Change Character', 'gf', 'bf_over_gf')
		end
	end
end

function onBeatHit() for i = 1,2 do setProperty('iconP'..i..'.angle',curBeat % 2 == 0 and -10 or 10); doTweenAngle('iconTween'..i,'iconP'..i,0,crochet/1000,'circOut') end end

function onEvent(eventName, value1, value2, strumTime) if eventName == 'Change Character' and value1 == 'gf' then setProperty('gf.scrollFactor.y', 1); setProperty('gf.scrollFactor.x', 1) end if eventName == 'Change Character' and value1 == 'dad' then colorScore() end end

function onEndSong()
	if not botPlay or not practice then
		if callMethodFromClass('backend.Highscore', 'getFCState', {songName, 'Hard'}) == false then
			if misses == 0  then
				if week == 'dave' or week == 'bambi' then
					addAchievementScore(week, 1)
				end
			end
		end
	end
end
