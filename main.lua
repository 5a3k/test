repeat wait() until game.IsLoaded
repeat wait() until game.Players.LocalPlayer

local Clutter = loadstring(game:HttpGet("https://raw.githubusercontent.com/5a3k/test/main/clutter.lua"))()

CoreGui = game:GetService("CoreGui")
Players = game:GetService("Players")
RunService = game:GetService("RunService")
TweenService = game:GetService("TweenService")
InputService = game:GetService("UserInputService")
LogService = game:GetService("LogService")
TeleportService = game:GetService("TeleportService")
HttpService = game:GetService("HttpService")
ReplicatedFirst = game:GetService("ReplicatedFirst")

local InternalUI = CoreGui:FindFirstChild("InternalUI")
if InternalUI then 
    InternalUI:Destroy()
end

Player = Players.LocalPlayer
Character = Player.Character
Mouse = Player:GetMouse()

Directory = "Alpha/"

----- ===== Setup ===== -----
if not isfolder("Alpha") then makefolder("Alpha") end
if not isfolder("Alpha/Settings") then makefolder("Alpha/Settings") end

if not isfile("Alpha/Settings/Theme") then writefile("Alpha/Settings/Theme", "default") end

----- ===== InternalUI ===== -----

local Theme = readfile("Alpha/Settings/Theme")

local Themes = {
    ["default"] = {
        TaskbarColor = Color3.fromRGB(25, 25, 25),
        ToolbarColor = Color3.fromRGB(42, 42, 42),
        BackgroundColor = Color3.fromRGB(32, 32, 32),
        ButtonColor = Color3.fromRGB(42, 42, 42),
        AccentColor = Color3.fromRGB(151, 151, 151),
        TextBoxColor = Color3.fromRGB(25, 25, 25),
        FillerColor = Color3.fromRGB(42, 42, 42)
    },
    ["blossom"] = {
        TaskbarColor = Color3.fromRGB(27, 27, 41),
        ToolbarColor = Color3.fromRGB(35, 35, 50),
        BackgroundColor = Color3.fromRGB(15, 15, 25),
        ButtonColor = Color3.fromRGB(27, 27, 41),
        AccentColor = Color3.fromRGB(223, 183, 232),
        TextBoxColor = Color3.fromRGB(20, 20, 30),
        FillerColor = Color3.fromRGB(30, 30, 45)
    },
    ["red"] = {
        TaskbarColor = Color3.fromRGB(81, 27, 41),
        ToolbarColor = Color3.fromRGB(100, 35, 50),
        BackgroundColor = Color3.fromRGB(45, 15, 25),
        ButtonColor = Color3.fromRGB(81, 27, 41),
        AccentColor = Color3.fromRGB(255, 150, 180),
        TextBoxColor = Color3.fromRGB(60, 20, 30),
        FillerColor = Color3.fromRGB(90, 30, 45)
    }
}

for Name, Color in Themes[Theme] do
    getfenv()[Name] = Color
end

Main = Instance.new("ScreenGui")
Main.Name = "InternalUI"
Main.Parent = game.CoreGui

----- ===== Tint ===== -----
BackgroundTint = Frame {
	Name = "Tint",
	Parent = Main,
	Size = UDim2.new(1, 0, 1.1, 0),
	Position = UDim2.new(0, 0, -0.05, 0),
	UIGradient {
		Transparency = NumberSequence.new({
		    NumberSequenceKeypoint.new(0.0, 0.5), 
		    NumberSequenceKeypoint.new(0.4, 0.9),
		    NumberSequenceKeypoint.new(0.6, 0.9),
		    NumberSequenceKeypoint.new(1.0, 0.5)
		}),
		Name = "Gradient",
		Color = ColorSequence.new(Color3.fromRGB(0, 0, 0)),
		Rotation = -90
	}
}

----- ===== Executor ===== -----
local function Window(Name, Position, Size, Contents)
	return Frame {
		Active = true,
		Parent = Main,
		Name = Name,
		BackgroundTransparency = 0,
		Size = Size,
		BorderColor3 = BackgroundColor,
		Visible = false,
		Position = Position,
		BackgroundColor3 = BackgroundColor,
		UICorner {},
		TextLabel {
			ZIndex = 4,
			BorderSizePixel = 0,
			BackgroundColor3 = AccentColor,
			FontFace = Font.new("rbxasset://fonts/families/Roboto.json"),
			Name = "Logo",
			TextSize = 30,
			Size = UDim2.new(0, 33, 0, 33),
			TextColor3 = BackgroundColor,
			Text = "V",
			Rotation = 180,
			Position = UDim2.new(0.005, 0, 0.0125, 0),
			UICorner {
				CornerRadius = UDim.new(0, 7)
			}
		},
		TextLabel {
			ZIndex = 3,
			BackgroundColor3 = TaskbarColor,
			FontFace = Font.new("rbxasset://fonts/families/JosefinSans.json"),
			Name = "Title",
			TextSize = 18,
			Size = UDim2.new(1, 0, 0.11, 0),
			TextColor3 = AccentColor,
			BorderColor3 = TaskbarColor,
			Text = Name .. "  ",
			TextXAlignment = Enum.TextXAlignment.Right,
			UICorner {}
		},
		Frame {
			Name = "Toolbar",
			ZIndex = 3,
			Size = UDim2.new(1, -4, 0.06, 0),
			BorderColor3 = ToolbarColor,
			Position = UDim2.new(0, 2, 0.11, 0),
			BackgroundColor3 = ToolbarColor
		},
		table.unpack(Contents)
	}
