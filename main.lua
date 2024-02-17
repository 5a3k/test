-- Gui to Lua
-- Version: 3.2

-- Instances:

local BankingSystem = Instance.new("ScreenGui")
local BACKGROUNDUI = Instance.new("Frame")
local Ui = Instance.new("Frame")
local Ui_2 = Instance.new("Frame")
local Ui_3 = Instance.new("Frame")
local Ui_4 = Instance.new("Frame")
local Ui_5 = Instance.new("Frame")
local InformationFrame = Instance.new("Frame")
local PlayerImage = Instance.new("ImageLabel")
local UICorner = Instance.new("UICorner")
local UIAspectRatioConstraint = Instance.new("UIAspectRatioConstraint")
local welcome = Instance.new("TextLabel")
local UITextSizeConstraint = Instance.new("UITextSizeConstraint")
local UIAspectRatioConstraint_2 = Instance.new("UIAspectRatioConstraint")
local BACKGROUNDUI_2 = Instance.new("Frame")
local UIAspectRatioConstraint_3 = Instance.new("UIAspectRatioConstraint")
local PlayerName = Instance.new("TextLabel")
local UITextSizeConstraint_2 = Instance.new("UITextSizeConstraint")
local UIAspectRatioConstraint_4 = Instance.new("UIAspectRatioConstraint")
local TransactionFrame = Instance.new("Frame")
local TextLabel = Instance.new("TextLabel")
local UITextSizeConstraint_3 = Instance.new("UITextSizeConstraint")
local UIAspectRatioConstraint_5 = Instance.new("UIAspectRatioConstraint")
local textbox = Instance.new("TextBox")
local UICorner_2 = Instance.new("UICorner")
local UITextSizeConstraint_4 = Instance.new("UITextSizeConstraint")
local toggle = Instance.new("TextButton")
local UICorner_3 = Instance.new("UICorner")
local UITextSizeConstraint_5 = Instance.new("UITextSizeConstraint")
local UIAspectRatioConstraint_6 = Instance.new("UIAspectRatioConstraint")
local BACKGROUNDUI_3 = Instance.new("Frame")
local TextLabel_2 = Instance.new("TextLabel")
local UITextSizeConstraint_6 = Instance.new("UITextSizeConstraint")
local TextLabel_3 = Instance.new("TextLabel")
local UITextSizeConstraint_7 = Instance.new("UITextSizeConstraint")
local TextLabel_4 = Instance.new("TextLabel")
local UITextSizeConstraint_8 = Instance.new("UITextSizeConstraint")
local Deposit = Instance.new("TextButton")
local UITextSizeConstraint_9 = Instance.new("UITextSizeConstraint")
local DepositFrame = Instance.new("Frame")
local Information = Instance.new("TextLabel")
local Ui_6 = Instance.new("Frame")
local UIAspectRatioConstraint_7 = Instance.new("UIAspectRatioConstraint")
local TextLabel_5 = Instance.new("TextLabel")
local EXIT = Instance.new("TextButton")
local UITextSizeConstraint_10 = Instance.new("UITextSizeConstraint")
local WithdrawFrame = Instance.new("Frame")
local Information_2 = Instance.new("TextLabel")
local Ui_7 = Instance.new("Frame")
local UIAspectRatioConstraint_8 = Instance.new("UIAspectRatioConstraint")
local TextLabel_6 = Instance.new("TextLabel")
local TextLabel_7 = Instance.new("TextLabel")
local Information_3 = Instance.new("TextButton")
local UITextSizeConstraint_11 = Instance.new("UITextSizeConstraint")
local Transactions = Instance.new("TextButton")
local UITextSizeConstraint_12 = Instance.new("UITextSizeConstraint")
local Withdraw = Instance.new("TextButton")
local UITextSizeConstraint_13 = Instance.new("UITextSizeConstraint")
local ACTIONS = Instance.new("TextLabel")
local UITextSizeConstraint_14 = Instance.new("UITextSizeConstraint")
local InformationIcon = Instance.new("TextLabel")
local UITextSizeConstraint_15 = Instance.new("UITextSizeConstraint")
local fluency_icon = Instance.new("ImageLabel")
local DepositIcon = Instance.new("TextLabel")
local UITextSizeConstraint_16 = Instance.new("UITextSizeConstraint")
local fluency_icon_2 = Instance.new("ImageLabel")
local NAME = Instance.new("TextLabel")
local UITextSizeConstraint_17 = Instance.new("UITextSizeConstraint")
local NAME_2 = Instance.new("TextLabel")
local UITextSizeConstraint_18 = Instance.new("UITextSizeConstraint")
local TransactionIcon = Instance.new("TextLabel")
local UITextSizeConstraint_19 = Instance.new("UITextSizeConstraint")
local fluency_icon_3 = Instance.new("ImageLabel")
local WithdrawIcon = Instance.new("TextLabel")
local UITextSizeConstraint_20 = Instance.new("UITextSizeConstraint")
local fluency_icon_4 = Instance.new("ImageLabel")
local Ui_8 = Instance.new("Frame")
local BACKGROUNDUI_4 = Instance.new("Frame")
local resetpopup = Instance.new("Frame")
local TextLabel_8 = Instance.new("TextLabel")
local UITextSizeConstraint_21 = Instance.new("UITextSizeConstraint")

--Properties:

BankingSystem.Name = "Banking System"
BankingSystem.Parent = game.Players.LocalPlayer:WaitForChild("PlayerGui")
BankingSystem.ZIndexBehavior = Enum.ZIndexBehavior.Sibling
BankingSystem.DisplayOrder = 999
BankingSystem.ResetOnSpawn = false

BACKGROUNDUI.Name = "BACKGROUNDUI"
BACKGROUNDUI.Parent = BankingSystem
BACKGROUNDUI.Active = true
BACKGROUNDUI.BackgroundColor3 = Color3.fromRGB(24, 24, 24)
BACKGROUNDUI.BorderColor3 = Color3.fromRGB(27, 42, 53)
BACKGROUNDUI.BorderSizePixel = 0
BACKGROUNDUI.Position = UDim2.new(0.296433002, 0, 0.244798049, 0)
BACKGROUNDUI.Size = UDim2.new(0.406150073, 0, 0.509057462, 0)

Ui.Name = "Ui"
Ui.Parent = BACKGROUNDUI
Ui.Active = true
Ui.BackgroundColor3 = Color3.fromRGB(29, 29, 29)
Ui.BorderColor3 = Color3.fromRGB(27, 42, 53)
Ui.BorderSizePixel = 0
Ui.Position = UDim2.new(-0.00302842679, 0, 0, 0)
Ui.Size = UDim2.new(0.214423478, 0, 1.00000012, 0)

