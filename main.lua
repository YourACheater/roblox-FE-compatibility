if game:GetService("RunService"):IsClient() then error("Script must be server-side in order to work; use h/ and not hl/") end
local Player,Mouse,mouse,UserInputService,ContextActionService = owner
do
	print("FE Compatibility code by Mokiros")
	script.Parent = Player.Character

	--RemoteEvent for communicating
	local Event = Instance.new("RemoteEvent")
	Event.Name = "UserInput_Event"

	--Fake event to make stuff like Mouse.KeyDown work
	local function fakeEvent()
		local t = {_fakeEvent=true,Connect=function(self,f)self.Function=f end}
		t.connect = t.Connect
		return t
	end

	--Creating fake input objects with fake variables
    local m = {Target=nil,Hit=CFrame.new(),KeyUp=fakeEvent(),KeyDown=fakeEvent(),Button1Up=fakeEvent(),Button1Down=fakeEvent()}
	local UIS = {InputBegan=fakeEvent(),InputEnded=fakeEvent()}
	local CAS = {Actions={},BindAction=function(self,name,fun,touch,...)
		CAS.Actions[name] = fun and {Name=name,Function=fun,Keys={...}} or nil
	end}
	--Merged 2 functions into one by checking amount of arguments
	CAS.UnbindAction = CAS.BindAction

	--This function will trigger the events that have been :Connect()'ed
	local function te(self,ev,...)
		local t = m[ev]
		if t and t._fakeEvent and t.Function then
			t.Function(...)
		end
	end
	m.TrigEvent = te
	UIS.TrigEvent = te

	Event.OnServerEvent:Connect(function(plr,io)
	    if plr~=Player then return end
		if io.isMouse then
			m.Target = io.Target
			m.Hit = io.Hit
		else
			local b = io.UserInputState == Enum.UserInputState.Begin
			if io.UserInputType == Enum.UserInputType.MouseButton1 then
				return m:TrigEvent(b and "Button1Down" or "Button1Up")
			end
			for _,t in pairs(CAS.Actions) do
				for _,k in pairs(t.Keys) do
					if k==io.KeyCode then
						t.Function(t.Name,io.UserInputState,io)
					end
				end
			end
			m:TrigEvent(b and "KeyDown" or "KeyUp",io.KeyCode.Name:lower())
			UIS:TrigEvent(b and "InputBegan" or "InputEnded",io,false)
	    end
	end)
	Event.Parent = NLS([==[
	local Player = game:GetService("Players").LocalPlayer
	local Event = script:WaitForChild("UserInput_Event")

	local UIS = game:GetService("UserInputService")
	local input = function(io,a)
		if a then return end
		--Since InputObject is a client-side instance, we create and pass table instead
		Event:FireServer({KeyCode=io.KeyCode,UserInputType=io.UserInputType,UserInputState=io.UserInputState})
	end
	UIS.InputBegan:Connect(input)
	UIS.InputEnded:Connect(input)

	local Mouse = Player:GetMouse()
	local h,t
	--Give the server mouse data 30 times every second, but only if the values changed
	--If player is not moving their mouse, client won't fire events
	while wait(1/30) do
		if h~=Mouse.Hit or t~=Mouse.Target then
			h,t=Mouse.Hit,Mouse.Target
			Event:FireServer({isMouse=true,Target=t,Hit=h})
		end
	end]==],Player.Character)
	local _rg = game
	local function FakeService(t,RealService)
		t._RealService = typeof(RealService)=="string" and _rg:GetService(RealService) or RealService
		return setmetatable(t,{
			__index = function(self,k)
					local s = rawget(self,"_RealService")
				if s then return s[k] end
			end,
			__newindex = function(self,k,v)
				local s = rawget(self,"_RealService")
				if s then s[k]=v end
			end,
		})
	end
	local g = setmetatable({
		GetService = function(self,s)
			return self[s]
		end,
		Players = FakeService({
			LocalPlayer = FakeService({GetMouse=function(self)return Mouse end},owner)
		},"Players"),
		UserInputService = FakeService(UIS,"UserInputService"),
		ContextActionService = FakeService(CAS,"ContextActionService")
	},{__index=function(self,s)
		return _rg:GetService(s) or typeof(_rg[s])=="function"
				and function(_,...)return _rg[s](_rg,...)end end
	})
	game = g
	owner = g.Players.LocalPlayer
end