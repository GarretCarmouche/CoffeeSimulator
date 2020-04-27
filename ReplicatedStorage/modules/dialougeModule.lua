local defaultConfig = {
	typeStepTime = 0;
	autoCloseTime = 4;
	}
local m = {}
local plrNameLabel,plrChatLabel,frame,plr,plrGui,gui
local connections = {}
local spellOut = function(label,text)
	for i=1,string.len(text) do
		label.Text = string.sub(text,1,i)
		wait(defaultConfig.typeStepTime)
	end
end
m.prompt = function(name,text,rtn)
	frame.Visible = true
	for _,v in pairs(connections) do
		v:Disconnect()
	end
	plrNameLabel.Text = name
	--plrChatLabel = ''
	spellOut(plrChatLabel,text)
	if not rtn then
		wait(defaultConfig.autoCloseTime)
		frame.Visible = false
	else
		rtn(frame)
	end
end
m.init = function()
	plr = game.Players.LocalPlayer
	plrGui = plr:WaitForChild('PlayerGui')
	gui = plrGui:WaitForChild('Dialogue')
	frame = gui:WaitForChild('DialogueFrame')
	plrNameLabel = frame:WaitForChild('nameLabel'):WaitForChild('label')
	plrChatLabel = frame:WaitForChild('chatLabel'):WaitForChild('label')
end
return m
