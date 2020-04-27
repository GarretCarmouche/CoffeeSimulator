local grid = script.Parent.back.grid
local uis = game:GetService("UserInputService")
local gridSize = Vector2.new(10,10)
local tileSizeX,tileSizeY = 1/gridSize.X,1/gridSize.Y
local renderPerSecond = 0.3
local points = {}

local minigamescript = require(game.ReplicatedStorage.Slots)
local coffee = require(game.ReplicatedStorage.statsHandler)
unpackv2 = function(v2)
	return v2.X,v2.Y
end
newGridPoint = function(x,y, returnc)
	local point = Instance.new('Frame',grid)
	point.Position = UDim2.new(x,0,y,0)
	point.Size = UDim2.new(tileSizeX,0,tileSizeY,0)
	point.BackgroundColor3 = Color3.fromRGB(40,40,40)
	point.BorderSizePixel = 0
	point.ZIndex = 1
	if returnc then
		return point
	end
	table.insert(points, point)
end
setPoint = function(point)
	point = point - Vector2.new(1,1)
	if point.X == 0 and point.Y == 0 then
		return
	end
	local x,y = unpackv2(point)
	local posX,posY = tileSizeX*x,tileSizeY*y
	local gridPoint = newGridPoint(posX,posY)
end
getMinMax = function(v)
	return v.AbsolutePosition,v.AbsolutePosition+(v.AbsoluteSize)
end

function BoundaryCheck(Gui1, Gui2)
local pos1, size1 = Gui1.AbsolutePosition, Gui1.AbsoluteSize;
local pos2, size2 = Gui2.AbsolutePosition, Gui2.AbsoluteSize;

local top = pos2.Y-pos1.Y
local bottom = pos2.Y+size2.Y-(pos1.Y+size1.Y)
local left = pos2.X-pos1.X
local right = pos2.X+size2.X-(pos1.X+size1.X)
local In = true

if top > 0 then
	In = false
elseif bottom < 0 then
	In = false
end
if left > 0 then
	In = false
elseif right < 0 then
	In = false
end

return In
end

function istouchingwall(line)
	for i,v in pairs(points) do
		if BoundaryCheck(line, v) then
			return true
		end
	end
	
	return false
end

local curLine
local dir = "X"
local speed = 1
local def = false

function makeNewLine()
	local newLine = Instance.new("Frame")
	newLine.Position = curLine and curLine.Position or UDim2.new(0,0,0,0)
	if newLine.Position.X.Scale == 0 and newLine.Position.Y.Scale == 0 then
		def = true
	else
		def = false
	end
	newLine.Parent = grid
	newLine.BorderSizePixel = 0
	newLine.BackgroundColor3 = Color3.fromRGB(0, 170, 255)
	Instance.new("UIAspectRatioConstraint", newLine)
	return newLine
end

uis.InputBegan:Connect(function(input, gpe)
	if input.KeyCode then
		if input.KeyCode == Enum.KeyCode.S then
			dir = "Y"
			speed = 1
		elseif input.KeyCode == Enum.KeyCode.A then
			dir = "X"
			speed = -1
		elseif input.KeyCode == Enum.KeyCode.W then
			dir = "Y"
			speed = -1
		elseif input.KeyCode == Enum.KeyCode.D then
			dir = "X"
			speed = 1
		end
	end
end)

function genWalls()
	local rand = Random.new(tick())
	
	for x=1,gridSize.X,1 do
		for y=1,gridSize.Y,1 do
			if rand:NextInteger(0,4) == 4 then
				setPoint(Vector2.new(x,y))
			end
		end
	end
end

local rendering = true

local endBox

function establishEnd()
	local point = newGridPoint(tileSizeX*9, tileSizeY*9, true)
	
	point.BackgroundColor3 = Color3.new(0,255,0)
	point.Transparency = 0.5
	
	endBox = point
end

function isTouchingEnd(line)
	if BoundaryCheck(line, endBox) then
		return true
	end
	
	return false
end

function reset()
	print("called reset")
	curLine = nil
	rendering = false
	dir = "X"
	speed = 1
	def = false
	endBox = nil
	
	for i,v in pairs(grid:GetChildren()) do
		v:Destroy()
	end
	
	genWalls()
	
	rendering = true
	
	establishEnd()
	init()
end

genWalls()

function win()
	print("ok u won")
	coffee.setProg('progress',coffee.stats.progress+ 0.02)
	minigamescript:Start()
end

function init()
	while wait(renderPerSecond) and rendering do
		local newLine = makeNewLine()
		
		if dir == "X" then
			if curLine then
				curLine.Position = curLine.Position + UDim2.new(tileSizeX/4 * speed,0,0,0)
				
				if curLine and istouchingwall(curLine) or curLine.Position.X.Scale > 1 or curLine.Position.X.Scale < 0 then
					reset()
				elseif isTouchingEnd(curLine) then
					win()
				end
				
				curLine.Position = curLine.Position - UDim2.new(tileSizeX/4 * speed,0,0,0)
			end
			
			curLine = newLine
			
			curLine.Size = UDim2.new(0,0,tileSizeY/3,0)
			curLine.Position = curLine.Position + UDim2.new(tileSizeX/3 * speed, 0, 0, 0)
			curLine:TweenSizeAndPosition(UDim2.new(tileSizeX/3,0,tileSizeY/2,0),curLine.Position,nil,nil,0.25,true)
		elseif dir == "Y" then
			if curLine then
				curLine.Position = curLine.Position + UDim2.new(0, 0, tileSizeY/2 * speed, 0)
				
				if curLine and istouchingwall(curLine) or curLine.Position.Y.Scale > 1 or curLine.Position.Y.Scale < 0 then
					reset()
				elseif isTouchingEnd(curLine) then
					win()
				end	
				
				curLine.Position = curLine.Position - UDim2.new(0, 0, tileSizeY/2 * speed, 0)
			end
			
			curLine = newLine
	
			curLine.Size = UDim2.new(tileSizeX/32,0,0,0)
			curLine.Position = curLine.Position + UDim2.new(0, 0, tileSizeY/1.5 * speed, 0)
			curLine:TweenSizeAndPosition(UDim2.new(tileSizeX/3,0,tileSizeY/2,0),curLine.Position,nil,nil,0.25,true)
		end
	end
end
script.Parent.CoffeeBreak.MouseButton1Down:Connect(function()
				game.Players.LocalPlayer.Character.Humanoid.JumpPower = 50
				game.Players.LocalPlayer.Character.Humanoid.Jump = true	
				script.Parent:Destroy()
end)

establishEnd()
init()