end

local Executor = Window("Executor", UDim2.new(0.0585, 0, 0.025, 0), UDim2.new(0.4, 0, 0.35, 0), {
	ScrollingFrame {
		Active = true,
		ZIndex = 3,
		CanvasSize = UDim2.new(5, 0, 250, 0),
		Name = "ExecutorScroll",
		Size = UDim2.new(0.8, 0, 0.672, 0),
		ScrollBarImageColor3 = AccentColor,
		ScrollBarThickness = 7,
		BorderColor3 = FillerColor,
		Position = UDim2.new(0.01, 0, 0.194, 0),
		BackgroundColor3 = FillerColor,
		Frame {
			Active = true,
			Name = "ExecutorBoxBack",
			Size = UDim2.new(0.4, 0, 0.45, 0),
			BorderColor3 = BackgroundColor,
			Position = UDim2.new(0.07, 0, 0, 0),
			BackgroundColor3 = BackgroundColor
		},
		TextBox {
			MultiLine = true,
			ZIndex = 3,
			Name = "ExecutorBox",
			ClearTextOnFocus = false,
			TextYAlignment = Enum.TextYAlignment.Top,
			BackgroundColor3 = TextBoxColor,
			FontFace = Font.new("rbxasset://fonts/families/SourceSansPro.json"),
			Size = UDim2.new(0.99, 0, 1, 0),
			Position = UDim2.new(0.011, 0, 0, 0),
			TextColor3 = AccentColor,
			BorderColor3 = TextBoxColor,
			Text = "print(\"Hello, world!\")",
			TextXAlignment = Enum.TextXAlignment.Left,
			TextSize = 23,
			Changed = function(ExecutorBox, Change)
				if Change == "Text" then
					local _, Count = ExecutorBox.Text:gsub("\n", "")
					
					local ExecutorLineNumbers = ExecutorBox.Parent.ExecutorLineNumbers
					
					ExecutorLineNumbers.Text = " 1"
					
					coroutine.resume(coroutine.create(function() 
						for i = 2, Count + 1 do
							ExecutorLineNumbers.Text = ExecutorLineNumbers.Text .. "\n " .. i
						end
					end))
				end
			end
		},
		TextLabel {
			ZIndex = 3,
			TextYAlignment = Enum.TextYAlignment.Top,
			BackgroundColor3 = FillerColor,
			FontFace = Font.new("rbxasset://fonts/families/SourceSansPro.json"),
			Name = "ExecutorLineNumbers",
			TextSize = 23,
			Size = UDim2.new(0.01, 0, 1, 0),
			TextColor3 = AccentColor,
			BorderColor3 = FillerColor,
			Text = " 1",
			TextXAlignment = Enum.TextXAlignment.Left
		}
	},
	ScrollingFrame {
		Active = true,
		ZIndex = 3,
		CanvasSize = UDim2.new(5, 0, 5, 0),
		Name = "ExecutorFileScroll",
		Size = UDim2.new(0.16, 0, 0.672, 0),
		ScrollBarImageColor3 = AccentColor,
		ScrollBarThickness = 7,
		BorderColor3 = FillerColor,
		Position = UDim2.new(0.825, 0, 0.194, 0),
		BackgroundColor3 = FillerColor
	},
	TextButton {
		ZIndex = 3,
		BackgroundColor3 = ButtonColor,
		FontFace = Font.new("rbxasset://fonts/families/SourceSansPro.json"),
		Name = "ExecutorBtn",
		TextSize = 22,
		Size = UDim2.new(0, 111, 0, 32),
		TextColor3 = AccentColor,
		BorderColor3 = ButtonColor,
		Text = "Execute",
		Position = UDim2.new(0.007, 0, 0.885, 0),
		MouseButton1Down = function(ExecutorBtn)
			local result, err = loadstring(ExecutorBtn.Parent.ExecutorScroll.ExecutorBox.Text)
	
			if type(result) ~= "function" then
				print(err)
			else
				result()
			end
		end,
		UICorner {
			CornerRadius = UDim.new(0, 5)
		}
	},
	TextButton {
		ZIndex = 3,
		BackgroundColor3 = ButtonColor,
		FontFace = Font.new("rbxasset://fonts/families/SourceSansPro.json"),
		Name = "ExecutorClearBtn",
		TextSize = 22,
		Size = UDim2.new(0, 111, 0, 32),
		TextColor3 = AccentColor,
		BorderColor3 = ButtonColor,
		Text = "Clear",
		Position = UDim2.new(0.165, 0, 0.885, 0),
		MouseButton1Down = function(Clear)
			Clear.Parent.ExecutorScroll.ExecutorBox.Text = ""
		end,
		UICorner {
			CornerRadius = UDim.new(0, 5)
		}
	},
	TextButton {
		ZIndex = 3,
		BackgroundColor3 = ButtonColor,
		FontFace = Font.new("rbxasset://fonts/families/SourceSansPro.json"),
		Name = "ExecutorOpenFileBtn",
		TextSize = 22,
		Size = UDim2.new(0, 111, 0, 32),
		TextColor3 = AccentColor,
		BorderColor3 = ButtonColor,
		Text = "Open file",
		Position = UDim2.new(0.322, 0, 0.885, 0),
		UICorner {
			CornerRadius = UDim.new(0, 5)
		}
	},
	TextButton {
		ZIndex = 3,
		BackgroundColor3 = ButtonColor,
		FontFace = Font.new("rbxasset://fonts/families/SourceSansPro.json"),
		Name = "ExecutorSaveFileBtn",
		TextSize = 22,
		Size = UDim2.new(0, 111, 0, 32),
		TextColor3 = AccentColor,
		BorderColor3 = ButtonColor,
		Text = "Save file",
		Position = UDim2.new(0.48, 0, 0.885, 0),
		UICorner {
			CornerRadius = UDim.new(0, 5)
		}
	},
	TextBox {
		ZIndex = 3,
		Name = "ExitBtn",
		BackgroundColor3 = BackgroundColor,
		FontFace = Font.new("rbxasset://fonts/families/SourceSansPro.json"),
		Size = UDim2.new(0, 111, 0, 32),
		Position = UDim2.new(0.637, 0, 0.885, 0),
		PlaceholderText = "File Name",
		TextColor3 = AccentColor,
		BorderColor3 = BackgroundColor,
		Text = "",
		TextSize = 18,
		UICorner {
			CornerRadius = UDim.new(0, 5)
		}
	},
	TextButton {
		ZIndex = 3,
		BackgroundColor3 = ButtonColor,
		FontFace = Font.new("rbxasset://fonts/families/SourceSansPro.json"),
		Name = "ExecutorOptionsBtn",
		TextSize = 22,
		Size = UDim2.new(0, 111, 0, 32),
		TextColor3 = AccentColor,
		BorderColor3 = ButtonColor,
		Text = "Options",
		Position = UDim2.new(0.84, 0, 0.885, 0),
		UICorner {
			CornerRadius = UDim.new(0, 5)
		}
	}
})

