--Lskid

local screengui = Instance.new("ScreenGui")
workspace.IntroTable.Arrow2.Transparency = 1

local fader = Instance.new("Frame")
fader.BackgroundColor3 = Color3.new(0,0,0)
fader.Position = UDim2.new(-2,0,-2,0)
fader.Size = UDim2.new(10,0,10,0)
fader.BorderSizePixel = 0
fader.Parent = screengui
fader.BackgroundTransparency = 0
screengui.Parent = game.Players.LocalPlayer.PlayerGui
wait(1)
for i=0,1,0.01 do
	wait()
	fader.BackgroundTransparency = i
end

local cl = false

wait(0.5)

local rep = game:GetService("ReplicatedStorage")
local stats = require(rep.statsHandler)

local dialogue = require(rep.modules.dialougeModule)

dialogue.init()

function finish()
	if workspace:FindFirstChild("IntroTable") then
		workspace.IntroTable:Destroy()
		_G.delTut()
	end
end

function closefunc2(frame)
	workspace.MonitorSeat.Touched:Connect(function(t)
		if t:FindFirstAncestorOfClass("Model") then
			frame.Visible = false
			finish()
		end
	end)
end

function closefunc(frame)
	workspace.IntroTable.Coffeerefill.ClickDetector.MouseClick:Connect(function()
		if not cl then
			frame.Visible = false
			cl = true
			workspace.IntroTable.Coffeerefill.ClickDetector:Destroy()
			workspace.IntroTable.Arrow.Transparency = 1
			dialogue.prompt("You", "Now that I've got some caffeine I should get back to development. I've got progress to make.", closefunc2)
			workspace.IntroTable.Arrow2.Transparency = 0
		end
	end)
	
	workspace.IntroTable.Coffeerefill.ClickDetector.MouseClick:Wait()
end

dialogue.prompt("You", "Man, I'm running out of coffee. I should go get some.", closefunc)