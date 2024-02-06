local bypass = {
    ["a"] = "а",
    ["b"] = "b",
    ["c"] = "с",
    ["d"] = "d",
    ["e"] = "е",
    ["f"] = "f",
    ["g"] = "g",
    ["h"] = "һ",
    ["i"] = "і",
    ["j"] = "ј",
    ["k"] = "k",
    ["l"] = "ӏ",
    ["m"] = "m",
    ["n"] = "n",
    ["o"] = "о",
    ["p"] = "р",
    ["q"] = "q",
    ["r"] = "r",
    ["s"] = "ѕ",
    ["t"] = "t",
    ["u"] = "u",
    ["v"] = "v",
    ["w"] = "w",
    ["x"] = "х",
    ["y"] = "у",
    ["z"] = "z",
}

local TCS = game:GetService("TextChatService")
local LocalPlayer = game:GetService("Players").LocalPlayer
local Channel = TCS.TextChannels.RBXGeneral

local function gen(txt)
    local new = ""
    for _,letter in next, txt:split("") do
        if bypass[letter] then
            new = new .. bypass[letter]
        else
            new = new .. letter
        end
    end
    return new
end

TCS.OnIncomingMessage = function(msg)
    local Owner = tostring(msg.TextSource)
    local Prop = Instance.new("TextChatMessageProperties")
    if Owner == LocalPlayer.Name then
        Prop.Text = gen(msg.Text)
    else
        --Prop.Text = msg.Text
        return
    end
    print(Prop.Text)
    return Prop
end

TCS.MessageReceived:Connect(function(msg)
    local Owner = tostring(msg.TextSource)
    if Owner == LocalPlayer.Name then
        print(msg.Text)
        Channel:SendAsync(msg.Text)
    end
end)