----- ===== Console ===== -----

local Console = Window("Console", UDim2.new(0.468, 0, 0.025, 0), UDim2.new(0.3, 0, 0.35, 0), {
	ScrollingFrame {
		Active = true,
		ZIndex = 3,
		CanvasSize = UDim2.new(5, 0, 250, 0),
		Name = "ConsoleScroll",
		Size = UDim2.new(0.975, 0, 0.672, 0),
		ScrollBarImageColor3 = AccentColor,
		ScrollBarThickness = 7,
		BorderColor3 = FillerColor,
		Position = UDim2.new(0.01, 0, 0.194, 0),
		BackgroundColor3 = FillerColor,
		TextLabel {
			ZIndex = 3,
			TextYAlignment = Enum.TextYAlignment.Top,
			BackgroundColor3 = TextBoxColor,
			FontFace = Font.new("rbxasset://fonts/families/SourceSansPro.json"),
			Name = "ConsoleLogs",
			TextSize = 23,
			Size = UDim2.new(0.99, 0, 1, 0),
			TextColor3 = AccentColor,
			BorderColor3 = TextBoxColor,
			Text = "",
			TextXAlignment = Enum.TextXAlignment.Left
		}
	},
	TextBox {
		ZIndex = 3,
		Name = "ConsoleBox",
		ClearTextOnFocus = false,
		BackgroundColor3 = TextBoxColor,
		FontFace = Font.new("rbxasset://fonts/families/SourceSansPro.json"),
		Size = UDim2.new(0.76, 0, 0, 32),
		Position = UDim2.new(0.015, 0, 0.885, 0),
		TextColor3 = AccentColor,
		BorderColor3 = TextBoxColor,
		Text = "",
		TextXAlignment = Enum.TextXAlignment.Left,
		TextSize = 23,
		FocusLost = function(ConsoleBox, pressed) 
			if pressed then
				local result = loadstring(ConsoleBox.Text)
				if type(result) ~= "function" then
					print(loadstring(ConsoleBox.Text))
					
		            ConsoleBox.Text = ""
				else
					result()
					
		            ConsoleBox.Text = ""
				end
			end
		end,
		UICorner {
			CornerRadius = UDim.new(0, 5)
		}
	},
	TextButton {
		ZIndex = 3,
		BackgroundColor3 = ButtonColor,
		FontFace = Font.new("rbxasset://fonts/families/SourceSansPro.json"),
		Name = "ConsoleClearBtn",
		TextSize = 22,
		Size = UDim2.new(0, 111, 0, 32),
		TextColor3 = AccentColor,
		BorderColor3 = ButtonColor,
		Text = "Clear",
		Position = UDim2.new(0.785, 0, 0.885, 0),
		MouseButton1Down = function(Clear)
			Clear.Parent.ConsoleScroll.ConsoleLogs.Text = ""
		end,
		UICorner {
			CornerRadius = UDim.new(0, 5)
		}
	}
})

