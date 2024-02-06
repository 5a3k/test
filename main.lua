local bypass = {
    -- Your character replacement mapping
}

local TCS = game:GetService("TextChatService")
local LocalPlayer = game:GetService("Players").LocalPlayer
local Channel = TCS.TextChannels.RBXGeneral

local function gen(txt)
    local new = ""
    for _, letter in next, txt:split("") do
        if bypass[letter] then
            new = new .. bypass[letter]
        else
            new = new .. letter
        end
    end
    return new
end

local Old = nil
TCS.OnIncomingMessage = function(msg)
    local Owner = tostring(msg.TextSource)
    local Prop = Instance.new("TextChatMessageProperties")

    if Owner == LocalPlayer.Name and not Old then
        Old = gen(msg.Text)
        Prop.Text = " "
    else
        Prop.Text = msg.Text
    end

    return Prop
end

TCS.MessageReceived:Connect(function(msg)
    local Owner = tostring(msg.TextSource)
    if Owner == LocalPlayer.Name and Old then
        Channel:SendAsync(Old)
        Old = nil
    end
end)