Ui_2.Name = "Ui"
Ui_2.Parent = BACKGROUNDUI
Ui_2.Active = true
Ui_2.BackgroundColor3 = Color3.fromRGB(61, 61, 61)
Ui_2.BorderColor3 = Color3.fromRGB(71, 71, 71)
Ui_2.BorderSizePixel = 0
Ui_2.Position = UDim2.new(0.226654157, 0, 0.137052253, 0)
Ui_2.Size = UDim2.new(0.760626376, 0, -0.00200000009, 0)

Ui_3.Name = "Ui"
Ui_3.Parent = BACKGROUNDUI
Ui_3.Active = true
Ui_3.BackgroundColor3 = Color3.fromRGB(61, 61, 61)
Ui_3.BorderColor3 = Color3.fromRGB(71, 71, 71)
Ui_3.BorderSizePixel = 0
Ui_3.Position = UDim2.new(0.00977435801, 0, 0.290935397, 0)
Ui_3.Size = UDim2.new(0.108433455, 0, 0.00456846552, 0)

Ui_4.Name = "Ui"
Ui_4.Parent = BACKGROUNDUI
Ui_4.Active = true
Ui_4.BackgroundColor3 = Color3.fromRGB(61, 61, 61)
Ui_4.BorderColor3 = Color3.fromRGB(61, 61, 61)
Ui_4.Position = UDim2.new(0.214423314, 0, 0.0216398574, 0)
Ui_4.Size = UDim2.new(0, 0, 0.956720412, 0)

Ui_5.Name = "Ui"
Ui_5.Parent = BACKGROUNDUI
Ui_5.Active = true
Ui_5.BackgroundColor3 = Color3.fromRGB(61, 61, 61)
Ui_5.BorderColor3 = Color3.fromRGB(71, 71, 71)
Ui_5.BorderSizePixel = 0
Ui_5.Position = UDim2.new(0.00909192488, 0, 0.244392455, 0)
Ui_5.Size = UDim2.new(0.197826013, 0, 0.00574890152, 0)

InformationFrame.Name = "InformationFrame"
InformationFrame.Parent = BACKGROUNDUI
InformationFrame.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
InformationFrame.BackgroundTransparency = 1.000
InformationFrame.BorderSizePixel = 0
InformationFrame.Position = UDim2.new(0.226147771, 0, 0.157547057, 0)
InformationFrame.Size = UDim2.new(0.79948014, 0, 0.839430392, 0)

PlayerImage.Name = "PlayerImage"
PlayerImage.Parent = InformationFrame
PlayerImage.BackgroundColor3 = Color3.fromRGB(24, 24, 24)
PlayerImage.BackgroundTransparency = 1.000
PlayerImage.Position = UDim2.new(-0.00198807009, 0, 0, 0)
PlayerImage.Size = UDim2.new(0.19880715, 0, 0.291545182, 0)
PlayerImage.Image = "rbxasset://textures/ui/GuiImagePlaceholder.png"

UICorner.CornerRadius = UDim.new(0, 100)
UICorner.Parent = PlayerImage

UIAspectRatioConstraint.Parent = PlayerImage

welcome.Name = "welcome"
welcome.Parent = InformationFrame
welcome.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
welcome.BackgroundTransparency = 1.000
welcome.Position = UDim2.new(0.208747506, 0, 0.177842557, 0)
welcome.Size = UDim2.new(0.300198793, 0, 0.113702625, 0)
welcome.Font = Enum.Font.GothamBold
welcome.Text = "Welcome,"
welcome.TextColor3 = Color3.fromRGB(255, 255, 255)
welcome.TextSize = 30.000
welcome.TextWrapped = true

UITextSizeConstraint.Parent = welcome
UITextSizeConstraint.MaxTextSize = 39

UIAspectRatioConstraint_2.Parent = welcome
UIAspectRatioConstraint_2.AspectRatio = 3.872

BACKGROUNDUI_2.Name = "BACKGROUND UI"
BACKGROUNDUI_2.Parent = InformationFrame
BACKGROUNDUI_2.Active = true
BACKGROUNDUI_2.BackgroundColor3 = Color3.fromRGB(61, 61, 61)
BACKGROUNDUI_2.BorderColor3 = Color3.fromRGB(61, 61, 61)
BACKGROUNDUI_2.Position = UDim2.new(0.000640869141, 0, 0.329236507, 0)
BACKGROUNDUI_2.Size = UDim2.new(0.950760424, 0, 0, 0)

UIAspectRatioConstraint_3.Parent = InformationFrame
UIAspectRatioConstraint_3.AspectRatio = 1.472

PlayerName.Name = "PlayerName"
PlayerName.Parent = InformationFrame
PlayerName.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
PlayerName.BackgroundTransparency = 1.000
PlayerName.Position = UDim2.new(0.449783385, 0, 0.177842572, 0)
PlayerName.Size = UDim2.new(0.300198793, 0, 0.113702625, 0)
PlayerName.Font = Enum.Font.GothamBold
PlayerName.Text = "Name"
PlayerName.TextColor3 = Color3.fromRGB(255, 255, 255)
PlayerName.TextSize = 30.000
PlayerName.TextWrapped = true

UITextSizeConstraint_2.Parent = PlayerName
UITextSizeConstraint_2.MaxTextSize = 39

UIAspectRatioConstraint_4.Parent = PlayerName
UIAspectRatioConstraint_4.AspectRatio = 3.872

TransactionFrame.Name = "TransactionFrame"
TransactionFrame.Parent = BACKGROUNDUI
TransactionFrame.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
TransactionFrame.BackgroundTransparency = 1.000
TransactionFrame.BorderSizePixel = 0
TransactionFrame.Position = UDim2.new(0.227193341, 0, 0.157696471, 0)
TransactionFrame.Size = UDim2.new(0.767628372, 0, 0.839430392, 0)
TransactionFrame.Visible = false

TextLabel.Parent = TransactionFrame
TextLabel.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
TextLabel.BackgroundTransparency = 1.000
TextLabel.Size = UDim2.new(0.987551868, 0, 0.14662756, 0)
TextLabel.Font = Enum.Font.GothamBold
TextLabel.Text = "bypass"
TextLabel.TextColor3 = Color3.fromRGB(0, 0, 0)
TextLabel.TextScaled = true
TextLabel.TextSize = 14.000
TextLabel.TextWrapped = true

UITextSizeConstraint_3.Parent = TextLabel
UITextSizeConstraint_3.MaxTextSize = 50

UIAspectRatioConstraint_5.Parent = TransactionFrame
UIAspectRatioConstraint_5.AspectRatio = 1.413

textbox.Name = "textbox"
textbox.Parent = TransactionFrame
textbox.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
textbox.BorderColor3 = Color3.fromRGB(0, 0, 0)
textbox.BorderSizePixel = 0
textbox.Position = UDim2.new(1.26628962e-07, 0, 0.193548381, 0)
textbox.Size = UDim2.new(0.985477149, 0, 0.14662756, 0)
textbox.Font = Enum.Font.GothamBold
textbox.PlaceholderColor3 = Color3.fromRGB(255, 255, 255)
textbox.PlaceholderText = "enter what you want to bypass here"
textbox.Text = ""
textbox.TextColor3 = Color3.fromRGB(255, 255, 255)
textbox.TextScaled = true
textbox.TextSize = 14.000
textbox.TextWrapped = true

