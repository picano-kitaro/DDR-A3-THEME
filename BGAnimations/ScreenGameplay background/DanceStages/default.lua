-- Original Author:Jose_Varela
-- Editor:Enciso0720
-- Last Update:20230813

local t = Def.ActorFrame{
	SPos = GAMESTATE:GetSongPosition();

	OnCommand=function(self)
		self:Center():fov(gFOV());
		Camera = self
		if not (HasVideo() and _VERSION ~= "Lua 5.3") then Camera:SetUpdateFunction(SlowMotion) end
	end;
};
------- DANCESTAGE LOADER -------
local StagesFolder = "/DanceStages/"
local DanceStage = DanceStageLoader()

if (not HasVideo() and not PotentialModSong()) or (HasVideo() and VideoStage() and not PotentialModSong()) or (HasVideo() and not VideoStage() and not VoverS()) then
	
------- DANCESTAGE LOADER 1 -------

t[#t+1] = LoadActor(StagesFolder..DanceStage.."/LoaderA.lua" )

-------------- CHARACTERS --------------
if not (ReadOrCreateRageValueForPlayer(PLAYER_1, "Character", "Random") == "None") or (ReadOrCreateRageValueForPlayer(PLAYER_2, "Character", "Random") == "None") then
	t[#t+1] = LoadActor("Characters");
end
------- DANCESTAGE LOADER 2 -------

if FILEMAN:DoesFileExist(StagesFolder..DanceStage.."/LoaderB.lua") then
	t[#t+1] = LoadActor(StagesFolder..DanceStage.."/LoaderB.lua" )
end

------- CAMERA -------

	t[#t+1] = LoadActor(StagesFolder..DanceStage.."/Cameras.lua" )


	CamRan=1
	local CameraRandomList = {}
	
	for i = 1, NumCameras do
		CameraRandomList[i] = i
	end
	
	for i = 1, NumCameras do
		local CamRandNumber = math.random(1,NumCameras)
		local TempRand = CameraRandomList[i]
			CameraRandomList[i] = CameraRandomList[CamRandNumber]
			CameraRandomList[CamRandNumber] = TempRand
	end


	t[#t+1] = Def.Quad{
		OnCommand=function(self)
			self:visible(false)
			:queuemessage("Camera"..CameraRandomList[6]):sleep(WaitTime[CameraRandomList[6]]):queuecommand("TrackTime");
		end;
		TrackTimeCommand=function(self)
		DEDICHAR:SetTimingData()
		self:sleep(1/60)
		self:queuemessage("Camera"..CameraRandomList[CamRan]):sleep(WaitTime[CameraRandomList[CamRan]])
			CurrentStageCamera = CurrentStageCamera
				CamRan=CamRan+1
				if CamRan==NumCameras then
					CamRan = 1
				end
			self:queuecommand("TrackTime")
		end,
	};
end;

return t;