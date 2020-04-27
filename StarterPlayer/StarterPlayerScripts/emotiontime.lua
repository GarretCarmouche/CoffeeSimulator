
local userinput = game:GetService("UserInputService")
click = false

function waitForClick(frame)
	repeat wait() until click == true
	click = false
	
	if frame then
		frame.Visible = false
	end
end

_G.initEmotion = function()
	local screengui = Instance.new("ScreenGui")
	local fader = Instance.new("Frame")
	fader.BackgroundColor3 = Color3.new(0,0,0)
	fader.Size = UDim2.new(10,0,10,0)
	fader.Position = UDim2.new(-2,0,-2,0)
	fader.BackgroundTransparency = 1
	fader.Parent = screengui
	screengui.Parent = game.Players.LocalPlayer.PlayerGui
	
	for i=1,0,-0.1 do
		wait()
		fader.BackgroundTransparency = i
	end
	
	game.Players.LocalPlayer.PlayerGui.Status.Enabled = false
	
	wait(3)
	
	local dialogue = require(game.ReplicatedStorage.modules.dialougeModule)
	dialogue.init()
	click = false
	dialogue.prompt("You", "I.. I fell asleep? How?", waitForClick)
	waitForClick()
	
	dialogue.prompt("You", "If only I stayed awake.. I could have won!", waitForClick)
	waitForClick()
	
	dialogue.prompt("You", "Although,", waitForClick)
	waitForClick()
	
	dialogue.prompt("You", "Maybe RDC isn't about just competition.", waitForClick)
	waitForClick()
	
	dialogue.prompt("You", "Maybe this isn't just about creating the best experience.", waitForClick)
	waitForClick()
	
	dialogue.prompt("You", "Maybe this is about making great experiences with friends.", waitForClick)
	waitForClick()
	
	dialogue.prompt("You", "Maybe sometimes we forget about this.", waitForClick)
	waitForClick()
	
	dialogue.prompt("You", "Maybe we forget that game development isn't just about monetization and statistics.", waitForClick)
	waitForClick()
	
	dialogue.prompt("You", "Everything we envision", waitForClick)
	waitForClick()
	
	dialogue.prompt("You", "Everything we imagine", waitForClick)
	waitForClick()
	
	dialogue.prompt("You", "It's to bring people together", waitForClick)
	waitForClick()
	
	dialogue.prompt("You", "Because this isn't just a game development platform", waitForClick)
	waitForClick()
	
	dialogue.prompt("You", "This is the Imagination Platform.", waitForClick)
	waitForClick()
end

userinput.InputBegan:Connect(function(input, gpe)
	if input.UserInputType == Enum.UserInputType.MouseButton1 then
		click = true
	end
end)