game:GetService("LogService").MessageOut:Connect(function(msg, messageType) 
	local function numberWithZero(num) 
		return (num < 10 and "0" or "") .. num
	end
	
	local localTime = os.time() - os.time() + math.floor(tick())
	local dayTime = localTime % 86400
	local hour = math.floor(dayTime/3600)
	
	dayTime = dayTime - (hour * 3600)
	local minute = math.floor(dayTime/60)
	
	dayTime = dayTime - (minute * 60)
	local second = dayTime
	
	local h = numberWithZero(hour)
	local m = numberWithZero(minute)
	local s = numberWithZero(dayTime)
	
	Console.ConsoleScroll.ConsoleLogs.Text = Console.ConsoleScroll.ConsoleLogs.Text .. string.format("[%s:%s:%s] %s\n", h, m, s, msg)
end)

----- ===== Terminal ===== -----

local Terminal = Window("Terminal", UDim2.new(0.0585, 0, 0.392, 0), UDim2.new(0.35, 0, 0.425, 0), {
	ScrollingFrame {
		Active = true,
		ZIndex = 3,
		CanvasSize = UDim2.new(5, 0, 250, 0),
		Name = "TerminalScroll",
		Size = UDim2.new(0.982, 0, 0.82, 0),
		ScrollBarImageColor3 = AccentColor,
		ScrollBarThickness = 7,
		BorderColor3 = FillerColor,
		Position = UDim2.new(0.01, 0, 0.16, 0),
		BackgroundColor3 = TextBoxColor,
		UIListLayout {
			Name = "UIList",
			SortOrder = Enum.SortOrder.LayoutOrder
		}
	}
})

----- ===== TaskBar ===== -----

