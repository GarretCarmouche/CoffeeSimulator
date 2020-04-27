--Lskid

local NPCs = {}

local PFS = game:GetService("PathfindingService")
for i = 1, 8 do
	local NPC = script.NPC:Clone()
	NPCs[i] = NPC
end

local nodes = game.Workspace.NPCNodes:GetChildren()
local node = nodes[math.random(#nodes)]

for i,NPC in pairs(NPCs) do
	local zoffset = (i % 3) * 3
	local xoffset = i
	NPC.Parent = game.Workspace.NPCs
	local pos = node.Position + Vector3.new(xoffset,0,zoffset)
	NPC:MoveTo(pos)
end

while true do
	local node = nodes[math.random(#nodes)]
	for i,NPC in pairs(NPCs) do
		spawn(function()
			local zoffset = (i % 3) * 3
			local xoffset = i
			NPC.Parent = game.Workspace.NPCs
			local pos = node.Position + Vector3.new(xoffset,0,zoffset)
			local anim = NPC.Humanoid:LoadAnimation(NPC.Animate.run.RunAnim)
			anim:Play()
			local path = PFS:CreatePath()
			path:ComputeAsync(NPC.HumanoidRootPart.Position,pos)
			local points = path:GetWaypoints()
			for _,point in pairs(points) do
				NPC.Humanoid:MoveTo(point.Position)
				NPC.Humanoid.MoveToFinished:Wait()
			end
			anim:Stop()
		end)
		
	end
	wait(math.random()*10)
end