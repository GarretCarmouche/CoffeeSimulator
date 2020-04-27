game.Players.PlayerAdded:Connect(function(plr)
	local ls = Instance.new('Folder',plr)
	ls.Name = 'leaderstats'
	local caffeineVal = Instance.new('NumberValue')
	caffeineVal.Name =  'Caffeine'
	caffeineVal.Value = 1
	caffeineVal.Parent = ls
end)