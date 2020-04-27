--Lskid

local t = {
	{true,true,false,false,false,true,true},
	{true,true,true,true,false,false,false},
	
}
local elevation = -100
local startpos = Vector3.new(100,elevation,100)

local partsize = Vector3.new(10,10,10)

function generate(datatable)
	for y,row in pairs(datatable) do
		for x, column in pairs(row) do
			local partpos = startpos + Vector3.new(x*partsize.X,elevation,y*partsize.Y)
			local part = Instance.new("Part")
			part.Anchored = true
			part.CFrame = CFrame.new(partpos.X,partpos.Y,partpos.Z)
			part.Color = (column and Color3.new(0,1,0)) or Color3.new(1,0,0)
			part.Size = partsize
			part.Parent = game.Workspace.Minigame1Parts
		end
	end
end

function generatetable()
	local seed = math.random()
	local t = {}
	for y = 0, 20 do
		t[y] = {}
		for x = 0, 20 do
			t[y][x] = math.noise(x,y,seed) >-.3
		end
	end
	return t
end

generate(generatetable())