UICorner_2.Parent = textbox

UITextSizeConstraint_4.Parent = textbox
UITextSizeConstraint_4.MaxTextSize = 14

toggle.Name = "toggle"
toggle.Parent = TransactionFrame
toggle.AnchorPoint = Vector2.new(0.5, 0.5)
toggle.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
toggle.BorderColor3 = Color3.fromRGB(255, 255, 255)
toggle.Position = UDim2.new(0.494694889, 0, 0.663427114, 0)
toggle.Size = UDim2.new(0.104090065, 0, 0.146627545, 0)
toggle.AutoButtonColor = false
toggle.Font = Enum.Font.GothamBold
toggle.Text = ""
toggle.TextColor3 = Color3.fromRGB(255, 255, 255)
toggle.TextScaled = true
toggle.TextSize = 14.000
toggle.TextWrapped = true

UICorner_3.Parent = toggle

UITextSizeConstraint_5.Parent = toggle
UITextSizeConstraint_5.MaxTextSize = 14

UIAspectRatioConstraint_6.Parent = toggle

BACKGROUNDUI_3.Name = "BACKGROUND UI"
BACKGROUNDUI_3.Parent = TransactionFrame
BACKGROUNDUI_3.Active = true
BACKGROUNDUI_3.BackgroundColor3 = Color3.fromRGB(61, 61, 61)
BACKGROUNDUI_3.BorderColor3 = Color3.fromRGB(61, 61, 61)
BACKGROUNDUI_3.Position = UDim2.new(1.26628962e-07, 0, 0.164168105, 0)
BACKGROUNDUI_3.Size = UDim2.new(0.989563346, 0, -0.00195956277, 0)

TextLabel_2.Parent = TransactionFrame
TextLabel_2.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
TextLabel_2.BackgroundTransparency = 1.000
TextLabel_2.Position = UDim2.new(0, 0, 0.794721425, 0)
TextLabel_2.Size = UDim2.new(0.987551868, 0, 0.14662756, 0)
TextLabel_2.Font = Enum.Font.GothamBold
TextLabel_2.Text = "(click twice for it to work)"
TextLabel_2.TextColor3 = Color3.fromRGB(255, 255, 255)
TextLabel_2.TextSize = 14.000
TextLabel_2.TextWrapped = true

UITextSizeConstraint_6.Parent = TextLabel_2
UITextSizeConstraint_6.MaxTextSize = 50

TextLabel_3.Parent = TransactionFrame
TextLabel_3.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
TextLabel_3.BackgroundTransparency = 1.000
TextLabel_3.BorderColor3 = Color3.fromRGB(0, 0, 0)
TextLabel_3.BorderSizePixel = 0
TextLabel_3.Position = UDim2.new(0.320924759, 0, 0.377251774, 0)
TextLabel_3.Size = UDim2.new(0.347302914, 0, 0.100000009, 0)
TextLabel_3.Font = Enum.Font.GothamBold
TextLabel_3.Text = "reset filter"
TextLabel_3.TextColor3 = Color3.fromRGB(255, 255, 255)
TextLabel_3.TextScaled = true
TextLabel_3.TextSize = 14.000
TextLabel_3.TextWrapped = true
TextLabel_3.TextXAlignment = Enum.TextXAlignment.Right

UITextSizeConstraint_7.Parent = TextLabel_3
UITextSizeConstraint_7.MaxTextSize = 34

TextLabel_4.Parent = TransactionFrame
TextLabel_4.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
TextLabel_4.BackgroundTransparency = 1.000
TextLabel_4.BorderColor3 = Color3.fromRGB(0, 0, 0)
TextLabel_4.BorderSizePixel = 0
TextLabel_4.Position = UDim2.new(0.320924759, 0, 0.468160868, 0)
TextLabel_4.Size = UDim2.new(0.347302914, 0, 0.100000009, 0)
TextLabel_4.Font = Enum.Font.GothamBold
TextLabel_4.Text = "v"
TextLabel_4.TextColor3 = Color3.fromRGB(255, 255, 255)
TextLabel_4.TextScaled = true
TextLabel_4.TextSize = 14.000
TextLabel_4.TextWrapped = true

UITextSizeConstraint_8.Parent = TextLabel_4
UITextSizeConstraint_8.MaxTextSize = 34

Deposit.Name = "Deposit"
Deposit.Parent = BACKGROUNDUI
Deposit.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
Deposit.BackgroundTransparency = 1.000
Deposit.Position = UDim2.new(0.0720125139, 0, 0.720360637, 0)
Deposit.Size = UDim2.new(0.120113678, 0, 0.056934163, 0)
Deposit.Font = Enum.Font.GothamBold
Deposit.Text = "settings"
Deposit.TextColor3 = Color3.fromRGB(255, 255, 255)
Deposit.TextScaled = true
Deposit.TextSize = 13.000
Deposit.TextWrapped = true

UITextSizeConstraint_9.Parent = Deposit
UITextSizeConstraint_9.MaxTextSize = 16

DepositFrame.Name = "DepositFrame"
DepositFrame.Parent = BACKGROUNDUI
DepositFrame.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
DepositFrame.BackgroundTransparency = 1.000
DepositFrame.Position = UDim2.new(0.226654187, 0, 0.151478782, 0)
DepositFrame.Size = UDim2.new(0.79948014, 0, 0.844353735, 0)
DepositFrame.Visible = false

Information.Name = "Information"
Information.Parent = DepositFrame
Information.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
Information.BackgroundTransparency = 1.000
Information.BorderColor3 = Color3.fromRGB(61, 61, 61)
Information.BorderSizePixel = 0
Information.Position = UDim2.new(0, 0, 0.011661808, 0)
Information.Size = UDim2.new(0.966135442, 0, 0.157434404, 0)
Information.Font = Enum.Font.GothamBold
Information.Text = "settings"
Information.TextColor3 = Color3.fromRGB(255, 255, 255)
Information.TextScaled = true
Information.TextSize = 14.000
Information.TextWrapped = true

Ui_6.Name = "Ui"
Ui_6.Parent = DepositFrame
Ui_6.Active = true
Ui_6.BackgroundColor3 = Color3.fromRGB(61, 61, 61)
Ui_6.BorderColor3 = Color3.fromRGB(61, 61, 61)
Ui_6.Position = UDim2.new(0.000709564076, 0, 0.174635634, 0)
Ui_6.Size = UDim2.new(0.950103402, 0, 0, 0)

UIAspectRatioConstraint_7.Parent = DepositFrame
UIAspectRatioConstraint_7.AspectRatio = 1.464

