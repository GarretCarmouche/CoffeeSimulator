local module = {}

local Obstacles = game.ReplicatedStorage.ObstaclesSpawns:GetChildren()
local spawns = game.Workspace.ObstaclesLocations:GetChildren()

local Obstacles2 = game.ReplicatedStorage.ObstaclesSpawnscoffee:GetChildren()
local spawns2 = game.Workspace.CoffeeLocations:GetChildren()

local rate = 4

local spawnin = function()
	for i,Location in pairs(workspace.ObstaclesLocations:GetChildren()) do
		local randomnum = math.random(1,rate)
		if randomnum == 2 then -- gotcha spawn now
			local Obstacle = Obstacles[math.random(#Obstacles)]
			local newobst = Obstacle:Clone()
			newobst.Parent = workspace.SpawnedIn
			newobst:SetPrimaryPartCFrame(spawns[math.random(#spawns)].CFrame)
		end
	end
end

local spawnin2 = function()
	for i,Location in pairs(spawns2) do
		local randomnum = math.random(1,rate)
		if randomnum == 2 then -- gotcha spawn now
			if not workspace.SpawnedIn:FindFirstChild("CoffeeTable") then
				local Obstacle = Obstacles2[math.random(#Obstacles2)]
				local newobst = Obstacle:Clone()
				newobst.Parent = workspace.SpawnedIn
				newobst:SetPrimaryPartCFrame(spawns2[math.random(#spawns2)].CFrame)
			elseif workspace.SpawnedIn:FindFirstChild("CoffeeTable") then
				workspace.SpawnedIn:FindFirstChild("CoffeeTable"):SetPrimaryPartCFrame(spawns2[math.random(#spawns2)].CFrame)
			end
		end
	end
end

function module.StartMinigame()
	for i,Item in pairs(workspace.SpawnedIn:GetChildren()) do
		if Item.Name ~= "CoffeeTable" then
			Item:Destroy() -- destroy old obstacles
		end
	end
	
	-- spawn in new obstacles
	spawnin()
	spawnin2()
	if not workspace.SpawnedIn:FindFirstChildOfClass("Model") or workspace.SpawnedIn:FindFirstChild("CoffeeTable") then -- small change BUT its possible
		repeat
			if not workspace.SpawnedIn:FindFirstChildOfClass("Model") then
				print("camehere1")
				spawnin()
			end
			wait()
		until workspace.SpawnedIn:FindFirstChildOfClass("Model")
	end
	if not workspace.SpawnedIn:FindFirstChild("CoffeeTable") then -- small change BUT its possible
		repeat
			if not workspace.SpawnedIn:FindFirstChild("CoffeeTable") then
				print("camehere2")
				spawnin2()
			end
			wait()
		until workspace.SpawnedIn:FindFirstChild("CoffeeTable")
	end
end


return module
