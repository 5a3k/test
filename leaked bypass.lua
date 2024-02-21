--fuck the owner who forces ppl to chat w/ credits LOL leaking yo shit
local Chat = game:GetService("TextChatService")
local ChatBar = game:GetService("CoreGui"):FindFirstChild("TextBoxContainer", true) or game:GetService("Players").LocalPlayer.PlayerGui:FindFirstChild("Chat"):FindFirstChild("ChatBar", true)
ChatBar = ChatBar:FindFirstChild("TextBox") or ChatBar

local bypass = {
    ["A"] = "А",
    ["a"] = "а",
    ["B"] = "В",
    ["C"] = "С",
    ["c"] = "с",
    ["E"] = "Е",
    ["e"] = "е",
    ["H"] = "Н",
    ["h"] = "һ",
    ["I"] = "І",
    ["i"] = "і",
    ["J"] = "Ј",
    ["j"] = "ј",
    ["l"] = "ӏ",
    ["M"] = "М",
    ["O"] = "О",
    ["o"] = "о",
    ["P"] = "Р",
    ["p"] = "р",
    ["S"] = "Ѕ",
    ["s"] = "ѕ",
    ["T"] = "Т",
    ["V"] = "Ѵ",
    ["v"] = "ν",
    ["X"] = "Х",
    ["x"] = "х",
    ["Y"] = "Υ",
    ["y"] = "у",
    ["Z"] = "Ζ",
}

local function Gen(Message, Invis)
    local new = ""
    for _, letter in next, Message:split("") do
        if bypass[letter] then
            new = new .. bypass[letter]
        else
            new = new .. letter
        end
        if Invis then new = new .. string.rep("⁥", 5) end
    end
    return new
end

local Connection = Instance.new("BindableFunction")

for _, c in next, getconnections(ChatBar.FocusLost) do
    c:Disconnect()
end

ChatBar.FocusLost:Connect(function(enterPressed)
    if enterPressed then
        Connection:Invoke(ChatBar.Text)
        ChatBar.Text = ""
    end
end)

Connection.OnInvoke = function(Message)
    Message = " ̌̌̌  ॓᳚॓     ̌̌̌  ᳚᳚᳚ť" .. Gen(Message)
    if Chat.ChatVersion == Enum.ChatVersion.LegacyChatService then
        local Remote = game:GetService("ReplicatedStorage"):FindFirstChild("SayMessageRequest", true)
        Remote:FireServer(Message, "All")
    else
        local Channel = game:GetService("TextChatService").TextChannels.RBXGeneral
        Channel:SendAsync(Message)
    end
end