TaskBar = Frame {
	Active = true,
	Name = "TaskBar",
	ZIndex = 2,
	Size = UDim2.new(0.91, 0, 0.04, 0),
	BorderColor3 = BackgroundColor,
	Visible = false,
	Position = UDim2.new(0.0585, 0, -0.03, 0),
	BackgroundColor3 = BackgroundColor,
	Parent = Main,
	UICorner {
		CornerRadius = UDim.new(0, 7)
	},
	TextButton {
		ZIndex = 3,
		BorderSizePixel = 0,
		BackgroundColor3 = BackgroundColor,
		FontFace = Font.new("rbxasset://fonts/families/Roboto.json"),
		Name = "TaskBarLogo",
		TextSize = 35,
		Size = UDim2.new(0.025, 0, 1, 0),
		TextColor3 = AccentColor,
		Text = "V",
		Rotation = 180,
		UICorner {
			CornerRadius = UDim.new(0, 7)
		}
	},
	TextLabel {
		ZIndex = 3,
		BorderSizePixel = 0,
		BackgroundColor3 = TextBoxColor,
		FontFace = Font.new("rbxasset://fonts/families/SourceSansPro.json"),
		Name = "TaskBarLine",
		TextSize = 35,
		Size = UDim2.new(0.001, 0, 1, 0),
		TextColor3 = AccentColor,
		BorderColor3 = TextBoxColor,
		Text = " |",
		BackgroundTransparency = 1,
		TextXAlignment = Enum.TextXAlignment.Left,
		Position = UDim2.new(0.025, 0, -0.003, 0)
	},
	TextLabel {
		ZIndex = 4,
		BorderSizePixel = 0,
		BackgroundColor3 = AccentColor,
		FontFace = Font.new("rbxasset://fonts/families/Roboto.json"),
		Name = "ExecutorLogo",
		TextSize = 20,
		Size = UDim2.new(0.015, 0, 0.65, 0),
		TextColor3 = BackgroundColor,
		Text = "E",
		Position = UDim2.new(0.0371, 0, 0.225, 0),
		UICorner {
			CornerRadius = UDim.new(0, 5)
		}
	},
	TextButton {
		ZIndex = 3,
		BorderSizePixel = 0,
		BackgroundColor3 = TextBoxColor,
		FontFace = Font.new("rbxasset://fonts/families/SourceSansPro.json"),
		Name = "TaskBarExecutor",
		TextSize = 25,
		Size = UDim2.new(0.125, 0, 0.9, 0),
		TextColor3 = AccentColor,
		BorderColor3 = TextBoxColor,
		Text = "         Executor",
		Position = UDim2.new(0.035, 0, 0.1, 0),
		TextXAlignment = Enum.TextXAlignment.Left,
		MouseButton1Down = function() 
			Executor.Visible = not Executor.Visible
			TaskBarExecutor.BackgroundColor3 = Executor.Visible and TextBoxColor or BackgroundColor
		end
	},
	Frame {
		Name = "TaskBarExecutorLine",
		ZIndex = 4,
		Size = UDim2.new(0.125, 0, 0.1, 0),
		BorderColor3 = AccentColor,
		Position = UDim2.new(0.035, 0, 0, 0),
		BorderSizePixel = 0,
		BackgroundColor3 = AccentColor
	},
	TextLabel {
		ZIndex = 4,
		BorderSizePixel = 0,
		BackgroundColor3 = AccentColor,
		FontFace = Font.new("rbxasset://fonts/families/Roboto.json"),
		Name = "ConsoleLogo",
		TextSize = 20,
		Size = UDim2.new(0.015, 0, 0.65, 0),
		TextColor3 = BackgroundColor,
		Text = "C",
		Position = UDim2.new(0.167, 0, 0.225, 0),
		UICorner {
			CornerRadius = UDim.new(0, 5)
		}
	},
	TextButton {
		ZIndex = 3,
		BorderSizePixel = 0,
		BackgroundColor3 = TextBoxColor,
		FontFace = Font.new("rbxasset://fonts/families/SourceSansPro.json"),
		Name = "TaskBarConsole",
		TextSize = 25,
		Size = UDim2.new(0.125, 0, 0.9, 0),
		TextColor3 = AccentColor,
		BorderColor3 = TextBoxColor,
		Text = "         Console",
		Position = UDim2.new(0.164, 0, 0.1, 0),
		TextXAlignment = Enum.TextXAlignment.Left,
		MouseButton1Down = function() 
			Console.Visible = not Console.Visible
			TaskBarExecutor.BackgroundColor3 = Console.Visible and TextBoxColor or BackgroundColor
		end
	},
	Frame {
		Name = "TaskBarConsoleLine",
		ZIndex = 4,
		Size = UDim2.new(0.125, 0, 0.1, 0),
		BorderColor3 = AccentColor,
		Position = UDim2.new(0.164, 0, 0, 0),
		BorderSizePixel = 0,
		BackgroundColor3 = AccentColor
	},
	TextLabel {
		ZIndex = 4,
		BorderSizePixel = 0,
		BackgroundColor3 = AccentColor,
		FontFace = Font.new("rbxasset://fonts/families/Roboto.json"),
		Name = "TerminalLogo",
		TextSize = 20,
		Size = UDim2.new(0.015, 0, 0.65, 0),
		TextColor3 = BackgroundColor,
		Text = "T",
		Position = UDim2.new(0.296, 0, 0.225, 0),
		UICorner {
			CornerRadius = UDim.new(0, 5)
		}
	},
	TextButton {
		ZIndex = 3,
		BorderSizePixel = 0,
		BackgroundColor3 = TextBoxColor,
		FontFace = Font.new("rbxasset://fonts/families/SourceSansPro.json"),
		Name = "TaskBarTerminal",
		TextSize = 25,
		Size = UDim2.new(0.125, 0, 0.9, 0),
		TextColor3 = AccentColor,
		BorderColor3 = TextBoxColor,
		Text = "         Terminal",
		Position = UDim2.new(0.293, 0, 0.1, 0),
		TextXAlignment = Enum.TextXAlignment.Left,
		MouseButton1Down = function() 
			Terminal.Visible = not Terminal.Visible
			TaskBarExecutor.BackgroundColor3 = Terminal.Visible and TextBoxColor or BackgroundColor
		end
	},
	Frame {
		Name = "TaskBarTerminalLine",
		ZIndex = 4,
		Size = UDim2.new(0.125, 0, 0.1, 0),
		BorderColor3 = AccentColor,
		Position = UDim2.new(0.293, 0, 0, 0),
		BorderSizePixel = 0,
		BackgroundColor3 = AccentColor
	},
	TextLabel {
		ZIndex = 3,
		BorderSizePixel = 0,
		BackgroundColor3 = TextBoxColor,
		FontFace = Font.new("rbxasset://fonts/families/SourceSansPro.json"),
		Name = "TaskBarTime",
		TextSize = 28,
		Size = UDim2.new(0.04, 0, 1, 0),
		TextColor3 = AccentColor,
		BorderColor3 = TextBoxColor,
		Text = "00:00 ",
		TextXAlignment = Enum.TextXAlignment.Right,
		Position = UDim2.new(0.96, 0, 0, 0),
		UICorner {
			CornerRadius = UDim.new(0, 7)
		}
	},
	TextLabel {
		ZIndex = 3,
		BorderSizePixel = 0,
		BackgroundColor3 = AccentColor,
		FontFace = Font.new("rbxasset://fonts/families/SourceSansPro.json"),
		Name = "TaskBarFPS",
		TextSize = 28,
		Size = UDim2.new(0.02, 0, 1, 0),
		TextColor3 = BackgroundColor,
		BorderColor3 = TextBoxColor,
		Text = "",
		Position = UDim2.new(0.944, 0, 0, 0)
	}
}

