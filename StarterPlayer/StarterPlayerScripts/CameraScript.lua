local TweenService = game:GetService("TweenService")
local RunService = game:GetService("RunService")
local ContextActionService = game:GetService("ContextActionService")
local camera = workspace.CurrentCamera
camera.CameraType = Enum.CameraType.Scriptable
local rotationAngle = Instance.new("NumberValue")
local tweenComplete = false

local updateTime = .1
local lastUpdate = tick()

local cameraOffset = Vector3.new(0, 10, 12)
local lookAtTarget = true  -- Whether the camera tilts to point directly at the target
 
local function updateCamera(rootPart)
	local tInfo = TweenInfo.new(0.1, Enum.EasingStyle.Linear, Enum.EasingDirection.In)
	
	local poppermod = require(script.Poppercam)
	local popper = poppermod.new()
	popper:Enable()
	
	local updatedpop,uselessthingidontneed = popper:Update(cameraOffset.z, (rootPart.CFrame * CFrame.new(cameraOffset.x, cameraOffset.y, cameraOffset.z) * CFrame.Angles(0,0,0)), rootPart.CFrame, popper.focusExtrapolator)
	
	local rootCam = rootPart.CFrame * CFrame.new(cameraOffset.x, cameraOffset.y, cameraOffset.z) * CFrame.Angles(math.rad(-20),0,0)
	
	local tween = TweenService:Create(camera, tInfo, {CFrame = updatedpop * CFrame.Angles(math.rad(20),0,0)})
	tween:Play()
end
 
-- Update camera position while tween runs
game.Players.LocalPlayer.CharacterAdded:Connect(function(character)
	RunService.RenderStepped:Connect(function()
		if (tick() - lastUpdate) < updateTime then
			return
		end
		repeat
			wait()
		until character:FindFirstChild("HumanoidRootPart")
		updateCamera(character:WaitForChild("HumanoidRootPart"))
	end)
end)