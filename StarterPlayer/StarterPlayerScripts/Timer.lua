--Lskid

local textlabel = game.Workspace.TimerScreen.Screen.SurfaceGui.TextLabel
local t = 4*60
local TS = game:GetService("TweenService")
local dialog = require(game.ReplicatedStorage.modules.dialougeModule)
function timeout()
	game.Players.LocalPlayer.PlayerGui.Status.Enabled = false
	textlabel.Text = 'WINNERS'
		for _,v in pairs(game.Players.LocalPlayer.PlayerGui:GetChildren())do
			if v.Name =='Slots' or v.Name =='gridSolver' then
				v:Destroy()
			end
		end
		
		game.Players.LocalPlayer.Character.Humanoid.Jump = true
		
		workspace.MonitorSeat:Destroy()
	
	local fadegui = Instance.new("ScreenGui")
	local fadeframe = Instance.new("Frame")
	fadeframe.BackgroundColor3 = Color3.fromRGB(0,0,0)
	fadeframe.BackgroundTransparency = 1
	fadeframe.Size = UDim2.new(1,0,1,0)
	fadeframe.Parent = fadegui
	fadegui.IgnoreGuiInset = true
	fadegui.Parent = game.Players.LocalPlayer.PlayerGui
	TS:Create(fadeframe,TweenInfo.new(1.5),{BackgroundTransparency = .4}):Play()
	wait(1.5)
	TS:Create(fadeframe,TweenInfo.new(1.5),{BackgroundTransparency = .8}):Play()
	wait(1.5)
	TS:Create(fadeframe,TweenInfo.new(2),{BackgroundTransparency = .2}):Play()
	wait(2)
	TS:Create(fadeframe,TweenInfo.new(2.5),{BackgroundTransparency = .6}):Play()
	wait(2.5)
	TS:Create(fadeframe,TweenInfo.new(2.75),{BackgroundTransparency = 0}):Play()
	wait(3)
	local npcs = game.ReplicatedStorage.StageNPCs:GetChildren()
	local clonenpcs = {}
	for i,npc in pairs(npcs) do
		npc = npc:Clone()
		clonenpcs[#clonenpcs+1] = npc
		npc.Parent = game.Workspace
		npc:MoveTo(game.Workspace.StageNodes[i].Position)
	end
	game.Workspace.CurrentCamera.CameraType = Enum.CameraType.Scriptable
	game.Players.LocalPlayer.PlayerScripts.CameraScript.Disabled = true
	wait(.5)
	game.Workspace.CurrentCamera.CFrame = CFrame.new(-136.74,17.5,-9.25) * CFrame.Angles(math.rad(-22.5),0,0)
	wait(1)
	TS:Create(fadeframe,TweenInfo.new(3),{BackgroundTransparency = 1}):Play()
	spawn(function()
		clonenpcs[3].Humanoid:LoadAnimation(clonenpcs[3].Animate.idle.Animation1):Play()
		wait(1.3)
		local anim = clonenpcs[1].Humanoid:LoadAnimation(clonenpcs[1].Animate.wave.WaveAnim)
		anim.Looped = false
		anim:Play()
		wait(.9)
		anim = clonenpcs[2].Humanoid:LoadAnimation(clonenpcs[1].Animate.toollunge.ToolLungeAnim)
		anim:Play()
		wait(1.2)
		local anim = clonenpcs[1].Humanoid:LoadAnimation(clonenpcs[1].Animate.wave.WaveAnim)
		anim.Looped = false
		anim:Play()
	end)
	wait(.5)
	dialog.prompt("JParty","Here are your grand champions!")
	wait(.9)
	TS:Create(fadeframe,TweenInfo.new(2),{BackgroundTransparency = 0}):Play()
	wait(2)
	_G.initEmotion()
	for _,npc in pairs(clonenpcs) do
		npc:Destroy()
	end
	--game.Players.LocalPlayer.PlayerGui.Status.Enabled = false
end

local breaktime = false

_G.timeout = function()
	breaktime = true
end

while wait(1) do
	t = t - 1
	local min = math.floor(t / 60)
	local sec = t % 60
	local s = ""
	if min < 10 then
		s = "0"..min
	else
		s = ""..min
	end
	s = s .. ":"
	if sec < 10 then
		s = s.."0"..sec
	else
		s = s..sec
	end
	textlabel.Text = s
	if t <= 0 or breaktime then
		timeout()
		break
	end
end