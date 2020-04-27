--Lskid

local module = {}

local characters = {"a","b","c","d","e","f","g","h","i","j","k","l","m","n","o","p","q","r","s","t","u","v","w","x","y","z"}

local answers = {
	"random",
	"math",
	"workspace",
	"players",
	"game"
}

local datamodule = require(game.ReplicatedStorage.statsHandler)

local spacedebounce = false
local items = game.ReplicatedStorage.minigames:GetChildren()

function module:Start(autospin)
	
	local gui
	local spin
	local randomnum = math.random(1,#items + 1)
	for _,v in pairs(game.Players.LocalPlayer.PlayerGui:GetChildren())do
			if v.Name =='Slots' or v.Name =='gridSolver' then
				v:Destroy()
			end
		end
	if randomnum == 1 then -- gotcha spawn now
		
		gui = items[randomnum]:Clone()
		gui.Parent = game.Players.LocalPlayer.PlayerGui
	else
		local spinning = false
		local currentslot
		
		local currentchar = ""
		
		gui = script.Slots:Clone()
		local word = answers[math.random(1,#answers)]
		local currentanswer = string.sub(word,1,1)
		local slot = script.Slot:Clone()
		slot.Name = "1"
		local label = script.CharLabel:Clone()
		label.Visible = true
		label.Text = currentanswer
		label.Parent = slot
		slot.Parent = gui.Frame.BackgroundFill.SlotHolder
		for i = 2, #word do
			local slot = script.Slot:Clone()
			slot.Name = i
			
			for i = 1, 10 do
				local char = characters[math.random(1,#characters)]
				local label = script.CharLabel:Clone()
				label.Visible = false
				label.Text = char
				label.Parent = slot
			end
			local char = string.sub(word,i,i)
			local label = script.CharLabel:Clone()
			label.Visible = false
			label.Text = char
			label.BackgroundColor3 = Color3.fromRGB(30,255,30)
			label.BackgroundTransparency = .8
			label.Parent = slot
			gui.CoffeeBreak.MouseButton1Click:connect(function()
				game.Players.LocalPlayer.Character.Humanoid.JumpPower = 50
				game.Players.LocalPlayer.Character.Humanoid.Jump = true
			end)
			
			slot.Parent = gui.Frame.BackgroundFill.SlotHolder
		end
		currentslot = gui.Frame.BackgroundFill.SlotHolder["2"]
		if game.Players.LocalPlayer.PlayerGui:FindFirstChild(gui.Name) then
			game.Players.LocalPlayer.PlayerGui[gui.Name]:Destroy()
		end
		gui.Parent = game.Players.LocalPlayer.PlayerGui
		
		spin = function()
			print("Spin")
			spacedebounce = true
			gui.Frame.BackgroundFill.CorrectSelector.ImageColor3 = Color3.fromRGB(255,170,0)
			spawn(function()
				wait(2)
				spacedebounce = false
				--gui.back.BackgroundFill.CorrectSelector.ImageColor3 = Color3.fromRGB(0, 75, 255)
			end)
			if spinning == true then
				print("Spinning")
				local mindistance = 1
				local char
				for _,label in pairs(currentslot:GetChildren()) do
					local dist = math.abs(label.Position.Y.Scale-.5)
					if dist < mindistance then
						mindistance = dist
						char = label.Text
					end
				end
				
				currentchar = char or string.sub(word,1,1)
				
				local checkstring = currentanswer..currentchar
				if string.sub(word,1,#checkstring) == checkstring then
					currentanswer = currentanswer..currentchar
					if #currentanswer == #word then
						if currentanswer == word then
							spinning = false
							spacedebounce = false
							gui.Frame.BackgroundFill.CorrectSelector.ImageColor3 = Color3.fromRGB(0, 75, 255)
							datamodule.setProg('progress',datamodule.stats.progress+.02)
							gui:Destroy()
							--module:Start(false)
							module.Start()
						end
					end
					
					local newlabel = script.CharLabel:Clone()
					newlabel.Visible = true
					newlabel.Text = currentchar
					
					if currentslot and currentslot.Parent then
						local xpos = currentslot:GetChildren()[1].Position.X
					
						currentslot:ClearAllChildren()
						newlabel.Parent = currentslot
						
						if #currentanswer < #word then
							currentslot = gui.Frame.BackgroundFill.SlotHolder[#currentanswer+1]
						end
					end
				end
				
			else
				spinning = true
				if gui and gui.Parent and spinning then
				for _,slot in pairs(gui.Frame.BackgroundFill.SlotHolder:GetChildren()) do
					local speed = math.random()*1.8 + 1
					if slot:IsA("Frame") then
						wait(math.random()/2)
						spawn(function()
							while spinning and tonumber(slot.Name) > #currentanswer and game.Players.LocalPlayer.Character.Humanoid.JumpPower ~= 50 do
								for i,label in pairs(slot:GetChildren()) do
									label.Position = UDim2.new(0,0,-.2,0)
									label.Visible = true
									
									pcall(function()
										label:TweenPosition(UDim2.new(0,0,1.2,0),Enum.EasingDirection.Out,Enum.EasingStyle.Linear,speed)
									end)
									
									wait(speed/6)
								end
							end	
						end)
					end
					
				end
			end
			
			end
			
			
			if autospin then
				pcall(function()
					spin()
				end)
			end
		end
	end
	local connection
	local function space(input,processed)
		if not processed and input.KeyCode == Enum.KeyCode.Space then
			pcall(function()
				if not gui or not gui.Parent then
					connection:Disconnect()
				elseif not spacedebounce then
					spin()
				end
			end)
		end
	end
	
	connection = game:GetService("UserInputService").InputBegan:Connect(space)
end

return module
