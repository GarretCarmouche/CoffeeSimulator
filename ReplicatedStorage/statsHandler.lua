local module = {}
module.stats = {
	coffee = 1;
	progress = 1;
}
local tween
local cachedVal = 0
local setStatFrame = function(statFrame,val)
	val = math.max(val,0.01)
	statFrame.cut.Size = UDim2.new(val,0,1,0)
	statFrame.cut.fill.Size = UDim2.new(1/val,0,1,0)
end
local tweenStatsFrame = function(statFrame,val,secs)
	if tween then tween:Cancel() end
	local valObj = Instance.new('NumberValue')
	local connection = valObj.Changed:Connect(function(newVal)
		setStatFrame(statFrame,newVal)
	end)
	local startVal = module.stats[statFrame.Name]
	valObj.Value = startVal
	tween = game:GetService('TweenService'):Create(valObj,TweenInfo.new(secs),{Value=val})
	tween:Play()
	spawn(function()
		script[statFrame.Name].Value = true
		wait(secs)
		wait()
		connection:Disconnect()
		valObj:Destroy()
		script[statFrame.Name].Value = false
	end)
end
doKillStuff = function()
	_G.timeout()
end

function module.tweenProg(statName,Value)
	local plr = game.Players.LocalPlayer
	local plrGui = plr:WaitForChild('PlayerGui')
	local statGui = plrGui:WaitForChild('Status'):WaitForChild('stats')
	local coffee = statGui:WaitForChild(statName)
	tweenStatsFrame(coffee,Value,1)
	if module.stats.coffee <= 0 then
		doKillStuff()
	end
	module.stats[statName] = Value
end

function module.setProg(statName,Value)
	local plr = game.Players.LocalPlayer
	local plrGui = plr:WaitForChild('PlayerGui')
	local statGui = plrGui:WaitForChild('Status'):WaitForChild('stats')
	local coffee = statGui:WaitForChild(statName)
	setStatFrame(coffee,Value)
	if module.stats.coffee <= 0 then
		doKillStuff()
	end
	module.stats[statName] = Value
end
module.drain = function()
	module.tweenProg('coffee',0)
end

return module