TextLabel_5.Parent = DepositFrame
TextLabel_5.BackgroundColor3 = Color3.fromRGB(24, 24, 24)
TextLabel_5.BorderColor3 = Color3.fromRGB(0, 0, 0)
TextLabel_5.BorderSizePixel = 0
TextLabel_5.Position = UDim2.new(0.000709564076, 0, 0.198250726, 0)
TextLabel_5.Size = UDim2.new(0.9482072, 0, 0.145772591, 0)
TextLabel_5.Font = Enum.Font.GothamBold
TextLabel_5.Text = "this is probably unfinished blame @userhater"
TextLabel_5.TextColor3 = Color3.fromRGB(255, 255, 255)
TextLabel_5.TextSize = 14.000

EXIT.Name = "EXIT"
EXIT.Parent = BACKGROUNDUI
EXIT.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
EXIT.BackgroundTransparency = 1.000
EXIT.Position = UDim2.new(0.948329985, 0, 0.0216398519, 0)
EXIT.Size = UDim2.new(0.0384803452, 0, 0.0612099878, 0)
EXIT.Font = Enum.Font.FredokaOne
EXIT.Text = "X"
EXIT.TextColor3 = Color3.fromRGB(255, 255, 255)
EXIT.TextScaled = true
EXIT.TextSize = 28.000
EXIT.TextWrapped = true

UITextSizeConstraint_10.Parent = EXIT
UITextSizeConstraint_10.MaxTextSize = 27

WithdrawFrame.Name = "WithdrawFrame"
WithdrawFrame.Parent = BACKGROUNDUI
WithdrawFrame.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
WithdrawFrame.BackgroundTransparency = 1.000
WithdrawFrame.Position = UDim2.new(0.226654187, 0, 0.151478782, 0)
WithdrawFrame.Size = UDim2.new(0.79948014, 0, 0.844353735, 0)
WithdrawFrame.Visible = false

Information_2.Name = "Information"
Information_2.Parent = WithdrawFrame
Information_2.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
Information_2.BackgroundTransparency = 1.000
Information_2.BorderColor3 = Color3.fromRGB(61, 61, 61)
Information_2.BorderSizePixel = 0
Information_2.Position = UDim2.new(0, 0, 0.011661808, 0)
Information_2.Size = UDim2.new(0.966135442, 0, 0.157434404, 0)
Information_2.Font = Enum.Font.GothamBold
Information_2.Text = "credits"
Information_2.TextColor3 = Color3.fromRGB(255, 255, 255)
Information_2.TextScaled = true
Information_2.TextSize = 14.000
Information_2.TextWrapped = true

Ui_7.Name = "Ui"
Ui_7.Parent = WithdrawFrame
Ui_7.Active = true
Ui_7.BackgroundColor3 = Color3.fromRGB(61, 61, 61)
Ui_7.BorderColor3 = Color3.fromRGB(61, 61, 61)
Ui_7.Position = UDim2.new(0.000709564076, 0, 0.174635634, 0)
Ui_7.Size = UDim2.new(0.95069164, 0, 0, 0)

UIAspectRatioConstraint_8.Parent = WithdrawFrame
UIAspectRatioConstraint_8.AspectRatio = 1.464

TextLabel_6.Parent = WithdrawFrame
TextLabel_6.BackgroundColor3 = Color3.fromRGB(24, 24, 24)
TextLabel_6.BorderColor3 = Color3.fromRGB(0, 0, 0)
TextLabel_6.BorderSizePixel = 0
TextLabel_6.Position = UDim2.new(0, 0, 0.198250726, 0)
TextLabel_6.Size = UDim2.new(0, 477, 0, 50)
TextLabel_6.Font = Enum.Font.GothamBold
TextLabel_6.Text = "@xploits_ for ui"
TextLabel_6.TextColor3 = Color3.fromRGB(255, 255, 255)
TextLabel_6.TextSize = 14.000

TextLabel_7.Parent = WithdrawFrame
TextLabel_7.BackgroundColor3 = Color3.fromRGB(24, 24, 24)
TextLabel_7.BorderColor3 = Color3.fromRGB(0, 0, 0)
TextLabel_7.BorderSizePixel = 0
TextLabel_7.Position = UDim2.new(0, 0, 0.320699722, 0)
TextLabel_7.Size = UDim2.new(0, 477, 0, 50)
TextLabel_7.Font = Enum.Font.GothamBold
TextLabel_7.Text = "@userhater for scripts"
TextLabel_7.TextColor3 = Color3.fromRGB(255, 255, 255)
TextLabel_7.TextSize = 14.000

Information_3.Name = "Information"
Information_3.Parent = BACKGROUNDUI
Information_3.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
Information_3.BackgroundTransparency = 1.000
Information_3.Position = UDim2.new(0.0720125139, 0, 0.359535456, 0)
Information_3.Size = UDim2.new(0.120113678, 0, 0.0460000783, 0)
Information_3.Font = Enum.Font.GothamBold
Information_3.Text = "info"
Information_3.TextColor3 = Color3.fromRGB(255, 255, 255)
Information_3.TextScaled = true
Information_3.TextSize = 13.000
Information_3.TextWrapped = true

UITextSizeConstraint_11.Parent = Information_3
UITextSizeConstraint_11.MaxTextSize = 13

Transactions.Name = "Transactions"
Transactions.Parent = BACKGROUNDUI
Transactions.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
Transactions.BackgroundTransparency = 1.000
Transactions.Position = UDim2.new(0.0720125139, 0, 0.559082329, 0)
Transactions.Size = UDim2.new(0.118189596, 0, 0.0765388981, 0)
Transactions.Font = Enum.Font.GothamBold
Transactions.Text = "bypass"
Transactions.TextColor3 = Color3.fromRGB(255, 255, 255)
Transactions.TextScaled = true
Transactions.TextSize = 13.000
Transactions.TextWrapped = true

UITextSizeConstraint_12.Parent = Transactions
UITextSizeConstraint_12.MaxTextSize = 14

Withdraw.Name = "Withdraw"
Withdraw.Parent = BACKGROUNDUI
Withdraw.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
Withdraw.BackgroundTransparency = 1.000
Withdraw.Position = UDim2.new(0.0720125139, 0, 0.878905177, 0)
Withdraw.Size = UDim2.new(0.118189596, 0, 0.056934163, 0)
Withdraw.Font = Enum.Font.GothamBold
Withdraw.Text = "credits"
Withdraw.TextColor3 = Color3.fromRGB(255, 255, 255)
Withdraw.TextScaled = true
Withdraw.TextSize = 13.000
Withdraw.TextWrapped = true

UITextSizeConstraint_13.Parent = Withdraw
UITextSizeConstraint_13.MaxTextSize = 16

ACTIONS.Name = "ACTIONS"
ACTIONS.Parent = BACKGROUNDUI
ACTIONS.Active = true
ACTIONS.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
ACTIONS.BackgroundTransparency = 1.000
ACTIONS.Position = UDim2.new(-0.113307029, 0, 0.250396311, 0)
ACTIONS.Size = UDim2.new(0.30034104, 0, 0.0434629284, 0)
ACTIONS.Font = Enum.Font.GothamBold
ACTIONS.Text = "script"
ACTIONS.TextColor3 = Color3.fromRGB(47, 47, 47)
ACTIONS.TextScaled = true
ACTIONS.TextSize = 15.000
ACTIONS.TextWrapped = true

