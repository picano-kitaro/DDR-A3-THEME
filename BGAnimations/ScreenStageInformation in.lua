for _, pn in ipairs(GAMESTATE:GetEnabledPlayers()) do
	if GetUserPref("OptionRowGameplayBackground")=='DanceStages' then
		local SelectedCharacter = ReadOrCreateRageValueForPlayer(pn, "Character", "Random")
		local CharaRandom = GetAllCharacterNames()
			table.remove(CharaRandom,IndexKey(CharaRandom,"Random"))
			table.remove(CharaRandom,IndexKey(CharaRandom,"None"))
		if SelectedCharacter == "Random" then
			WritePrefToFile("CharaRandom"..pn,CharaRandom[math.random(#CharaRandom)]);
		end
		if SelectedCharacter ~= "Random" then
			GAMESTATE:SetCharacter(pn,SelectedCharacter)
		else
			GAMESTATE:SetCharacter(pn,GetUserPref("CharaRandom"..pn))
		end
	end
	if GetUserPref("NTOption")=='On' then
		GetPlayerNoteSkin(pn)
	end
end



return Def.ActorFrame{
	LoadActor(THEME:GetPathB("ScreenStageInformation","decorations/Announcer"));
    OnCommand=function(s) s:sleep(2.1) end,
};