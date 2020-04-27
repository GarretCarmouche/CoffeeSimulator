local number = 1
for i,tablenumber in pairs(game.Workspace.TableNumbers:GetChildren()) do
	tablenumber.SurfaceGui.TextLabel.Text = number
	number = number + 1
end
local script2 = require(game.Workspace.Script2.minigameloader)
script2.StartMinigame()