UITextSizeConstraint_14.Parent = ACTIONS
UITextSizeConstraint_14.MaxTextSize = 12

InformationIcon.Name = "Information Icon"
InformationIcon.Parent = BACKGROUNDUI
InformationIcon.Active = true
InformationIcon.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
InformationIcon.BackgroundTransparency = 1.000
InformationIcon.Position = UDim2.new(0.0156663656, 0, 0.340400815, 0)
InformationIcon.Size = UDim2.new(0.0494746827, 0, 0.084269397, 0)
InformationIcon.Font = Enum.Font.FredokaOne
InformationIcon.Text = ""
InformationIcon.TextColor3 = Color3.fromRGB(255, 255, 255)
InformationIcon.TextScaled = true
InformationIcon.TextSize = 30.000
InformationIcon.TextWrapped = true

UITextSizeConstraint_15.Parent = InformationIcon
UITextSizeConstraint_15.MaxTextSize = 24

fluency_icon.Name = "fluency_icon"
fluency_icon.Parent = InformationIcon
fluency_icon.AnchorPoint = Vector2.new(0.5, 0.5)
fluency_icon.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
fluency_icon.BackgroundTransparency = 1.000
fluency_icon.BorderColor3 = Color3.fromRGB(0, 0, 0)
fluency_icon.BorderSizePixel = 0
fluency_icon.Position = UDim2.new(0.374565333, 0, 0.494985878, 0)
fluency_icon.Size = UDim2.new(0.869129956, 0, 0.993206024, 0)
fluency_icon.Image = "rbxassetid://11422155687"
fluency_icon.ScaleType = Enum.ScaleType.Fit

DepositIcon.Name = "Deposit Icon"
DepositIcon.Parent = BACKGROUNDUI
DepositIcon.Active = true
DepositIcon.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
DepositIcon.BackgroundTransparency = 1.000
DepositIcon.Position = UDim2.new(0.010309252, 0, 0.706693232, 0)
DepositIcon.Size = UDim2.new(0.0548318774, 0, 0.084269397, 0)
DepositIcon.Font = Enum.Font.FredokaOne
DepositIcon.Text = ""
DepositIcon.TextColor3 = Color3.fromRGB(255, 255, 255)
DepositIcon.TextScaled = true
DepositIcon.TextSize = 30.000
DepositIcon.TextWrapped = true

UITextSizeConstraint_16.Parent = DepositIcon
UITextSizeConstraint_16.MaxTextSize = 24

fluency_icon_2.Name = "fluency_icon"
fluency_icon_2.Parent = DepositIcon
fluency_icon_2.AnchorPoint = Vector2.new(0.5, 0.5)
fluency_icon_2.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
fluency_icon_2.BackgroundTransparency = 1.000
fluency_icon_2.BorderColor3 = Color3.fromRGB(0, 0, 0)
fluency_icon_2.BorderSizePixel = 0
fluency_icon_2.Position = UDim2.new(0.396933377, 0, 0.491212249, 0)
fluency_icon_2.Size = UDim2.new(0.784214079, 0, 0.993206024, 0)
fluency_icon_2.Image = "rbxassetid://11293977610"
fluency_icon_2.ScaleType = Enum.ScaleType.Fit

NAME.Name = "NAME"
NAME.Parent = BACKGROUNDUI
NAME.Active = true
NAME.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
NAME.BackgroundTransparency = 1.000
NAME.BorderColor3 = Color3.fromRGB(27, 42, 53)
NAME.Position = UDim2.new(0.00893521309, 0, 0.118199766, 0)
NAME.Size = UDim2.new(0.192401722, 0, 0.0680646971, 0)
NAME.Font = Enum.Font.GothamBold
NAME.Text = "K I L L E R"
NAME.TextColor3 = Color3.fromRGB(255, 255, 255)
NAME.TextScaled = true
NAME.TextSize = 33.000
NAME.TextWrapped = true

UITextSizeConstraint_17.Parent = NAME
UITextSizeConstraint_17.MaxTextSize = 19

NAME_2.Name = "NAME"
NAME_2.Parent = BACKGROUNDUI
NAME_2.Active = true
NAME_2.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
NAME_2.BackgroundTransparency = 1.000
NAME_2.BorderColor3 = Color3.fromRGB(27, 42, 53)
NAME_2.Position = UDim2.new(0.0103091523, 0, 0.038927529, 0)
NAME_2.Size = UDim2.new(0.192401722, 0, 0.103600502, 0)
NAME_2.Font = Enum.Font.GothamBold
NAME_2.Text = "filter"
NAME_2.TextColor3 = Color3.fromRGB(0, 0, 0)
NAME_2.TextScaled = true
NAME_2.TextSize = 35.000
NAME_2.TextWrapped = true

UITextSizeConstraint_18.Parent = NAME_2
UITextSizeConstraint_18.MaxTextSize = 29

TransactionIcon.Name = "Transaction Icon"
TransactionIcon.Parent = BACKGROUNDUI
TransactionIcon.Active = true
TransactionIcon.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
TransactionIcon.BackgroundTransparency = 1.000
TransactionIcon.Position = UDim2.new(0.0156663656, 0, 0.55088222, 0)
TransactionIcon.Size = UDim2.new(0.0494746827, 0, 0.084269397, 0)
TransactionIcon.Font = Enum.Font.FredokaOne
TransactionIcon.Text = ""
TransactionIcon.TextColor3 = Color3.fromRGB(255, 255, 255)
TransactionIcon.TextScaled = true
TransactionIcon.TextSize = 30.000
TransactionIcon.TextWrapped = true

UITextSizeConstraint_19.Parent = TransactionIcon
UITextSizeConstraint_19.MaxTextSize = 24

fluency_icon_3.Name = "fluency_icon"
fluency_icon_3.Parent = TransactionIcon
fluency_icon_3.AnchorPoint = Vector2.new(0.5, 0.5)
fluency_icon_3.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
fluency_icon_3.BackgroundTransparency = 1.000
fluency_icon_3.BorderColor3 = Color3.fromRGB(0, 0, 0)
fluency_icon_3.BorderSizePixel = 0
fluency_icon_3.Position = UDim2.new(0.379897594, 0, 0.499999553, 0)
fluency_icon_3.Size = UDim2.new(0.804749966, 0, 0.993206024, 0)
fluency_icon_3.Image = "rbxassetid://12974469797"
fluency_icon_3.ScaleType = Enum.ScaleType.Fit