coroutine.resume(coroutine.create(function() 
	pcall(function()
		while wait() do
			local function numberWithZero(num) 
				return (num < 10 and "0" or "") .. num
			end
			
			local localTime = os.time() - os.time() + math.floor(tick())
			local dayTime = localTime % 86400
			local hour = math.floor(dayTime/3600)
			
			dayTime = dayTime - (hour * 3600)
			local minute = math.floor(dayTime/60)
			
			dayTime = dayTime - (minute * 60)
			local second = dayTime
			
			local h = numberWithZero(hour)
			local m = numberWithZero(minute)
			local s = numberWithZero(dayTime)
			
			TaskBar.TaskBarTime.Text = "  " .. h .. ":" .. m .. " "
		end
	end)
end))

local Clock = RunService:IsRunning() and time or os.clock

local Previous, Start
local Update = {}

Start = Clock()

RunService.Heartbeat:Connect(function(fps)
	pcall(function()
		 Previous = Clock()
    
		for Index = #Update, 1, -1 do
			Update[Index + 1] = Update[Index] >= Previous - 1 and Update[Index] or nil
		end
	
		Update[1] = Previous
		
		TaskBar.TaskBarFPS.Text = math.floor((Clock() - Start >= 1 and #Update or #Update / (Clock() - Start)))
	end)
end)

----- ===== CoreGui ===== -----

local Loading = ScreenGui {
	ResetOnSpawn = false,
	IgnoreGuiInset = true,
	ScreenInsets = Enum.ScreenInsets.DeviceSafeInsets,
	Name = "Loading",
	DisplayOrder = 2147483647,
	Frame {
		Name = "Tint",
		Size = UDim2.new(1, 0, 1.1, 0),
		Position = UDim2.new(0, 0, -0.05, 0),
		UIGradient {
			Transparency = NumberSequence.new({
			    NumberSequenceKeypoint.new(0.0, 0.5), 
			    NumberSequenceKeypoint.new(0.4, 0.9),
			    NumberSequenceKeypoint.new(0.6, 0.9),
			    NumberSequenceKeypoint.new(1.0, 0.5)
			}),
			Name = "Gradient",
			Color = ColorSequence.new(Color3.fromRGB(0, 0, 0)),
			Rotation = -90
		}
	},
	TextLabel {
		ZIndex = 3,
		BorderSizePixel = 0,
		BackgroundColor3 = BackgroundColor,
		FontFace = Font.new("rbxasset://fonts/families/SourceSansPro.json"),
		Name = "BackgroundDescText_Load",
		TextSize = 40,
		Size = UDim2.new(0.1, 0, 0, 50),
		TextColor3 = AccentColor,
		BorderColor3 = BackgroundColor,
		Text = "We're teleporting to",
		BackgroundTransparency = 1,
		TextXAlignment = Enum.TextXAlignment.Left,
		Position = UDim2.new(0.01, 0, 0.893, 0)
	},
	TextLabel {
		ZIndex = 3,
		BorderSizePixel = 0,
		BackgroundColor3 = BackgroundColor,
		FontFace = Font.new("rbxasset://fonts/families/SourceSansPro.json"),
		Name = "BackgroundMapText_Load",
		TextSize = 75,
		Size = UDim2.new(0.1, 0, 0, 50),
		TextColor3 = AccentColor,
		BorderColor3 = BackgroundColor,
		Text = "Another Roblox Experience",
		BackgroundTransparency = 1,
		TextXAlignment = Enum.TextXAlignment.Left,
		Position = UDim2.new(0.01, 0, 0.935, 0)
	}
}

ReplicatedFirst:RemoveDefaultLoadingScreen()
TeleportService:SetTeleportGui(Loading)

----- ===== APIs ===== -----

terminal = {
	print = function(Text)
		Text = Text or ""
		
		return TextLabel {
			Name = "Response",
			Parent = terminal.TerminalScroll,
			ZIndex = 3,
			TextXAlignment = "Left",
			TextYAlignment = "Top",
			BackgroundColor3 = TextBoxColor,
			BorderColor3 = TextBoxColor,
			Size = UDim2.new(1, 0, 0, #Text:split("\n") * 23),
			Font = Enum.Font.SourceSansLight,
			Text = Text,
			TextSize = 23,
			TextColor3 = AccentColor,
			TextXAlignment = "Left"
		}
	end,
	Run = function(terminal, command)
		terminal.Command.Original, terminal.Command.Splited, terminal.Command.Fixed = command, command:split(" "), {}
		
		for i, v in pairs(terminal.Command.Splited) do
			if v ~= nil and v ~= "" then table.insert(terminal.Command.Fixed, v) end
		end
		
		if terminal.Command.Fixed[1] == nil then return end
		
		table.insert(terminal.History.Command, 1, command); terminal.History.Count = 0
		
		if not isfile(Directory .. terminal.Command.Fixed[1] .. ".lua") then
			terminal.print("bash: unknown command `" .. tostring(terminal.Command.Fixed[1]) .. "`")
			terminal.print()
			return
		end
		
		local res, err = pcall(function()
			local res, err = loadstring(readfile(Directory .. terminal.Command.Fixed[1] .. ".lua"))
			
			if not res then
				terminal.print("syntax error at `" .. Directory .. terminal.Command.Fixed[1] .. ".lua" .. "`: " .. err) 
			else 
				res() 
			end
		end) 
		
		if not res then 
			terminal.print("runtime error at `" .. Directory .. terminal.Command.Fixed[1] .. ".lua" .. "`: " .. err) 
		end
	end,
	Refresh = function(terminal)
		terminal.TerminalBoxFrame = Frame {
			Parent = terminal.TerminalScroll,
			BackgroundColor3 = TextBoxColor,
			BorderColor3 = TextBoxColor,
			Size = UDim2.new(0.99, 0, 1, 0)
		}
		
		terminal.TerminalInputUIList = UIListLayout {
			Parent = terminal.TerminalBoxFrame,
			FillDirection = "Horizontal",
			VerticalAlignment = "Top",
			HorizontalAlignment = "Left",
			Padding = UDim.new(0, 0),
			SortOrder = "LayoutOrder"
		}

		local Prefix = Player.DisplayName .. "@" .. Directory .. "# "
		
		terminal.TerminalPrefix = TextLabel {
			Name = "TerminalPrefix",
			Parent = terminal.TerminalBoxFrame,
			ZIndex = 3,
			TextXAlignment = "Left",
			TextYAlignment = "Top",
			BackgroundColor3 = TextBoxColor,
			BorderColor3 = TextBoxColor,
			Font = Enum.Font.Code,
			Text = Prefix,
			Size = UDim2.new(0, #Prefix * 9, 0, 23),
			TextColor3 = AccentColor,
			TextSize = 18,
			TextXAlignment = "Left"
		}

	    terminal.TerminalBox = TextBox {
	    	Parent = terminal.TerminalBoxFrame,
			ZIndex = 3,
			MultiLine = false,
			ClearTextOnFocus = false,
			TextXAlignment = "Left",
			TextYAlignment = "Top",
			BackgroundColor3 = TextBoxColor,
			BorderColor3 = TextBoxColor,
			Size = UDim2.new(0.99, 0, 1, 0),
			Font = Enum.Font.Code,
			Text = '',
			TextColor3 = AccentColor,
			TextSize = 18,
			FocusLost = function(TerminalBox, Pressed)
				if Pressed then
					local TerminalLogs = TextLabel {
						Name = "TerminalLogs",
						Parent = terminal.TerminalScroll,
						ZIndex = 3,
						TextXAlignment = "Left",
						TextYAlignment = "Top",
						BackgroundColor3 = TextBoxColor,
						BorderColor3 = TextBoxColor,
						Size = UDim2.new(1, 0, 0, #TerminalBox.Text:split("\n") * 23),
						Font = Enum.Font.Code,
						Text = terminal.TerminalPrefix.Text .. TerminalBox.Text,
						TextColor3 = AccentColor,
						TextSize = 18,
						TextXAlignment = "Left",
					}

					terminal.TerminalWorking = true
					terminal:Run(TerminalBox.Text)
					terminal.TerminalWorking = false
				end
			end
		}
	end
}

terminal.TerminalTitle = Terminal.Title
terminal.TerminalScroll = Terminal.TerminalScroll
terminal.TerminalUIList = Terminal.TerminalScroll.UIList

terminal.TerminalUpdating = false
terminal.TerminalWorking = false
terminal.TerminalInterrupt = false

terminal.Command = {Original = "", Splited = {}, Fixed = {}}
terminal.History = {Command = {}, Count = 0}

terminal.print()
terminal:Refresh()

terminal.TerminalScroll.ChildAdded:Connect(function() 
	if terminal.TerminalUpdating then return end
    terminal.TerminalUpdating = true
	wait()
	
    if terminal.TerminalBoxFrame then terminal.TerminalBoxFrame:Destroy() end
    
    terminal.TerminalScroll.CanvasSize = UDim2.new(0, terminal.TerminalUIList.AbsoluteContentSize.X + 25, 0, terminal.TerminalUIList.AbsoluteContentSize.Y + 23)
	terminal.TerminalScroll.CanvasPosition = Vector2.new(0, terminal.TerminalUIList.AbsoluteContentSize.Y + 23)
	
	repeat task.wait() until not terminal.TerminalWorking
	
	terminal.TerminalScroll.CanvasSize = UDim2.new(0, terminal.TerminalUIList.AbsoluteContentSize.X + 25, 0, terminal.TerminalUIList.AbsoluteContentSize.Y + 23)
	terminal.TerminalScroll.CanvasPosition = Vector2.new(0, terminal.TerminalUIList.AbsoluteContentSize.Y + 23)
	
	terminal:Refresh()
	terminal.TerminalBox:CaptureFocus()

    terminal.TerminalUpdating = false
end)

terminal.TerminalScroll.ChildRemoved:Connect(function() 
	if terminal.TerminalUpdating then return end
	
    terminal.TerminalUpdating = true
    
	wait()
	
    if terminal.TerminalBoxFrame then terminal.TerminalBoxFrame:Destroy() end
    
    terminal.TerminalScroll.CanvasSize = UDim2.new(0, terminal.TerminalUIList.AbsoluteContentSize.X + 25, 0, terminal.TerminalUIList.AbsoluteContentSize.Y + 23)
	terminal.TerminalScroll.CanvasPosition = Vector2.new(0, terminal.TerminalUIList.AbsoluteContentSize.Y + 23)
	
	if not terminal.TerminalWorking then 
		terminal:Refresh()
		terminal.TerminalBox:CaptureFocus()
	end
	
    terminal.TerminalUpdating = false
end)

----- ===== Initialize ===== -----

TaskBar.Visible = true
Executor.Visible = true
Console.Visible = true
Terminal.Visible = true

local TweenInfo = TweenInfo.new(1, Enum.EasingStyle.Quint, Enum.EasingDirection.Out, 0, false, 0)
	
local Tween = TweenService:Create(TaskBar, TweenInfo, {
	Transparency = 0,
})

TaskBar.Transparency = 1
Tween:Play()

for _, Window in pairs({Executor, Console, Terminal}) do
	local Tween = TweenService:Create(Window, TweenInfo, {
		Transparency = 0,
		Position = Window.Position
	})
	
	Window.Position = UDim2.new(Window.Position.X.Scale, 0, Window.Position.Y.Scale - 0.02, 0)
	Window.Transparency = 1
	
	Tween:Play()
end

----- ===== Events ===== -----
local ToggleUI = false

InputService.InputBegan:Connect(function(input, processed) 
	if input.KeyCode == Enum.KeyCode.Up and InputService:GetFocusedTextBox() == terminal.TerminalBox then
		terminal.History.Count = terminal.History.Count + 1
		if terminal.History.Count > #terminal.History.Command then terminal.History.Count = #terminal.History.Command end
		terminal.TerminalBox.Text = terminal.History.Command[terminal.History.Count] or ""
		terminal.TerminalBox.CursorPosition = 1020
	elseif input.KeyCode == Enum.KeyCode.Down and InputService:GetFocusedTextBox() == terminal.TerminalBox then
		terminal.History.Count = terminal.History.Count - 1
		if terminal.History.Count < 0 then terminal.History.Count = 0 end
		terminal.TerminalBox.Text = terminal.History.Command[terminal.History.Count] or ""
		terminal.TerminalBox.CursorPosition = 1020
	elseif input.KeyCode == Enum.KeyCode.Equals then
		ToggleUI = not ToggleUI
		
		BackgroundTint.Visible = ToggleUI
		TaskBar.Visible = ToggleUI
		Executor.Visible = ToggleUI
		Console.Visible = ToggleUI
		Terminal.Visible = ToggleUI
	end
end)
