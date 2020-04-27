local coffee = require(game.ReplicatedStorage.statsHandler)
local minigamescript = require(game.ReplicatedStorage.Slots)

repeat
	wait()
until game.Players.LocalPlayer.Character:FindFirstChild("HumanoidRootPart") -- wait for character
--game.Players.LocalPlayer.Character.Humanoid.JumpPower = 0
--game.Players.LocalPlayer.Character:SetPrimaryPartCFrame(workspace.MonitorSeat.CFrame)
wait(1) -- extra wait for experience

local progressfill = false

game.Workspace.MonitorSeat.ChildAdded:connect(function(child)
	if child:IsA("Weld") then
		game.Players.LocalPlayer.Character.Humanoid.JumpPower = 0
		minigamescript:Start()
	end
end)
game.Workspace.MonitorSeat.ChildRemoved:connect(function(child)
	if child:IsA("Weld") then
		pcall(function()
			game.Players.LocalPlayer.Character.Humanoid.JumpPower = 50
			game.Players.LocalPlayer.PlayerGui.Slots:Destroy()
		end)
	end
end)
local spawns2 = game.Workspace.CoffeeLocations:GetChildren()

local firstTable = workspace.SpawnedIn:WaitForChild('CoffeeTable')
workspace.SpawnedIn.ChildAdded:Connect(function(child)
	if child.Name == 'CoffeeTable' then
		child:WaitForChild('Coffeerefill'):WaitForChild('ClickDetector').MouseClick:Connect(function()
	coffee.tweenProg('coffee',1)
	child:SetPrimaryPartCFrame(spawns2[math.random(#spawns2)].CFrame)
end)
	end
end)
if firstTable then firstTable.Parent = nil end

function newTable()
	coffee.tweenProg('coffee',1)
	if firstTable then
		firstTable.Parent = workspace.SpawnedIn
		firstTable:SetPrimaryPartCFrame(spawns2[math.random(#spawns2)].CFrame)
	end
end
	
_G.delTut = newTable

spawn(function() coffee.setProg('progress',0.5)coffee.setProg('coffee',0.5)game.Players.LocalPlayer:WaitForChild('PlayerGui'):WaitForChild('Status').Enabled = true end)
while true do
	if not _G.stopDecay then
		if game.ReplicatedStorage.statsHandler.coffee.Value == false then -- stop draining when filling
			coffee.setProg('coffee',coffee.stats.coffee-.012)
		end
		if game.ReplicatedStorage.statsHandler.progress.Value == false then
			coffee.setProg('progress',coffee.stats.progress-.0003)
		end
	end
	wait(1)
end