WithdrawIcon.Name = "Withdraw Icon"
WithdrawIcon.Parent = BACKGROUNDUI
WithdrawIcon.Active = true
WithdrawIcon.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
WithdrawIcon.BackgroundTransparency = 1.000
WithdrawIcon.Position = UDim2.new(0.0149369836, 0, 0.864070535, 0)
WithdrawIcon.Size = UDim2.new(0.0494746827, 0, 0.084269397, 0)
WithdrawIcon.Font = Enum.Font.FredokaOne
WithdrawIcon.Text = ""
WithdrawIcon.TextColor3 = Color3.fromRGB(255, 255, 255)
WithdrawIcon.TextScaled = true
WithdrawIcon.TextSize = 30.000
WithdrawIcon.TextWrapped = true

UITextSizeConstraint_20.Parent = WithdrawIcon
UITextSizeConstraint_20.MaxTextSize = 24

fluency_icon_4.Name = "fluency_icon"
fluency_icon_4.Parent = WithdrawIcon
fluency_icon_4.AnchorPoint = Vector2.new(0.5, 0.5)
fluency_icon_4.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
fluency_icon_4.BackgroundTransparency = 1.000
fluency_icon_4.BorderColor3 = Color3.fromRGB(0, 0, 0)
fluency_icon_4.BorderSizePixel = 0
fluency_icon_4.Position = UDim2.new(0.361292154, 0, 0.498685509, 0)
fluency_icon_4.Size = UDim2.new(0.901319981, 0, 0.993206024, 0)
fluency_icon_4.Image = "rbxassetid://12974250071"
fluency_icon_4.ScaleType = Enum.ScaleType.Fit

Ui_8.Name = "Ui"
Ui_8.Parent = BACKGROUNDUI
Ui_8.Active = true
Ui_8.BackgroundColor3 = Color3.fromRGB(61, 61, 61)
Ui_8.BorderColor3 = Color3.fromRGB(71, 71, 71)
Ui_8.BorderSizePixel = 0
Ui_8.Position = UDim2.new(0.00590674998, 0, 0.488098055, 0)
Ui_8.Size = UDim2.new(0.197826013, 0, 0.00574890152, 0)

BACKGROUNDUI_4.Name = "BACKGROUND UI"
BACKGROUNDUI_4.Parent = BACKGROUNDUI
BACKGROUNDUI_4.Active = true
BACKGROUNDUI_4.BackgroundColor3 = Color3.fromRGB(61, 61, 61)
BACKGROUNDUI_4.BorderColor3 = Color3.fromRGB(61, 61, 61)
BACKGROUNDUI_4.Position = UDim2.new(0.227193445, 0, 0.137052253, 0)
BACKGROUNDUI_4.Size = UDim2.new(0.75999999, 0, -0, 0)

resetpopup.Name = "reset popup"
resetpopup.Parent = BankingSystem
resetpopup.AnchorPoint = Vector2.new(0.5, 0.5)
resetpopup.BackgroundColor3 = Color3.fromRGB(24, 24, 24)
resetpopup.BorderColor3 = Color3.fromRGB(0, 0, 0)
resetpopup.BorderSizePixel = 0
resetpopup.Position = UDim2.new(0.5, 0, -0.200000003, 0)
resetpopup.Size = UDim2.new(0.300000042, 0, 0.0636591539, 0)

TextLabel_8.Parent = resetpopup
TextLabel_8.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
TextLabel_8.BackgroundTransparency = 1.000
TextLabel_8.BorderColor3 = Color3.fromRGB(0, 0, 0)
TextLabel_8.BorderSizePixel = 0
TextLabel_8.Size = UDim2.new(1, 0, 1, 0)
TextLabel_8.Font = Enum.Font.GothamBold
TextLabel_8.Text = "Filter Reset!"
TextLabel_8.TextColor3 = Color3.fromRGB(255, 255, 255)
TextLabel_8.TextScaled = true
TextLabel_8.TextSize = 14.000
TextLabel_8.TextWrapped = true

UITextSizeConstraint_21.Parent = TextLabel_8
UITextSizeConstraint_21.MaxTextSize = 14

-- Scripts:

local function QWEGVJ_fake_script() -- InformationFrame.LocalScript 
	local script = Instance.new('LocalScript', InformationFrame)

	local frame = script.Parent
	
	
	
	local player = game.Players.LocalPlayer
	
	
	
	local userId = player.UserId
	
	local thumbType = Enum.ThumbnailType.AvatarBust
	
	local thumbSize = Enum.ThumbnailSize.Size420x420
	
	local content, isReady = game.Players:GetUserThumbnailAsync(userId, thumbType, thumbSize)
	
	
	
	
	
	frame.PlayerImage.Image = content
	
	frame.PlayerName.Text = player.Name
	
end
coroutine.wrap(QWEGVJ_fake_script)()
local function IIQVI_fake_script() -- TextLabel.LocalScript 
	local script = Instance.new('LocalScript', TextLabel)

	while true do
		script.Parent.TextColor3 = Color3.new(255/255,0/255,0/255)
		for i = 0,255,10 do
			wait()
			script.Parent.TextColor3 = Color3.new(255/255,i/255,0/255)
		end
		for i = 255,0,-10 do
			wait()
			script.Parent.TextColor3 = Color3.new(i/255,255/255,0/255)
		end
		for i = 0,255,10 do
			wait()
			script.Parent.TextColor3 = Color3.new(0/255,255/255,i/255)
		end
		for i = 255,0,-10 do
			wait()
			script.Parent.TextColor3 = Color3.new(0/255,i/255,255/255)
		end
		for i = 0,255,10 do
			wait()
			script.Parent.TextColor3 = Color3.new(i/255,0/255,255/255)
		end
		for i = 255,0,-10 do
			wait()
			script.Parent.TextColor3 = Color3.new(255/255,0/255,i/255)
		end
	end
end
coroutine.wrap(IIQVI_fake_script)()
local function TOLW_fake_script() -- NAME_2.LocalScript 
	local script = Instance.new('LocalScript', NAME_2)

	while true do
		script.Parent.TextColor3 = Color3.new(255/255,0/255,0/255)
		for i = 0,255,10 do
			wait()
			script.Parent.TextColor3 = Color3.new(255/255,i/255,0/255)
		end
		for i = 255,0,-10 do
			wait()
			script.Parent.TextColor3 = Color3.new(i/255,255/255,0/255)
		end
		for i = 0,255,10 do
			wait()
			script.Parent.TextColor3 = Color3.new(0/255,255/255,i/255)
		end
		for i = 255,0,-10 do
			wait()
			script.Parent.TextColor3 = Color3.new(0/255,i/255,255/255)
		end
		for i = 0,255,10 do
			wait()
			script.Parent.TextColor3 = Color3.new(i/255,0/255,255/255)
		end
		for i = 255,0,-10 do
			wait()
			script.Parent.TextColor3 = Color3.new(255/255,0/255,i/255)
		end
	end
