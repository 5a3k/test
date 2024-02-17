--[=[
 d888b  db    db d888888b      .d888b.      db      db    db  .d8b.  
88' Y8b 88    88   `88'        VP  `8D      88      88    88 d8' `8b 
88      88    88    88            odD'      88      88    88 88ooo88 
88  ooo 88    88    88          .88'        88      88    88 88~~~88 
88. ~8~ 88b  d88   .88.        j88.         88booo. 88b  d88 88   88 
 Y888P  ~Y8888P' Y888888P      888888D      Y88888P ~Y8888P' YP   YP  CONVERTER
]=]

-- Instances: 87 | Scripts: 4 | Modules: 0
local G2L = {};

-- StarterGui.Banking System
G2L["1"] = Instance.new("ScreenGui", game:GetService("CoreGui"));
G2L["1"]["DisplayOrder"] = 999;
G2L["1"]["Name"] = [[Banking System]];
G2L["1"]["ZIndexBehavior"] = Enum.ZIndexBehavior.Sibling;
G2L["1"]["ResetOnSpawn"] = false;

-- StarterGui.Banking System.BACKGROUNDUI
G2L["2"] = Instance.new("Frame", G2L["1"]);
G2L["2"]["Active"] = true;
G2L["2"]["BorderSizePixel"] = 0;
G2L["2"]["BackgroundColor3"] = Color3.fromRGB(25, 25, 25);
G2L["2"]["Size"] = UDim2.new(0.40615007281303406, 0, 0.5090574622154236, 0);
G2L["2"]["BorderColor3"] = Color3.fromRGB(28, 43, 54);
G2L["2"]["Position"] = UDim2.new(0.2964330017566681, 0, 0.24479804933071136, 0);
G2L["2"]["Name"] = [[BACKGROUNDUI]];

-- StarterGui.Banking System.BACKGROUNDUI.Ui
G2L["3"] = Instance.new("Frame", G2L["2"]);
G2L["3"]["Active"] = true;
G2L["3"]["BorderSizePixel"] = 0;
G2L["3"]["BackgroundColor3"] = Color3.fromRGB(30, 30, 30);
G2L["3"]["Size"] = UDim2.new(0.21442347764968872, 0, 1.0000001192092896, 0);
G2L["3"]["BorderColor3"] = Color3.fromRGB(28, 43, 54);
G2L["3"]["Position"] = UDim2.new(-0.0030284267850220203, 0, 0, 0);
G2L["3"]["Name"] = [[Ui]];

-- StarterGui.Banking System.BACKGROUNDUI.Ui
G2L["4"] = Instance.new("Frame", G2L["2"]);
G2L["4"]["Active"] = true;
G2L["4"]["BorderSizePixel"] = 0;
G2L["4"]["BackgroundColor3"] = Color3.fromRGB(62, 62, 62);
G2L["4"]["Size"] = UDim2.new(0.7606263756752014, 0, -0.0020000000949949026, 0);
G2L["4"]["BorderColor3"] = Color3.fromRGB(72, 72, 72);
G2L["4"]["Position"] = UDim2.new(0.22665415704250336, 0, 0.1370522528886795, 0);
G2L["4"]["Name"] = [[Ui]];

-- StarterGui.Banking System.BACKGROUNDUI.Ui
G2L["5"] = Instance.new("Frame", G2L["2"]);
G2L["5"]["Active"] = true;
G2L["5"]["BorderSizePixel"] = 0;
G2L["5"]["BackgroundColor3"] = Color3.fromRGB(62, 62, 62);
G2L["5"]["Size"] = UDim2.new(0.10843345522880554, 0, 0.004568465519696474, 0);
G2L["5"]["BorderColor3"] = Color3.fromRGB(72, 72, 72);
G2L["5"]["Position"] = UDim2.new(0.00977435801178217, 0, 0.2909353971481323, 0);
G2L["5"]["Name"] = [[Ui]];

-- StarterGui.Banking System.BACKGROUNDUI.Ui
G2L["6"] = Instance.new("Frame", G2L["2"]);
G2L["6"]["Active"] = true;
G2L["6"]["BackgroundColor3"] = Color3.fromRGB(62, 62, 62);
G2L["6"]["Size"] = UDim2.new(0, 0, 0.9567204117774963, 0);
G2L["6"]["BorderColor3"] = Color3.fromRGB(62, 62, 62);
G2L["6"]["Position"] = UDim2.new(0.2144233137369156, 0, 0.021639857441186905, 0);
G2L["6"]["Name"] = [[Ui]];

-- StarterGui.Banking System.BACKGROUNDUI.Ui
G2L["7"] = Instance.new("Frame", G2L["2"]);
G2L["7"]["Active"] = true;
G2L["7"]["BorderSizePixel"] = 0;
G2L["7"]["BackgroundColor3"] = Color3.fromRGB(62, 62, 62);
G2L["7"]["Size"] = UDim2.new(0.19782601296901703, 0, 0.005748901516199112, 0);
G2L["7"]["BorderColor3"] = Color3.fromRGB(72, 72, 72);
G2L["7"]["Position"] = UDim2.new(0.009091924875974655, 0, 0.24439245462417603, 0);
G2L["7"]["Name"] = [[Ui]];

-- StarterGui.Banking System.BACKGROUNDUI.InformationFrame
G2L["8"] = Instance.new("Frame", G2L["2"]);
G2L["8"]["BorderSizePixel"] = 0;
G2L["8"]["BackgroundColor3"] = Color3.fromRGB(255, 255, 255);
G2L["8"]["BackgroundTransparency"] = 1;
G2L["8"]["Size"] = UDim2.new(0.799480140209198, 0, 0.8394303917884827, 0);
G2L["8"]["Position"] = UDim2.new(0.22614777088165283, 0, 0.15754705667495728, 0);
G2L["8"]["Name"] = [[InformationFrame]];

