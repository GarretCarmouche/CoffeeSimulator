local plr = game.Players.LocalPlayer
local plrGui = plr:WaitForChild('PlayerGui')
local gui = plrGui:WaitForChild('gui')
local caffeineBar --= path.to.caffiene
--do loading thingy with ui
game.StarterGui:SetCoreGuiEnabled(Enum.CoreGuiType.All,false)
local modules = game:GetService('ReplicatedStorage'):WaitForChild('modules')
local dModule = require(modules.dialougeModule)
dModule.init()--initiate the dialouge module
local ls = plr:WaitForChild('leaderstats')
local caffeineVal = ls:WaitForChild('Caffeine')
setCaffeineBar = function(val)
	caffeineBar.Size = UDim2.new(val,0,1,0)
	caffeineBar.Color = Color3.new(1-val,val,0) -- fade to red for lower vals
end
--caffeineVal.Changed:Connect(setCaffeineBar)
--setCaffeineBar(caffeineVal.Value)
local fadeFrame,fadeTween
blackOut = function()
	fadeFrame = Instance.new('Frame',gui)
	fadeFrame.Size = UDim2.new(1,0,1,0)
	fadeFrame.BackgroundColor3 = Color3.new(0,0,0)
	fadeFrame.BackgroundTransparency = 1
	fadeTween = game:GetService('TweenService'):Create(fadeFrame,TweenInfo.new(1),{Transparency=0})
	fadeTween:Play()
	
end
deathHandler = function()
	blackOut()
end
charAdded = function(char)
	char:WaitForChild('Humanoid').Died:Connect(deathHandler)
	if fadeFrame then
		fadeTween:Cancel()
		game:GetService('TweenService'):Create(fadeFrame,TweenInfo.new(1),{Transparency=1}):Play()
		game:GetService('Debris'):AddItem(fadeFrame,2)
	end
end
local char = plr.Character or plr.CharacterAdded:Wait()
charAdded(char)
plr.CharacterAdded:Connect(charAdded)

wait(2)
--dModule.prompt('bazook','ooga booga')