end
coroutine.wrap(TOLW_fake_script)()
local function VNBAABK_fake_script() -- BACKGROUNDUI.LocalScript 
	local script = Instance.new('LocalScript', BACKGROUNDUI)

	local ts = game:GetService("TweenService")
	local tcs = game:GetService("TextChatService")
	local rstorage = game:GetService("ReplicatedStorage")
	local plrs = game:GetService("Players")
	
	local main = script.Parent
	
	
	local info = main.InformationFrame
	local nigga = main.TransactionFrame
	local with = main.WithdrawFrame
	local depo = main.DepositFrame
	
	local depobtn = main.Deposit
	local infobtn = main.Information
	local withbtn = main.Withdraw
	local niggabtn = main.Transactions
	
	local nigger={
		{info, infobtn},
		{depo, depobtn},
		{nigga, niggabtn},
		{with, withbtn}
	}
	
	local function rape()
		for _,v in next, nigger do
			v[1].Visible = false
		end
	end
	
	for _,v in next, nigger do
		local frame = v[1]
		local btn = v[2]
		
		btn.MouseButton1Down:Connect(function()
			rape()
			frame.Visible = not frame.Visible
		end)
	end
	
	local exit = main.EXIT
	
	exit.MouseButton1Down:Connect(function()
		main.Parent:Destroy()
	end)
	
	main.Draggable = true
	main.Active = true
	main.Selectable = true
	
	local toggle = nigga.toggle
	local enabled = false
	
	local default = toggle.Size
	local on = ts:Create(toggle, TweenInfo.new(0.2), {BackgroundColor3 = Color3.fromRGB(0, 255, 0)})
	local off = ts:Create(toggle, TweenInfo.new(0.2), {BackgroundColor3 = Color3.fromRGB(255, 0, 0)})
	
	toggle.MouseButton1Down:Connect(function()
		toggle:TweenSize(UDim2.new(default.X.Scale * 0.85, 0, default.Y.Scale * 0.85, 0), Enum.EasingDirection.InOut, Enum.EasingStyle.Quad, 0.1, true)
		enabled = not enabled
		if enabled then on:Play() else off:Play() end
	end)
	
	toggle.MouseButton1Up:Connect(function()
		toggle:TweenSize(UDim2.new(default.X.Scale * 0.9, 0, default.Y.Scale * 0.9, 0), Enum.EasingDirection.InOut, Enum.EasingStyle.Quad, 0.1, true)
	end)
	
	toggle.MouseEnter:Connect(function()
		toggle:TweenSize(UDim2.new(default.X.Scale * 0.9, 0, default.Y.Scale * 0.9, 0), Enum.EasingDirection.InOut, Enum.EasingStyle.Quad, 0.2, true)
	end)
	
	toggle.MouseLeave:Connect(function()
		toggle:TweenSize(default, Enum.EasingDirection.InOut, Enum.EasingStyle.Quad, 0.2, true)
	end)
	
	local chat = function(msg)
		if tcs.ChatVersion == Enum.ChatVersion.TextChatService then
			local Channel = tcs.TextChannels.RBXGeneral
			Channel:SendAsync(msg)
		else
			local Remote = rstorage:FindFirstChild("SayMessageRequest", true)
			Remote:FireServer(msg, "All")
		end
	end
	
	local resetfilter = function()
		task.spawn(function()
			local ez = math.random(10000000, 99999999) .. " reset filter lol"
			if tcs.ChatVersion == Enum.ChatVersion.TextChatService then
				local Channel = tcs.TextChannels.RBXGeneral
				for i = 1, 5 do
					Channel:SendAsync("/e " .. ez)
				end
			else
				for i = 1, 5 do
					plrs:Chat(ez)
				end
			end
		end)
	end
	
	local Keywords = {
		["rape"] = "⁥⁥⁥⁥⁥r⁥⁥⁥⁥⁥а⁥⁥⁥⁥⁥р⁥⁥⁥⁥⁥е⁥⁥⁥⁥⁥",
		["sex"] = "⁥⁥⁥⁥⁥ѕ⁥⁥⁥⁥⁥е⁥⁥⁥⁥⁥х⁥⁥⁥⁥⁥",
		["whore"] = "⁥⁥⁥⁥⁥w⁥⁥⁥⁥⁥һ⁥⁥⁥⁥⁥o⁥⁥⁥⁥⁥r⁥⁥⁥⁥⁥e⁥⁥⁥⁥⁥",
		["slut"] = "⁥⁥⁥⁥⁥ѕ⁥⁥⁥⁥⁥ӏ⁥⁥⁥⁥⁥u⁥⁥⁥⁥⁥t⁥⁥⁥⁥⁥",
		["pornhub"] = "⁥⁥⁥⁥⁥ро⁥⁥⁥⁥⁥r⁥⁥⁥⁥⁥n⁥⁥⁥⁥⁥һ⁥⁥⁥⁥⁥u⁥⁥⁥⁥⁥b⁥⁥⁥⁥⁥",
		["cock"] = "⁥⁥⁥⁥⁥с⁥⁥⁥⁥⁥о⁥⁥⁥⁥⁥с⁥⁥⁥⁥⁥k⁥⁥⁥⁥⁥",
		["pussy"] = "⁥⁥⁥⁥⁥р⁥⁥⁥⁥⁥u⁥⁥⁥⁥⁥ѕ⁥⁥⁥⁥⁥ѕ⁥⁥⁥⁥⁥у⁥⁥⁥⁥⁥",
		["naked"] = "⁥⁥⁥⁥⁥n⁥⁥⁥⁥⁥а⁥⁥⁥⁥⁥k⁥⁥⁥⁥⁥е⁥⁥⁥⁥⁥d⁥⁥⁥⁥⁥",
		["titties"] = "⁥⁥⁥⁥⁥t⁥⁥⁥⁥⁥і⁥⁥⁥⁥⁥t⁥⁥⁥⁥⁥t⁥⁥⁥⁥⁥і⁥⁥⁥⁥⁥е⁥⁥⁥⁥⁥ѕ⁥⁥⁥⁥⁥",
		["titty"] = "⁥⁥⁥⁥⁥t⁥⁥⁥⁥⁥і⁥⁥⁥⁥⁥t⁥⁥⁥⁥⁥t⁥⁥⁥⁥⁥y⁥⁥⁥⁥⁥",
		["tits"] = "⁥⁥⁥⁥⁥t⁥⁥⁥⁥⁥і⁥⁥⁥⁥⁥t⁥⁥⁥⁥⁥s⁥⁥⁥⁥⁥",
		["cum"] = "⁥⁥⁥⁥⁥с⁥⁥⁥⁥⁥u⁥⁥⁥⁥⁥m⁥⁥⁥⁥⁥",
		["kkk"] = "⁥⁥⁥⁥⁥К⁥⁥⁥⁥⁥К⁥⁥⁥⁥⁥К⁥⁥⁥⁥⁥",
		["rizz"] = "r⁥⁥⁥⁥⁥i⁥⁥⁥⁥⁥z⁥⁥⁥⁥⁥z",
		["ass"] = "⁥⁥⁥⁥⁥а⁥⁥⁥⁥⁥ѕ⁥⁥⁥⁥⁥ѕ⁥⁥⁥⁥⁥",
		["vagina"] = "⁥⁥⁥⁥⁥v⁥⁥⁥⁥⁥а⁥⁥⁥⁥⁥g⁥⁥⁥⁥⁥і⁥⁥⁥⁥⁥n⁥⁥⁥⁥⁥а⁥⁥⁥⁥⁥",
		["nudes"] = "⁥⁥⁥⁥⁥n⁥⁥⁥⁥⁥u⁥⁥⁥⁥⁥d⁥⁥⁥⁥⁥е⁥⁥⁥⁥⁥ѕ⁥⁥⁥⁥⁥",
		["ho"] = "⁥⁥⁥⁥⁥һ⁥⁥⁥⁥⁥о⁥⁥⁥⁥⁥",
		["fuck"] = "⁥⁥⁥⁥⁥ғ⁥⁥⁥⁥⁥ʋ⁥⁥⁥⁥⁥с⁥⁥⁥⁥⁥k⁥⁥⁥⁥⁥",
		["nigger"] = "⁥⁥⁥⁥п⁥⁥⁥⁥ⅰ⁥⁥⁥⁥g⁥⁥⁥⁥g⁥⁥⁥⁥е⁥⁥⁥⁥r⁥⁥⁥⁥",
		["nigga"] = "⁥⁥⁥⁥п⁥⁥⁥⁥ⅰ⁥⁥⁥⁥g⁥⁥⁥⁥g⁥⁥⁥⁥а⁥⁥⁥⁥",
		["blowjob"] = "⁥⁥⁥⁥b⁥⁥⁥⁥ӏ⁥⁥⁥⁥о⁥⁥⁥⁥w⁥⁥⁥⁥ј⁥⁥⁥⁥o⁥⁥⁥⁥b⁥⁥⁥⁥",
		["faggot"] = "⁥⁥⁥⁥⁥f⁥⁥⁥⁥⁥а⁥⁥⁥⁥⁥g⁥⁥⁥⁥⁥g⁥⁥⁥⁥⁥о⁥⁥⁥⁥⁥т⁥⁥⁥⁥⁥⁥⁥⁥⁥⁥",
		["femboy"] = "fеmbоу",
		["love"] = "⁥⁥⁥⁥⁥ӏ⁥⁥⁥⁥⁥о⁥⁥⁥⁥⁥v⁥⁥⁥⁥⁥е⁥⁥⁥⁥⁥",
		["kiss"] = "⁥⁥⁥⁥⁥k⁥⁥⁥⁥⁥і⁥⁥⁥⁥⁥ѕ⁥⁥⁥⁥⁥ѕ⁥⁥⁥⁥⁥",
		["discord"] = "dіѕсоrd",
		["porn"] = "⁥⁥⁥⁥⁥ро⁥⁥⁥⁥⁥r⁥⁥⁥⁥⁥n⁥⁥⁥⁥⁥",
		["damn"] = "dаmn",
		["anal"] = "аnаl",
		["zoophile"] = "zоорһіӏе",
		["lmao"] = "LМАО",
		["lmfao"] = "LМFАО",
		["george"] = "gеоrgе",
		["floyd"] = "flоуd",
		["kill"] = "kіІІ",
		["yourself"] = "yourself",
		["shit"] = "⁥⁥⁥⁥⁥ѕ⁥⁥⁥⁥⁥һ⁥⁥⁥⁥⁥ⅰ⁥⁥⁥⁥⁥т⁥⁥⁥⁥⁥",
		["bitch"] = "⁥⁥⁥⁥⁥⁥⁥⁥⁥Ь⁥⁥⁥⁥⁥ⅰ⁥⁥⁥⁥⁥т⁥⁥⁥⁥⁥с⁥⁥⁥⁥⁥һ⁥⁥⁥⁥⁥⁥⁥⁥⁥",
		["sexual"] = "⁥⁥⁥⁥⁥ѕ⁥⁥⁥⁥⁥е⁥⁥⁥⁥⁥х⁥⁥⁥⁥⁥ual",
		["tiktok"] = "tіktоk",
		["twerk"] = "twеrk",
		["mf"] = "⁥⁥⁥⁥⁥m⁥⁥⁥⁥⁥f⁥⁥⁥⁥⁥",
		["gay"] = "⁥⁥⁥⁥⁥g⁥⁥⁥⁥⁥а⁥⁥⁥⁥⁥у⁥⁥⁥⁥⁥",
		["black"] = "bӏасk",
		["dick"] = "⁥⁥⁥⁥⁥d⁥⁥⁥⁥⁥ⅰ⁥⁥⁥⁥⁥с⁥⁥⁥⁥⁥k⁥⁥⁥⁥⁥",
		["suck"] = "ѕuсk",
		["heil"] = "һеіӏ",
		["nazi"] = "⁥⁥⁥⁥⁥n⁥⁥⁥⁥⁥a⁥⁥⁥⁥⁥z⁥⁥⁥⁥⁥ⅰ⁥⁥⁥⁥⁥",
		["penis"] = "⁥⁥⁥⁥⁥р⁥⁥⁥⁥⁥е⁥⁥⁥⁥⁥п⁥⁥⁥⁥⁥ⅰ⁥⁥⁥⁥⁥ѕ⁥⁥⁥⁥⁥",
		["sperm"] = "⁥⁥⁥⁥⁥ѕ⁥⁥⁥⁥⁥р⁥⁥⁥⁥⁥е⁥⁥⁥⁥⁥г⁥⁥⁥⁥⁥m⁥⁥⁥⁥⁥",
		["pedo"] = "⁥⁥⁥⁥⁥р⁥⁥⁥⁥⁥е⁥⁥⁥⁥⁥ɗ⁥⁥⁥⁥⁥о⁥⁥⁥⁥⁥",
		["hate"] = "һаtе",
		["balls"] = "bаӏӏѕ",
	}
	
	local bypass = function(msg)
		for word, bypass in next, Keywords do
			msg = msg:gsub(word, bypass)
		end
		return msg
	end
	
	local textbox = nigga.textbox
	local popup = main.Parent["reset popup"]
	
	textbox.FocusLost:Connect(function(enter)
		if enter then
			local msg = textbox.Text
			chat(bypass(msg))
			if enabled then
				task.spawn(function()
					resetfilter()
					popup:TweenPosition(UDim2.new(0.5, 0, 0.082, 0), Enum.EasingDirection.InOut, Enum.EasingStyle.Quad, 0.5, true)
					task.wait(3)
					popup:TweenPosition(UDim2.new(0.5, 0, -0.2, 0), Enum.EasingDirection.InOut, Enum.EasingStyle.Quad, 0.5, true)
				end)
			end
		end
	end)
end
coroutine.wrap(VNBAABK_fake_script)()