-- StarterGui.Banking System.BACKGROUNDUI.InformationFrame.PlayerImage
G2L["9"] = Instance.new("ImageLabel", G2L["8"]);
G2L["9"]["BackgroundColor3"] = Color3.fromRGB(25, 25, 25);
G2L["9"]["Image"] = [[rbxasset://textures/ui/GuiImagePlaceholder.png]];
G2L["9"]["Size"] = UDim2.new(0.19880715012550354, 0, 0.29154518246650696, 0);
G2L["9"]["Name"] = [[PlayerImage]];
G2L["9"]["BackgroundTransparency"] = 1;
G2L["9"]["Position"] = UDim2.new(-0.001988070085644722, 0, 0, 0);

-- StarterGui.Banking System.BACKGROUNDUI.InformationFrame.PlayerImage.UICorner
G2L["a"] = Instance.new("UICorner", G2L["9"]);
G2L["a"]["CornerRadius"] = UDim.new(0, 100);

-- StarterGui.Banking System.BACKGROUNDUI.InformationFrame.PlayerImage.UIAspectRatioConstraint
G2L["b"] = Instance.new("UIAspectRatioConstraint", G2L["9"]);


-- StarterGui.Banking System.BACKGROUNDUI.InformationFrame.LocalScript
G2L["c"] = Instance.new("LocalScript", G2L["8"]);


-- StarterGui.Banking System.BACKGROUNDUI.InformationFrame.welcome
G2L["d"] = Instance.new("TextLabel", G2L["8"]);
G2L["d"]["TextWrapped"] = true;
G2L["d"]["BackgroundColor3"] = Color3.fromRGB(255, 255, 255);
G2L["d"]["FontFace"] = Font.new([[rbxasset://fonts/families/GothamSSm.json]], Enum.FontWeight.Bold, Enum.FontStyle.Normal);
G2L["d"]["TextSize"] = 30;
G2L["d"]["TextColor3"] = Color3.fromRGB(255, 255, 255);
G2L["d"]["Size"] = UDim2.new(0.2990429103374481, 0, 0.11370262503623962, 0);
G2L["d"]["Text"] = [[Welcome,]];
G2L["d"]["Name"] = [[welcome]];
G2L["d"]["BackgroundTransparency"] = 1;
G2L["d"]["Position"] = UDim2.new(0.2087475061416626, 0, 0.17784255743026733, 0);

-- StarterGui.Banking System.BACKGROUNDUI.InformationFrame.welcome.UITextSizeConstraint
G2L["e"] = Instance.new("UITextSizeConstraint", G2L["d"]);
G2L["e"]["MaxTextSize"] = 39;

-- StarterGui.Banking System.BACKGROUNDUI.InformationFrame.welcome.UIAspectRatioConstraint
G2L["f"] = Instance.new("UIAspectRatioConstraint", G2L["d"]);
G2L["f"]["AspectRatio"] = 3.8717949390411377;

-- StarterGui.Banking System.BACKGROUNDUI.InformationFrame.BACKGROUND UI
G2L["10"] = Instance.new("Frame", G2L["8"]);
G2L["10"]["Active"] = true;
G2L["10"]["BackgroundColor3"] = Color3.fromRGB(62, 62, 62);
G2L["10"]["Size"] = UDim2.new(0.9507604241371155, 0, 0, 0);
G2L["10"]["BorderColor3"] = Color3.fromRGB(62, 62, 62);
G2L["10"]["Position"] = UDim2.new(0.000640869140625, 0, 0.3292365074157715, 0);
G2L["10"]["Name"] = [[BACKGROUND UI]];

-- StarterGui.Banking System.BACKGROUNDUI.InformationFrame.UIAspectRatioConstraint
G2L["11"] = Instance.new("UIAspectRatioConstraint", G2L["8"]);
G2L["11"]["AspectRatio"] = 1.4721407890319824;

-- StarterGui.Banking System.BACKGROUNDUI.InformationFrame.PlayerName
G2L["12"] = Instance.new("TextLabel", G2L["8"]);
G2L["12"]["TextWrapped"] = true;
G2L["12"]["BackgroundColor3"] = Color3.fromRGB(255, 255, 255);
G2L["12"]["FontFace"] = Font.new([[rbxasset://fonts/families/GothamSSm.json]], Enum.FontWeight.Bold, Enum.FontStyle.Normal);
G2L["12"]["TextSize"] = 30;
G2L["12"]["TextColor3"] = Color3.fromRGB(255, 255, 255);
G2L["12"]["Size"] = UDim2.new(0.2990429103374481, 0, 0.11370262503623962, 0);
G2L["12"]["Text"] = [[Name]];
G2L["12"]["Name"] = [[PlayerName]];
G2L["12"]["BackgroundTransparency"] = 1;
G2L["12"]["Position"] = UDim2.new(0.4497833847999573, 0, 0.17784257233142853, 0);

-- StarterGui.Banking System.BACKGROUNDUI.InformationFrame.PlayerName.UITextSizeConstraint
G2L["13"] = Instance.new("UITextSizeConstraint", G2L["12"]);
G2L["13"]["MaxTextSize"] = 39;

-- StarterGui.Banking System.BACKGROUNDUI.InformationFrame.PlayerName.UIAspectRatioConstraint
G2L["14"] = Instance.new("UIAspectRatioConstraint", G2L["12"]);
G2L["14"]["AspectRatio"] = 3.8717949390411377;

-- StarterGui.Banking System.BACKGROUNDUI.TransactionFrame
G2L["15"] = Instance.new("Frame", G2L["2"]);
G2L["15"]["BorderSizePixel"] = 0;
G2L["15"]["BackgroundColor3"] = Color3.fromRGB(255, 255, 255);
G2L["15"]["BackgroundTransparency"] = 1;
G2L["15"]["Size"] = UDim2.new(0.7676283717155457, 0, 0.8394303917884827, 0);
G2L["15"]["Position"] = UDim2.new(0.22719334065914154, 0, 0.15769647061824799, 0);
G2L["15"]["Visible"] = false;
G2L["15"]["Name"] = [[TransactionFrame]];

-- StarterGui.Banking System.BACKGROUNDUI.TransactionFrame.TextLabel
G2L["16"] = Instance.new("TextLabel", G2L["15"]);
G2L["16"]["TextWrapped"] = true;
G2L["16"]["TextScaled"] = true;
G2L["16"]["BackgroundColor3"] = Color3.fromRGB(255, 255, 255);
G2L["16"]["FontFace"] = Font.new([[rbxasset://fonts/families/GothamSSm.json]], Enum.FontWeight.Bold, Enum.FontStyle.Normal);
G2L["16"]["TextSize"] = 14;
G2L["16"]["TextColor3"] = Color3.fromRGB(0, 0, 0);
G2L["16"]["Size"] = UDim2.new(0.9875518679618835, 0, 0.14662756025791168, 0);
G2L["16"]["Text"] = [[bypass]];
G2L["16"]["BackgroundTransparency"] = 1;

-- StarterGui.Banking System.BACKGROUNDUI.TransactionFrame.TextLabel.UITextSizeConstraint
G2L["17"] = Instance.new("UITextSizeConstraint", G2L["16"]);
G2L["17"]["MaxTextSize"] = 50;

-- StarterGui.Banking System.BACKGROUNDUI.TransactionFrame.TextLabel.LocalScript
G2L["18"] = Instance.new("LocalScript", G2L["16"]);


-- StarterGui.Banking System.BACKGROUNDUI.TransactionFrame.UIAspectRatioConstraint
G2L["19"] = Instance.new("UIAspectRatioConstraint", G2L["15"]);
G2L["19"]["AspectRatio"] = 1.4134896993637085;

-- StarterGui.Banking System.BACKGROUNDUI.TransactionFrame.textbox
G2L["1a"] = Instance.new("TextBox", G2L["15"]);
G2L["1a"]["PlaceholderColor3"] = Color3.fromRGB(255, 255, 255);
G2L["1a"]["BorderSizePixel"] = 0;
G2L["1a"]["TextSize"] = 14;
G2L["1a"]["TextWrapped"] = true;
G2L["1a"]["TextScaled"] = true;
G2L["1a"]["BackgroundColor3"] = Color3.fromRGB(31, 31, 31);
G2L["1a"]["TextColor3"] = Color3.fromRGB(255, 255, 255);
G2L["1a"]["FontFace"] = Font.new([[rbxasset://fonts/families/GothamSSm.json]], Enum.FontWeight.Bold, Enum.FontStyle.Normal);
G2L["1a"]["PlaceholderText"] = [[enter what you want to bypass here]];
G2L["1a"]["Size"] = UDim2.new(0.9854771494865417, 0, 0.14662756025791168, 0);
G2L["1a"]["BorderColor3"] = Color3.fromRGB(0, 0, 0);
G2L["1a"]["Text"] = [[]];
G2L["1a"]["Position"] = UDim2.new(1.2662896153869951e-07, 0, 0.19354838132858276, 0);
G2L["1a"]["Name"] = [[textbox]];

-- StarterGui.Banking System.BACKGROUNDUI.TransactionFrame.textbox.UIStroke
G2L["1b"] = Instance.new("UIStroke", G2L["1a"]);
G2L["1b"]["Color"] = Color3.fromRGB(255, 255, 255);
G2L["1b"]["Thickness"] = 2;
G2L["1b"]["ApplyStrokeMode"] = Enum.ApplyStrokeMode.Border;

-- StarterGui.Banking System.BACKGROUNDUI.TransactionFrame.textbox.UICorner
G2L["1c"] = Instance.new("UICorner", G2L["1a"]);


-- StarterGui.Banking System.BACKGROUNDUI.TransactionFrame.textbox.UITextSizeConstraint
G2L["1d"] = Instance.new("UITextSizeConstraint", G2L["1a"]);
G2L["1d"]["MaxTextSize"] = 14;

-- StarterGui.Banking System.BACKGROUNDUI.TransactionFrame.toggle
G2L["1e"] = Instance.new("TextButton", G2L["15"]);
G2L["1e"]["TextWrapped"] = true;
G2L["1e"]["AutoButtonColor"] = false;
G2L["1e"]["TextScaled"] = true;
G2L["1e"]["BackgroundColor3"] = Color3.fromRGB(31, 31, 31);
G2L["1e"]["TextSize"] = 14;
G2L["1e"]["FontFace"] = Font.new([[rbxasset://fonts/families/GothamSSm.json]], Enum.FontWeight.Bold, Enum.FontStyle.Normal);
G2L["1e"]["TextColor3"] = Color3.fromRGB(255, 255, 255);
G2L["1e"]["AnchorPoint"] = Vector2.new(0.5, 0.5);
G2L["1e"]["Size"] = UDim2.new(0.10409006476402283, 0, 0.1466275453567505, 0);
G2L["1e"]["Name"] = [[toggle]];
G2L["1e"]["BorderColor3"] = Color3.fromRGB(255, 255, 255);
G2L["1e"]["Text"] = [[]];
G2L["1e"]["Position"] = UDim2.new(0.49469488859176636, 0, 0.6634271144866943, 0);

-- StarterGui.Banking System.BACKGROUNDUI.TransactionFrame.toggle.UICorner
G2L["1f"] = Instance.new("UICorner", G2L["1e"]);


-- StarterGui.Banking System.BACKGROUNDUI.TransactionFrame.toggle.UIStroke
G2L["20"] = Instance.new("UIStroke", G2L["1e"]);
G2L["20"]["Color"] = Color3.fromRGB(255, 255, 255);
G2L["20"]["Thickness"] = 2;
G2L["20"]["ApplyStrokeMode"] = Enum.ApplyStrokeMode.Border;

-- StarterGui.Banking System.BACKGROUNDUI.TransactionFrame.toggle.UITextSizeConstraint
G2L["21"] = Instance.new("UITextSizeConstraint", G2L["1e"]);
G2L["21"]["MaxTextSize"] = 14;

-- StarterGui.Banking System.BACKGROUNDUI.TransactionFrame.toggle.UIAspectRatioConstraint
G2L["22"] = Instance.new("UIAspectRatioConstraint", G2L["1e"]);


-- StarterGui.Banking System.BACKGROUNDUI.TransactionFrame.BACKGROUND UI
G2L["23"] = Instance.new("Frame", G2L["15"]);
G2L["23"]["Active"] = true;
G2L["23"]["BackgroundColor3"] = Color3.fromRGB(62, 62, 62);
G2L["23"]["Size"] = UDim2.new(0.9895633459091187, 0, -0.0019595627672970295, 0);
G2L["23"]["BorderColor3"] = Color3.fromRGB(62, 62, 62);
G2L["23"]["Position"] = UDim2.new(1.2662896153869951e-07, 0, 0.1641681045293808, 0);
G2L["23"]["Name"] = [[BACKGROUND UI]];

-- StarterGui.Banking System.BACKGROUNDUI.TransactionFrame.TextLabel
G2L["24"] = Instance.new("TextLabel", G2L["15"]);
G2L["24"]["TextWrapped"] = true;
G2L["24"]["BackgroundColor3"] = Color3.fromRGB(255, 255, 255);
G2L["24"]["FontFace"] = Font.new([[rbxasset://fonts/families/GothamSSm.json]], Enum.FontWeight.Bold, Enum.FontStyle.Normal);
G2L["24"]["TextSize"] = 14;
G2L["24"]["TextColor3"] = Color3.fromRGB(255, 255, 255);
G2L["24"]["Size"] = UDim2.new(0.9875518679618835, 0, 0.14662756025791168, 0);
G2L["24"]["Text"] = [[(click twice for it to work)]];
G2L["24"]["BackgroundTransparency"] = 1;
G2L["24"]["Position"] = UDim2.new(0, 0, 0.7947214245796204, 0);

-- StarterGui.Banking System.BACKGROUNDUI.TransactionFrame.TextLabel.UITextSizeConstraint
G2L["25"] = Instance.new("UITextSizeConstraint", G2L["24"]);
G2L["25"]["MaxTextSize"] = 50;

-- StarterGui.Banking System.BACKGROUNDUI.TransactionFrame.TextLabel
G2L["26"] = Instance.new("TextLabel", G2L["15"]);
G2L["26"]["TextWrapped"] = true;
G2L["26"]["BorderSizePixel"] = 0;
G2L["26"]["TextScaled"] = true;
G2L["26"]["BackgroundColor3"] = Color3.fromRGB(255, 255, 255);
G2L["26"]["TextXAlignment"] = Enum.TextXAlignment.Right;
G2L["26"]["FontFace"] = Font.new([[rbxasset://fonts/families/GothamSSm.json]], Enum.FontWeight.Bold, Enum.FontStyle.Normal);
G2L["26"]["TextSize"] = 14;
G2L["26"]["TextColor3"] = Color3.fromRGB(255, 255, 255);
G2L["26"]["Size"] = UDim2.new(0.3473029136657715, 0, 0.10000000894069672, 0);
G2L["26"]["BorderColor3"] = Color3.fromRGB(0, 0, 0);
G2L["26"]["Text"] = [[reset filter]];
G2L["26"]["BackgroundTransparency"] = 1;
G2L["26"]["Position"] = UDim2.new(0.3209247589111328, 0, 0.3772517740726471, 0);

-- StarterGui.Banking System.BACKGROUNDUI.TransactionFrame.TextLabel.UITextSizeConstraint
G2L["27"] = Instance.new("UITextSizeConstraint", G2L["26"]);
G2L["27"]["MaxTextSize"] = 34;

-- StarterGui.Banking System.BACKGROUNDUI.TransactionFrame.TextLabel
G2L["28"] = Instance.new("TextLabel", G2L["15"]);
G2L["28"]["TextWrapped"] = true;
G2L["28"]["BorderSizePixel"] = 0;
G2L["28"]["TextScaled"] = true;
G2L["28"]["BackgroundColor3"] = Color3.fromRGB(255, 255, 255);
G2L["28"]["FontFace"] = Font.new([[rbxasset://fonts/families/GothamSSm.json]], Enum.FontWeight.Bold, Enum.FontStyle.Normal);
G2L["28"]["TextSize"] = 14;
G2L["28"]["TextColor3"] = Color3.fromRGB(255, 255, 255);
G2L["28"]["Size"] = UDim2.new(0.3473029136657715, 0, 0.10000000894069672, 0);
G2L["28"]["BorderColor3"] = Color3.fromRGB(0, 0, 0);
G2L["28"]["Text"] = [[v]];
G2L["28"]["BackgroundTransparency"] = 1;
G2L["28"]["Position"] = UDim2.new(0.3209247589111328, 0, 0.46816086769104004, 0);

-- StarterGui.Banking System.BACKGROUNDUI.TransactionFrame.TextLabel.UITextSizeConstraint
G2L["29"] = Instance.new("UITextSizeConstraint", G2L["28"]);
G2L["29"]["MaxTextSize"] = 34;

-- StarterGui.Banking System.BACKGROUNDUI.Deposit
G2L["2a"] = Instance.new("TextButton", G2L["2"]);
G2L["2a"]["TextWrapped"] = true;
G2L["2a"]["TextScaled"] = true;
G2L["2a"]["BackgroundColor3"] = Color3.fromRGB(255, 255, 255);
G2L["2a"]["TextSize"] = 13;
G2L["2a"]["FontFace"] = Font.new([[rbxasset://fonts/families/GothamSSm.json]], Enum.FontWeight.Bold, Enum.FontStyle.Normal);
G2L["2a"]["TextColor3"] = Color3.fromRGB(255, 255, 255);
G2L["2a"]["Size"] = UDim2.new(0.12011367827653885, 0, 0.056934162974357605, 0);
G2L["2a"]["Name"] = [[Deposit]];
G2L["2a"]["Text"] = [[settings]];
G2L["2a"]["Position"] = UDim2.new(0.0720125138759613, 0, 0.7203606367111206, 0);
G2L["2a"]["BackgroundTransparency"] = 1;

-- StarterGui.Banking System.BACKGROUNDUI.Deposit.UITextSizeConstraint
G2L["2b"] = Instance.new("UITextSizeConstraint", G2L["2a"]);
G2L["2b"]["MaxTextSize"] = 16;

-- StarterGui.Banking System.BACKGROUNDUI.DepositFrame
G2L["2c"] = Instance.new("Frame", G2L["2"]);
G2L["2c"]["BackgroundColor3"] = Color3.fromRGB(255, 255, 255);
G2L["2c"]["BackgroundTransparency"] = 1;
G2L["2c"]["Size"] = UDim2.new(0.799480140209198, 0, 0.8443537354469299, 0);
G2L["2c"]["Position"] = UDim2.new(0.22665418684482574, 0, 0.15147878229618073, 0);
G2L["2c"]["Visible"] = false;
G2L["2c"]["Name"] = [[DepositFrame]];

-- StarterGui.Banking System.BACKGROUNDUI.DepositFrame.Information
G2L["2d"] = Instance.new("TextLabel", G2L["2c"]);
G2L["2d"]["TextWrapped"] = true;
G2L["2d"]["BorderSizePixel"] = 0;
G2L["2d"]["TextScaled"] = true;
G2L["2d"]["BackgroundColor3"] = Color3.fromRGB(255, 255, 255);
G2L["2d"]["FontFace"] = Font.new([[rbxasset://fonts/families/GothamSSm.json]], Enum.FontWeight.Bold, Enum.FontStyle.Normal);
G2L["2d"]["TextSize"] = 14;
G2L["2d"]["TextColor3"] = Color3.fromRGB(255, 255, 255);
G2L["2d"]["Size"] = UDim2.new(0.9661354422569275, 0, 0.1574344038963318, 0);
G2L["2d"]["BorderColor3"] = Color3.fromRGB(62, 62, 62);
G2L["2d"]["Text"] = [[settings]];
G2L["2d"]["Name"] = [[Information]];
G2L["2d"]["BackgroundTransparency"] = 1;
G2L["2d"]["Position"] = UDim2.new(0, 0, 0.011661808006465435, 0);

-- StarterGui.Banking System.BACKGROUNDUI.DepositFrame.Ui
G2L["2e"] = Instance.new("Frame", G2L["2c"]);
G2L["2e"]["Active"] = true;
G2L["2e"]["BackgroundColor3"] = Color3.fromRGB(62, 62, 62);
G2L["2e"]["Size"] = UDim2.new(0.9501034021377563, 0, 0, 0);
G2L["2e"]["BorderColor3"] = Color3.fromRGB(62, 62, 62);
G2L["2e"]["Position"] = UDim2.new(0.0007095640758052468, 0, 0.1746356338262558, 0);
G2L["2e"]["Name"] = [[Ui]];

-- StarterGui.Banking System.BACKGROUNDUI.DepositFrame.UIAspectRatioConstraint
G2L["2f"] = Instance.new("UIAspectRatioConstraint", G2L["2c"]);
G2L["2f"]["AspectRatio"] = 1.4635568857192993;

-- StarterGui.Banking System.BACKGROUNDUI.DepositFrame.TextLabel
G2L["30"] = Instance.new("TextLabel", G2L["2c"]);
G2L["30"]["BorderSizePixel"] = 0;
G2L["30"]["BackgroundColor3"] = Color3.fromRGB(25, 25, 25);
G2L["30"]["FontFace"] = Font.new([[rbxasset://fonts/families/GothamSSm.json]], Enum.FontWeight.Bold, Enum.FontStyle.Normal);
G2L["30"]["TextSize"] = 14;
G2L["30"]["TextColor3"] = Color3.fromRGB(255, 255, 255);
G2L["30"]["Size"] = UDim2.new(0.9482071995735168, 0, 0.14577259123325348, 0);
G2L["30"]["BorderColor3"] = Color3.fromRGB(0, 0, 0);
G2L["30"]["Text"] = [[this is probably unfinished blame @userhater]];
G2L["30"]["Position"] = UDim2.new(0.0007095640758052468, 0, 0.19825072586536407, 0);

-- StarterGui.Banking System.BACKGROUNDUI.EXIT
G2L["31"] = Instance.new("TextButton", G2L["2"]);
G2L["31"]["TextWrapped"] = true;
G2L["31"]["TextScaled"] = true;
G2L["31"]["BackgroundColor3"] = Color3.fromRGB(255, 255, 255);
G2L["31"]["TextSize"] = 28;
G2L["31"]["FontFace"] = Font.new([[rbxasset://fonts/families/FredokaOne.json]], Enum.FontWeight.Regular, Enum.FontStyle.Normal);
G2L["31"]["TextColor3"] = Color3.fromRGB(255, 255, 255);
G2L["31"]["Size"] = UDim2.new(0.03848034515976906, 0, 0.061209987848997116, 0);
G2L["31"]["Name"] = [[EXIT]];
G2L["31"]["Text"] = [[X]];
G2L["31"]["Position"] = UDim2.new(0.9483299851417542, 0, 0.021639851853251457, 0);
G2L["31"]["BackgroundTransparency"] = 1;

-- StarterGui.Banking System.BACKGROUNDUI.EXIT.UITextSizeConstraint
G2L["32"] = Instance.new("UITextSizeConstraint", G2L["31"]);
G2L["32"]["MaxTextSize"] = 27;

-- StarterGui.Banking System.BACKGROUNDUI.WithdrawFrame
G2L["33"] = Instance.new("Frame", G2L["2"]);
G2L["33"]["BackgroundColor3"] = Color3.fromRGB(255, 255, 255);
G2L["33"]["BackgroundTransparency"] = 1;
G2L["33"]["Size"] = UDim2.new(0.799480140209198, 0, 0.8443537354469299, 0);
G2L["33"]["Position"] = UDim2.new(0.22665418684482574, 0, 0.15147878229618073, 0);
G2L["33"]["Visible"] = false;
G2L["33"]["Name"] = [[WithdrawFrame]];

-- StarterGui.Banking System.BACKGROUNDUI.WithdrawFrame.Information
G2L["34"] = Instance.new("TextLabel", G2L["33"]);
G2L["34"]["TextWrapped"] = true;
G2L["34"]["BorderSizePixel"] = 0;
G2L["34"]["TextScaled"] = true;
G2L["34"]["BackgroundColor3"] = Color3.fromRGB(255, 255, 255);
G2L["34"]["FontFace"] = Font.new([[rbxasset://fonts/families/GothamSSm.json]], Enum.FontWeight.Bold, Enum.FontStyle.Normal);
G2L["34"]["TextSize"] = 14;
G2L["34"]["TextColor3"] = Color3.fromRGB(255, 255, 255);
G2L["34"]["Size"] = UDim2.new(0.9661354422569275, 0, 0.1574344038963318, 0);
G2L["34"]["BorderColor3"] = Color3.fromRGB(62, 62, 62);
G2L["34"]["Text"] = [[credits]];
G2L["34"]["Name"] = [[Information]];
G2L["34"]["BackgroundTransparency"] = 1;
G2L["34"]["Position"] = UDim2.new(0, 0, 0.011661808006465435, 0);

-- StarterGui.Banking System.BACKGROUNDUI.WithdrawFrame.Ui
G2L["35"] = Instance.new("Frame", G2L["33"]);
G2L["35"]["Active"] = true;
G2L["35"]["BackgroundColor3"] = Color3.fromRGB(62, 62, 62);
G2L["35"]["Size"] = UDim2.new(0.9506916403770447, 0, 0, 0);
G2L["35"]["BorderColor3"] = Color3.fromRGB(62, 62, 62);
G2L["35"]["Position"] = UDim2.new(0.0007095640758052468, 0, 0.1746356338262558, 0);
G2L["35"]["Name"] = [[Ui]];

-- StarterGui.Banking System.BACKGROUNDUI.WithdrawFrame.UIAspectRatioConstraint
G2L["36"] = Instance.new("UIAspectRatioConstraint", G2L["33"]);
G2L["36"]["AspectRatio"] = 1.4635568857192993;

-- StarterGui.Banking System.BACKGROUNDUI.WithdrawFrame.TextLabel
G2L["37"] = Instance.new("TextLabel", G2L["33"]);
G2L["37"]["BorderSizePixel"] = 0;
G2L["37"]["BackgroundColor3"] = Color3.fromRGB(25, 25, 25);
G2L["37"]["FontFace"] = Font.new([[rbxasset://fonts/families/GothamSSm.json]], Enum.FontWeight.Bold, Enum.FontStyle.Normal);
G2L["37"]["TextSize"] = 14;
G2L["37"]["TextColor3"] = Color3.fromRGB(255, 255, 255);
G2L["37"]["Size"] = UDim2.new(0, 477, 0, 50);
G2L["37"]["BorderColor3"] = Color3.fromRGB(0, 0, 0);
G2L["37"]["Text"] = [[@xploits_ for ui]];
G2L["37"]["Position"] = UDim2.new(0, 0, 0.19825072586536407, 0);

-- StarterGui.Banking System.BACKGROUNDUI.WithdrawFrame.TextLabel
G2L["38"] = Instance.new("TextLabel", G2L["33"]);
G2L["38"]["BorderSizePixel"] = 0;
G2L["38"]["BackgroundColor3"] = Color3.fromRGB(25, 25, 25);
G2L["38"]["FontFace"] = Font.new([[rbxasset://fonts/families/GothamSSm.json]], Enum.FontWeight.Bold, Enum.FontStyle.Normal);
G2L["38"]["TextSize"] = 14;
G2L["38"]["TextColor3"] = Color3.fromRGB(255, 255, 255);
G2L["38"]["Size"] = UDim2.new(0, 477, 0, 50);
G2L["38"]["BorderColor3"] = Color3.fromRGB(0, 0, 0);
G2L["38"]["Text"] = [[@userhater for scripts]];
G2L["38"]["Position"] = UDim2.new(0, 0, 0.3206997215747833, 0);

-- StarterGui.Banking System.BACKGROUNDUI.Information
G2L["39"] = Instance.new("TextButton", G2L["2"]);
G2L["39"]["TextWrapped"] = true;
G2L["39"]["RichText"] = true;
G2L["39"]["TextScaled"] = true;
G2L["39"]["BackgroundColor3"] = Color3.fromRGB(255, 255, 255);
G2L["39"]["TextSize"] = 13;
G2L["39"]["FontFace"] = Font.new([[rbxasset://fonts/families/GothamSSm.json]], Enum.FontWeight.Bold, Enum.FontStyle.Normal);
G2L["39"]["TextColor3"] = Color3.fromRGB(255, 255, 255);
G2L["39"]["Size"] = UDim2.new(0.12011367827653885, 0, 0.046000078320503235, 0);
G2L["39"]["Name"] = [[Information]];
G2L["39"]["Text"] = [[info]];
G2L["39"]["Position"] = UDim2.new(0.0720125138759613, 0, 0.35953545570373535, 0);
G2L["39"]["BackgroundTransparency"] = 1;

-- StarterGui.Banking System.BACKGROUNDUI.Information.UITextSizeConstraint
G2L["3a"] = Instance.new("UITextSizeConstraint", G2L["39"]);
G2L["3a"]["MaxTextSize"] = 13;

-- StarterGui.Banking System.BACKGROUNDUI.Transactions
G2L["3b"] = Instance.new("TextButton", G2L["2"]);
G2L["3b"]["TextWrapped"] = true;
G2L["3b"]["TextScaled"] = true;
G2L["3b"]["BackgroundColor3"] = Color3.fromRGB(255, 255, 255);
G2L["3b"]["TextSize"] = 13;
G2L["3b"]["FontFace"] = Font.new([[rbxasset://fonts/families/GothamSSm.json]], Enum.FontWeight.Bold, Enum.FontStyle.Normal);
G2L["3b"]["TextColor3"] = Color3.fromRGB(255, 255, 255);
G2L["3b"]["Size"] = UDim2.new(0.11818959563970566, 0, 0.07653889805078506, 0);
G2L["3b"]["Name"] = [[Transactions]];
G2L["3b"]["Text"] = [[bypass]];
G2L["3b"]["Position"] = UDim2.new(0.0720125138759613, 0, 0.5590823292732239, 0);
G2L["3b"]["BackgroundTransparency"] = 1;

-- StarterGui.Banking System.BACKGROUNDUI.Transactions.UITextSizeConstraint
G2L["3c"] = Instance.new("UITextSizeConstraint", G2L["3b"]);
G2L["3c"]["MaxTextSize"] = 14;

-- StarterGui.Banking System.BACKGROUNDUI.Withdraw
G2L["3d"] = Instance.new("TextButton", G2L["2"]);
G2L["3d"]["TextWrapped"] = true;
G2L["3d"]["TextScaled"] = true;
G2L["3d"]["BackgroundColor3"] = Color3.fromRGB(255, 255, 255);
G2L["3d"]["TextSize"] = 13;
G2L["3d"]["FontFace"] = Font.new([[rbxasset://fonts/families/GothamSSm.json]], Enum.FontWeight.Bold, Enum.FontStyle.Normal);
G2L["3d"]["TextColor3"] = Color3.fromRGB(255, 255, 255);
G2L["3d"]["Size"] = UDim2.new(0.11818959563970566, 0, 0.056934162974357605, 0);
G2L["3d"]["Name"] = [[Withdraw]];
G2L["3d"]["Text"] = [[credits]];
G2L["3d"]["Position"] = UDim2.new(0.0720125138759613, 0, 0.878905177116394, 0);
G2L["3d"]["BackgroundTransparency"] = 1;

-- StarterGui.Banking System.BACKGROUNDUI.Withdraw.UITextSizeConstraint
G2L["3e"] = Instance.new("UITextSizeConstraint", G2L["3d"]);
G2L["3e"]["MaxTextSize"] = 16;

-- StarterGui.Banking System.BACKGROUNDUI.ACTIONS
G2L["3f"] = Instance.new("TextLabel", G2L["2"]);
G2L["3f"]["TextWrapped"] = true;
G2L["3f"]["TextScaled"] = true;
G2L["3f"]["BackgroundColor3"] = Color3.fromRGB(255, 255, 255);
G2L["3f"]["FontFace"] = Font.new([[rbxasset://fonts/families/GothamSSm.json]], Enum.FontWeight.Bold, Enum.FontStyle.Normal);
G2L["3f"]["TextSize"] = 15;
G2L["3f"]["TextColor3"] = Color3.fromRGB(48, 48, 48);
G2L["3f"]["Size"] = UDim2.new(0.30034103989601135, 0, 0.043462928384542465, 0);
G2L["3f"]["Active"] = true;
G2L["3f"]["Text"] = [[script]];
G2L["3f"]["Name"] = [[ACTIONS]];
G2L["3f"]["BackgroundTransparency"] = 1;
G2L["3f"]["Position"] = UDim2.new(-0.11330702900886536, 0, 0.2503963112831116, 0);

-- StarterGui.Banking System.BACKGROUNDUI.ACTIONS.UITextSizeConstraint
G2L["40"] = Instance.new("UITextSizeConstraint", G2L["3f"]);
G2L["40"]["MaxTextSize"] = 12;

-- StarterGui.Banking System.BACKGROUNDUI.Information Icon
G2L["41"] = Instance.new("TextLabel", G2L["2"]);
G2L["41"]["TextWrapped"] = true;
G2L["41"]["TextScaled"] = true;
G2L["41"]["BackgroundColor3"] = Color3.fromRGB(255, 255, 255);
G2L["41"]["FontFace"] = Font.new([[rbxasset://fonts/families/FredokaOne.json]], Enum.FontWeight.Regular, Enum.FontStyle.Normal);
G2L["41"]["TextSize"] = 30;
G2L["41"]["TextColor3"] = Color3.fromRGB(255, 255, 255);
G2L["41"]["Size"] = UDim2.new(0.04947468265891075, 0, 0.08426939696073532, 0);
G2L["41"]["Active"] = true;
G2L["41"]["Text"] = [[]];
G2L["41"]["Name"] = [[Information Icon]];
G2L["41"]["BackgroundTransparency"] = 1;
G2L["41"]["Position"] = UDim2.new(0.01566636562347412, 0, 0.3404008150100708, 0);

-- StarterGui.Banking System.BACKGROUNDUI.Information Icon.UITextSizeConstraint
G2L["42"] = Instance.new("UITextSizeConstraint", G2L["41"]);
G2L["42"]["MaxTextSize"] = 24;

-- StarterGui.Banking System.BACKGROUNDUI.Information Icon.fluency_icon
G2L["43"] = Instance.new("ImageLabel", G2L["41"]);
G2L["43"]["BorderSizePixel"] = 0;
G2L["43"]["ScaleType"] = Enum.ScaleType.Fit;
G2L["43"]["BackgroundColor3"] = Color3.fromRGB(255, 255, 255);
G2L["43"]["AnchorPoint"] = Vector2.new(0.5, 0.5);
G2L["43"]["Image"] = [[rbxassetid://11422155687]];
G2L["43"]["Size"] = UDim2.new(0.8691299557685852, 0, 0.9932060241699219, 0);
G2L["43"]["BorderColor3"] = Color3.fromRGB(0, 0, 0);
G2L["43"]["Name"] = [[fluency_icon]];
G2L["43"]["BackgroundTransparency"] = 1;
G2L["43"]["Position"] = UDim2.new(0.37456533312797546, 0, 0.4949858784675598, 0);

-- StarterGui.Banking System.BACKGROUNDUI.Deposit Icon
G2L["44"] = Instance.new("TextLabel", G2L["2"]);
G2L["44"]["TextWrapped"] = true;
G2L["44"]["TextScaled"] = true;
G2L["44"]["BackgroundColor3"] = Color3.fromRGB(255, 255, 255);
G2L["44"]["FontFace"] = Font.new([[rbxasset://fonts/families/FredokaOne.json]], Enum.FontWeight.Regular, Enum.FontStyle.Normal);
G2L["44"]["TextSize"] = 30;
G2L["44"]["TextColor3"] = Color3.fromRGB(255, 255, 255);
G2L["44"]["Size"] = UDim2.new(0.05483187735080719, 0, 0.08426939696073532, 0);
G2L["44"]["Active"] = true;
G2L["44"]["Text"] = [[]];
G2L["44"]["Name"] = [[Deposit Icon]];
G2L["44"]["BackgroundTransparency"] = 1;
G2L["44"]["Position"] = UDim2.new(0.010309251956641674, 0, 0.7066932320594788, 0);

-- StarterGui.Banking System.BACKGROUNDUI.Deposit Icon.UITextSizeConstraint
G2L["45"] = Instance.new("UITextSizeConstraint", G2L["44"]);
G2L["45"]["MaxTextSize"] = 24;

-- StarterGui.Banking System.BACKGROUNDUI.Deposit Icon.fluency_icon
G2L["46"] = Instance.new("ImageLabel", G2L["44"]);
G2L["46"]["BorderSizePixel"] = 0;
G2L["46"]["ScaleType"] = Enum.ScaleType.Fit;
G2L["46"]["BackgroundColor3"] = Color3.fromRGB(255, 255, 255);
G2L["46"]["AnchorPoint"] = Vector2.new(0.5, 0.5);
G2L["46"]["Image"] = [[rbxassetid://11293977610]];
G2L["46"]["Size"] = UDim2.new(0.7842140793800354, 0, 0.9932060241699219, 0);
G2L["46"]["BorderColor3"] = Color3.fromRGB(0, 0, 0);
G2L["46"]["Name"] = [[fluency_icon]];
G2L["46"]["BackgroundTransparency"] = 1;
G2L["46"]["Position"] = UDim2.new(0.396933376789093, 0, 0.49121224880218506, 0);

-- StarterGui.Banking System.BACKGROUNDUI.NAME
G2L["47"] = Instance.new("TextLabel", G2L["2"]);
G2L["47"]["TextWrapped"] = true;
G2L["47"]["TextScaled"] = true;
G2L["47"]["BackgroundColor3"] = Color3.fromRGB(255, 255, 255);
G2L["47"]["FontFace"] = Font.new([[rbxasset://fonts/families/GothamSSm.json]], Enum.FontWeight.Bold, Enum.FontStyle.Normal);
G2L["47"]["TextSize"] = 33;
G2L["47"]["TextColor3"] = Color3.fromRGB(255, 255, 255);
G2L["47"]["Size"] = UDim2.new(0.192401722073555, 0, 0.06806469708681107, 0);
G2L["47"]["Active"] = true;
G2L["47"]["BorderColor3"] = Color3.fromRGB(28, 43, 54);
G2L["47"]["Text"] = [[K I L L E R]];
G2L["47"]["Name"] = [[NAME]];
G2L["47"]["BackgroundTransparency"] = 1;
G2L["47"]["Position"] = UDim2.new(0.008935213088989258, 0, 0.11819976568222046, 0);

-- StarterGui.Banking System.BACKGROUNDUI.NAME.UITextSizeConstraint
G2L["48"] = Instance.new("UITextSizeConstraint", G2L["47"]);
G2L["48"]["MaxTextSize"] = 19;

-- StarterGui.Banking System.BACKGROUNDUI.NAME
G2L["49"] = Instance.new("TextLabel", G2L["2"]);
G2L["49"]["TextWrapped"] = true;
G2L["49"]["TextScaled"] = true;
G2L["49"]["BackgroundColor3"] = Color3.fromRGB(255, 255, 255);
G2L["49"]["FontFace"] = Font.new([[rbxasset://fonts/families/GothamSSm.json]], Enum.FontWeight.Bold, Enum.FontStyle.Normal);
G2L["49"]["TextSize"] = 35;
G2L["49"]["TextColor3"] = Color3.fromRGB(0, 0, 0);
G2L["49"]["Size"] = UDim2.new(0.192401722073555, 0, 0.10360050201416016, 0);
G2L["49"]["Active"] = true;
G2L["49"]["BorderColor3"] = Color3.fromRGB(28, 43, 54);
G2L["49"]["Text"] = [[filter]];
G2L["49"]["Name"] = [[NAME]];
G2L["49"]["BackgroundTransparency"] = 1;
G2L["49"]["Position"] = UDim2.new(0.01030915230512619, 0, 0.038927529007196426, 0);

-- StarterGui.Banking System.BACKGROUNDUI.NAME.UITextSizeConstraint
G2L["4a"] = Instance.new("UITextSizeConstraint", G2L["49"]);
G2L["4a"]["MaxTextSize"] = 29;

-- StarterGui.Banking System.BACKGROUNDUI.NAME.LocalScript
G2L["4b"] = Instance.new("LocalScript", G2L["49"]);


-- StarterGui.Banking System.BACKGROUNDUI.Transaction Icon
G2L["4c"] = Instance.new("TextLabel", G2L["2"]);
G2L["4c"]["TextWrapped"] = true;
G2L["4c"]["TextScaled"] = true;
G2L["4c"]["BackgroundColor3"] = Color3.fromRGB(255, 255, 255);
G2L["4c"]["FontFace"] = Font.new([[rbxasset://fonts/families/FredokaOne.json]], Enum.FontWeight.Regular, Enum.FontStyle.Normal);
G2L["4c"]["TextSize"] = 30;
G2L["4c"]["TextColor3"] = Color3.fromRGB(255, 255, 255);
G2L["4c"]["Size"] = UDim2.new(0.04947468265891075, 0, 0.08426939696073532, 0);
G2L["4c"]["Active"] = true;
G2L["4c"]["Text"] = [[]];
G2L["4c"]["Name"] = [[Transaction Icon]];
G2L["4c"]["BackgroundTransparency"] = 1;
G2L["4c"]["Position"] = UDim2.new(0.01566636562347412, 0, 0.5508822202682495, 0);

-- StarterGui.Banking System.BACKGROUNDUI.Transaction Icon.UITextSizeConstraint
G2L["4d"] = Instance.new("UITextSizeConstraint", G2L["4c"]);
G2L["4d"]["MaxTextSize"] = 24;

-- StarterGui.Banking System.BACKGROUNDUI.Transaction Icon.fluency_icon
G2L["4e"] = Instance.new("ImageLabel", G2L["4c"]);
G2L["4e"]["BorderSizePixel"] = 0;
G2L["4e"]["ScaleType"] = Enum.ScaleType.Fit;
G2L["4e"]["BackgroundColor3"] = Color3.fromRGB(255, 255, 255);
G2L["4e"]["AnchorPoint"] = Vector2.new(0.5, 0.5);
G2L["4e"]["Image"] = [[rbxassetid://12974469797]];
G2L["4e"]["Size"] = UDim2.new(0.8047499656677246, 0, 0.9932060241699219, 0);
G2L["4e"]["BorderColor3"] = Color3.fromRGB(0, 0, 0);
G2L["4e"]["Name"] = [[fluency_icon]];
G2L["4e"]["BackgroundTransparency"] = 1;
G2L["4e"]["Position"] = UDim2.new(0.3798975944519043, 0, 0.4999995529651642, 0);

-- StarterGui.Banking System.BACKGROUNDUI.Withdraw Icon
G2L["4f"] = Instance.new("TextLabel", G2L["2"]);
G2L["4f"]["TextWrapped"] = true;
G2L["4f"]["TextScaled"] = true;
G2L["4f"]["BackgroundColor3"] = Color3.fromRGB(255, 255, 255);
G2L["4f"]["FontFace"] = Font.new([[rbxasset://fonts/families/FredokaOne.json]], Enum.FontWeight.Regular, Enum.FontStyle.Normal);
G2L["4f"]["TextSize"] = 30;
G2L["4f"]["TextColor3"] = Color3.fromRGB(255, 255, 255);
G2L["4f"]["Size"] = UDim2.new(0.04947468265891075, 0, 0.08426939696073532, 0);
G2L["4f"]["Active"] = true;
G2L["4f"]["Text"] = [[]];
G2L["4f"]["Name"] = [[Withdraw Icon]];
G2L["4f"]["BackgroundTransparency"] = 1;
G2L["4f"]["Position"] = UDim2.new(0.014936983585357666, 0, 0.8640705347061157, 0);

-- StarterGui.Banking System.BACKGROUNDUI.Withdraw Icon.UITextSizeConstraint
G2L["50"] = Instance.new("UITextSizeConstraint", G2L["4f"]);
G2L["50"]["MaxTextSize"] = 24;

-- StarterGui.Banking System.BACKGROUNDUI.Withdraw Icon.fluency_icon
G2L["51"] = Instance.new("ImageLabel", G2L["4f"]);
G2L["51"]["BorderSizePixel"] = 0;
G2L["51"]["ScaleType"] = Enum.ScaleType.Fit;
G2L["51"]["BackgroundColor3"] = Color3.fromRGB(255, 255, 255);
G2L["51"]["AnchorPoint"] = Vector2.new(0.5, 0.5);
G2L["51"]["Image"] = [[rbxassetid://12974250071]];
G2L["51"]["Size"] = UDim2.new(0.9013199806213379, 0, 0.9932060241699219, 0);
G2L["51"]["BorderColor3"] = Color3.fromRGB(0, 0, 0);
G2L["51"]["Name"] = [[fluency_icon]];
G2L["51"]["BackgroundTransparency"] = 1;
G2L["51"]["Position"] = UDim2.new(0.36129215359687805, 0, 0.4986855089664459, 0);

-- StarterGui.Banking System.BACKGROUNDUI.Ui
G2L["52"] = Instance.new("Frame", G2L["2"]);
G2L["52"]["Active"] = true;
G2L["52"]["BorderSizePixel"] = 0;
G2L["52"]["BackgroundColor3"] = Color3.fromRGB(62, 62, 62);
G2L["52"]["Size"] = UDim2.new(0.19782601296901703, 0, 0.005748901516199112, 0);
G2L["52"]["BorderColor3"] = Color3.fromRGB(72, 72, 72);
G2L["52"]["Position"] = UDim2.new(0.0059067499823868275, 0, 0.48809805512428284, 0);
G2L["52"]["Name"] = [[Ui]];

-- StarterGui.Banking System.BACKGROUNDUI.LocalScript
G2L["53"] = Instance.new("LocalScript", G2L["2"]);


-- StarterGui.Banking System.BACKGROUNDUI.BACKGROUND UI
G2L["54"] = Instance.new("Frame", G2L["2"]);
G2L["54"]["Active"] = true;
G2L["54"]["BackgroundColor3"] = Color3.fromRGB(62, 62, 62);
G2L["54"]["Size"] = UDim2.new(0.7599999904632568, 0, -0, 0);
G2L["54"]["BorderColor3"] = Color3.fromRGB(62, 62, 62);
G2L["54"]["Position"] = UDim2.new(0.2271934449672699, 0, 0.1370522528886795, 0);
G2L["54"]["Name"] = [[BACKGROUND UI]];

-- StarterGui.Banking System.reset popup
G2L["55"] = Instance.new("Frame", G2L["1"]);
G2L["55"]["BorderSizePixel"] = 0;
G2L["55"]["BackgroundColor3"] = Color3.fromRGB(25, 25, 25);
G2L["55"]["AnchorPoint"] = Vector2.new(0.5, 0.5);
G2L["55"]["Size"] = UDim2.new(0.30000004172325134, 0, 0.06365915387868881, 0);
G2L["55"]["BorderColor3"] = Color3.fromRGB(0, 0, 0);
G2L["55"]["Position"] = UDim2.new(0.5, 0, -0.20000000298023224, 0);
G2L["55"]["Name"] = [[reset popup]];

-- StarterGui.Banking System.reset popup.TextLabel
G2L["56"] = Instance.new("TextLabel", G2L["55"]);
G2L["56"]["TextWrapped"] = true;
G2L["56"]["BorderSizePixel"] = 0;
G2L["56"]["TextScaled"] = true;
G2L["56"]["BackgroundColor3"] = Color3.fromRGB(255, 255, 255);
G2L["56"]["FontFace"] = Font.new([[rbxasset://fonts/families/GothamSSm.json]], Enum.FontWeight.Bold, Enum.FontStyle.Normal);
G2L["56"]["TextSize"] = 14;
G2L["56"]["TextColor3"] = Color3.fromRGB(255, 255, 255);
G2L["56"]["Size"] = UDim2.new(1, 0, 1, 0);
G2L["56"]["BorderColor3"] = Color3.fromRGB(0, 0, 0);
G2L["56"]["Text"] = [[Filter Reset!]];
G2L["56"]["BackgroundTransparency"] = 1;

-- StarterGui.Banking System.reset popup.TextLabel.UITextSizeConstraint
G2L["57"] = Instance.new("UITextSizeConstraint", G2L["56"]);
G2L["57"]["MaxTextSize"] = 14;

-- StarterGui.Banking System.BACKGROUNDUI.InformationFrame.LocalScript
local function C_c()
local script = G2L["c"];
	local frame = script.Parent
	
	
	
	local player = game.Players.LocalPlayer
	
	
	
	local userId = player.UserId
	
	local thumbType = Enum.ThumbnailType.AvatarBust
	
	local thumbSize = Enum.ThumbnailSize.Size420x420
	
	local content, isReady = game.Players:GetUserThumbnailAsync(userId, thumbType, thumbSize)
	
	
	
	
	
	frame.PlayerImage.Image = content
	
	frame.PlayerName.Text = player.Name
	
end;
task.spawn(C_c);
-- StarterGui.Banking System.BACKGROUNDUI.TransactionFrame.TextLabel.LocalScript
local function C_18()
local script = G2L["18"];
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
end;
task.spawn(C_18);
-- StarterGui.Banking System.BACKGROUNDUI.NAME.LocalScript
local function C_4b()
local script = G2L["4b"];
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
end;
task.spawn(C_4b);
-- StarterGui.Banking System.BACKGROUNDUI.LocalScript
local function C_53()
local script = G2L["53"];
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
	
	local RNG = function(Length)
		local Chars = {}
		for i=97,122 do Chars[#Chars+1]=string.char(i) end
		for i=65,90 do Chars[#Chars+1]=string.char(i) end
	
		local Str = ""
		for i = 1, Length do
			Str = Str .. Chars[math.random(#Chars)]
		end
		return Str
	end
	
	local resetfilter = function()
		task.spawn(function()
			if tcs.ChatVersion == Enum.ChatVersion.TextChatService then
				local Channel = tcs.TextChannels.RBXGeneral
				for i = 1, 5 do
					Channel:SendAsync("/e " .. RNG(i) .. " filter reset")
				end
			else
				for i = 1, 5 do
					plrs:Chat(RNG(i) .. " filter reset")
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
end;
task.spawn(C_53);

return G2L["1"], require;
