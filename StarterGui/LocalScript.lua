local grid = script.Parent.back.grid
local gridSize = Vector2.new(10,10)
local tileSizeX,tileSizeY = 1/gridSize.X,1/gridSize.Y
local points = {}
unpackv2 = function(v2)
	return v2.X,v2.Y
end
newGridPoint = function(x,y)
	local point = Instance.new('Frame',grid)
	point.Position = UDim2.new(x,0,y,0)
	point.Size = UDim2.new(tileSizeX,0,tileSizeY,0)
	table.insert(points,point)
end
setPoint = function(point)
	point = point - Vector2.new(1,1)
	local x,y = unpackv2(point)
	local posX,posY = tileSizeX*x,tileSizeY*y
	local gridPoint = newGridPoint(posX,posY)
end
getMinMax = function(v)
	return v.AbsolutePosition,v.AbsolutePosition+(v.AbsoluteSize)
end
checkCollision = function(min,max)
	local minX,minY = unpackv2(min)
	local maxX,maxY = unpackv2(max)
	for _,v in pairs(points) do
		local pointMinX,pointMinY = unpackv2(v.AbsolutePosition)
		local pointMaxX,pointMaxY = unpackv2(v.AbsolutePosition+(v.AbsoluteSize))
		if pointMinX <= minX and pointMaxX >= maxX and pointMinY <= minY and pointMaxY >= maxY then
			return v
		end
	end
	return false
end
local startPos = Vector2.new(0,0)
lineStart = startPos
local line
dir = 'X'
way = 1
newLine = function(newDir)
	local linePos,startPos
	if line then
		startPos = line.Position+line.Size
	end
	linePos = startPos or UDim2.new()
	line = Instance.new('Frame',grid)
	line.Position = linePos
	dir = newDir
end
local uis = game:GetService('UserInputService')
uis.InputBegan:Connect(function(input)
	if input.KeyCode == Enum.KeyCode.D then
		newLine('X')
		way = 1
	elseif input.KeyCode == Enum.KeyCode.A then
		newLine('X')
		way = -1
	elseif input.KeyCode == Enum.KeyCode.S then
		 newLine('Y')
		way = 1
	elseif input.KeyCode == Enum.KeyCode.W then
		newLine('Y')
		way = -1
	end
end)
local seed = math.random()
for y = 1, gridSize.Y do
	for x = 1, gridSize.X do
		if math.noise(x,y,seed) >.3 then
			setPoint(Vector2.new(x,y))
		end
	end
end
while wait() do
	if line then
		if dir =='X' then
			line.Size = line.Size + UDim2.new(0,1 * way,0,0)
		else
			line.Size = line.Size + UDim2.new(0,0,0,1 * way)
		end
	end
	if line and checkCollision(getMinMax(line)) then
		print('OOOFF')
	end
end