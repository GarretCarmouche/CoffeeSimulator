
local module2 = require(script.minigameloader)
module2.StartMinigame()

local module = require(game.Workspace.ModuleScript)

local t = {
	{true,true,false,false,false,true,true},
	{true,true,true,true,false,false,false},
	
}

module.generate(t)
