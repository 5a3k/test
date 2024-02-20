local library = loadstring(game:HttpGet("https://raw.githubusercontent.com/bloodball/-back-ups-for-libs/main/turtle"))()
local window = library:Window("Chat Hax V3 by @userhater")

players = game:GetService("Players")
tcs = game:GetService("TextChatService")
rstorage = game:GetService("ReplicatedStorage")

local isLegacy = (tcs.ChatVersion == Enum.ChatVersion.LegacyChatService)
local channel = not isLegacy and tcs.TextChannels.RBXGeneral or nil
local remote = isLegacy and rstorage:FindFirstChild("SayMessageRequest", true)

local fake = function(msg)
	if isLegacy then
		players:Chat(msg)
	else
		task.spawn(function()
			channel:SendAsync(("/e %s"):format(msg))
		end)
	end
end

local chat = function(msg)
	if isLegacy then
		remote:FireServer(msg, "All")
	else
		task.spawn(function()
			channel:SendAsync(msg)
		end)
	end
end

local rng = function(length)
    local chars = {}
    for i=97,122 do chars[#chars+1]=string.char(i) end
    for i=65,90 do chars[#chars+1]=string.char(i) end
    
    local str = ""
    for i = 1, length do
        str = str .. chars[math.random(#chars)]
    end
    return str
end

window:Box("Number Bypass", function(text, focuslost)
	if focuslost then
		fake(rng(3) .. " roblox.com.library.")
		wait(0.1)
		chat(text)
	end
end)

window:Box("Hitler Bypass", function(text, focuslost)
	if focuslost then
		fake(rng(8) .. " i hate ")
		wait(0.1)
		chat(text)
	end
end)

window:Box("Filter Reset", function(text, focuslost)
	if focuslost then
		for i = 1, 10 do fake(rng(i) .. " es un gran memento") end
		chat(text)
	end
end)

local letters = {
    ["a"] = {
        "⬛🔲⬛",
        "🔲⬛🔲",
        "🔲🔲🔲",
        "🔲⬛🔲",
        "🔲⬛🔲"
    },
    ["b"] = {
        "🔲🔲⬛",
        "🔲⬛🔲",
        "🔲🔲⬛",
        "🔲⬛🔲",
        "🔲🔲⬛"
    },
    ["c"] = {
        "🔲🔲🔲",
        "🔲⬛⬛",
        "🔲⬛⬛",
        "🔲⬛⬛",
        "🔲🔲🔲"
    },
    ["d"] = {
        "🔲🔲⬛",
        "🔲⬛🔲",
        "🔲⬛🔲",
        "🔲⬛🔲",
        "🔲🔲⬛"
    },
    ["e"] = {
        "🔲🔲🔲",
        "🔲⬛⬛",
        "🔲🔲🔲",
        "🔲⬛⬛",
        "🔲🔲🔲"
    },
    ["f"] = {
        "🔲🔲🔲",
        "🔲⬛⬛",
        "🔲🔲🔲",
        "🔲⬛⬛",
        "🔲⬛⬛"
    },
    ["g"] = {
        "🔲🔲🔲",
        "🔲⬛⬛",
        "🔲⬛⬛",
        "🔲⬛🔲",
        "🔲🔲🔲"
    },
    ["h"] = {
        "🔲⬛🔲",
        "🔲⬛🔲",
        "🔲🔲🔲",
        "🔲⬛🔲",
        "🔲⬛🔲"
    },
    ["i"] = {
        "🔲🔲🔲",
        "⬛🔲⬛",
        "⬛🔲⬛",
        "⬛🔲⬛",
        "🔲🔲🔲"
    },
    ["j"] = {
        "🔲🔲🔲",
        "⬛🔲⬛",
        "⬛🔲⬛",
        "⬛🔲⬛",
        "🔲⬛⬛"
    },
    ["k"] = {
        "🔲⬛🔲",
        "🔲⬛🔲",
        "🔲🔲⬛",
        "🔲⬛🔲",
        "🔲⬛🔲"
    },
    ["l"] = {
        "🔲⬛⬛",
        "🔲⬛⬛",
        "🔲⬛⬛",
        "🔲⬛⬛",
        "🔲🔲🔲"
    },
    ["m"] = {
        "🔲⬛⬛⬛🔲",
        "🔲🔲⬛🔲🔲",
        "🔲⬛🔲⬛🔲",
        "🔲⬛⬛⬛🔲",
        "🔲⬛⬛⬛🔲"
    },
    ["n"] = {
        "🔲⬛⬛🔲",
        "🔲🔲⬛🔲",
        "🔲⬛🔲🔲",
        "🔲⬛⬛🔲",
        "🔲⬛⬛🔲"
    },
    ["o"] = {
        "🔲🔲🔲",
        "🔲⬛🔲",
        "🔲⬛🔲",
        "🔲⬛🔲",
        "🔲🔲🔲"
    },
    ["p"] = {
        "🔲🔲🔲",
        "🔲⬛🔲",
        "🔲🔲🔲",
        "🔲⬛⬛",
        "🔲⬛⬛"
    },
    ["q"] = {
        "🔲🔲🔲",
        "🔲⬛🔲",
        "🔲⬛🔲",
        "🔲⬛🔲",
        "⬛🔲🔲"
    },
    ["r"] = {
        "🔲🔲🔲",
        "🔲⬛🔲",
        "🔲🔲🔲",
        "🔲🔲⬛",
        "🔲⬛🔲"
    },
    ["s"] = {
        "⬛🔲🔲",
        "🔲⬛⬛",
        "⬛🔲⬛",
        "⬛⬛🔲",
        "🔲🔲⬛"
    },
    ["t"] = {
        "🔲🔲🔲",
        "⬛🔲⬛",
        "⬛🔲⬛",
        "⬛🔲⬛",
        "⬛🔲⬛"
    },
    ["u"] = {
        "🔲⬛🔲",
        "🔲⬛🔲",
        "🔲⬛🔲",
        "🔲⬛🔲",
        "🔲🔲🔲"
    },
    ["v"] = {
        "🔲⬛🔲",
        "🔲⬛🔲",
        "🔲⬛🔲",
        "🔲⬛🔲",
        "⬛🔲⬛"
    },
    ["w"] = {
        "🔲⬛⬛⬛🔲",
        "🔲⬛⬛⬛🔲",
        "🔲⬛🔲⬛🔲",
        "🔲🔲⬛🔲🔲",
        "🔲⬛⬛⬛🔲"
    },
    ["x"] = {
        "🔲⬛🔲",
        "🔲⬛🔲",
        "⬛🔲⬛",
        "🔲⬛🔲",
        "🔲⬛🔲"
    },
    ["y"] = {
        "🔲⬛🔲",
        "🔲⬛🔲",
        "🔲⬛🔲",
        "⬛🔲⬛",
        "⬛🔲⬛"
    },
    ["z"] = {
        "🔲🔲🔲",
        "⬛⬛🔲",
        "⬛🔲⬛",
        "🔲⬛⬛",
        "🔲🔲🔲"
    },
    [" "] = {
        "⬛⬛⬛",
        "⬛⬛⬛",
        "⬛⬛⬛",
        "⬛⬛⬛",
        "⬛⬛⬛"
    },
    ["?"] = {
        "🔲🔲🔲",
        "⬛⬛🔲",
        "⬛🔲🔲",
        "⬛⬛⬛",
        "⬛🔲⬛"
    }
}

window:Box("Big Letters", function(text, focuslost)
	if focuslost then
		local comb = {"⬛", "⬛", "⬛", "⬛", "⬛"}
		for _, l in next, text:split("") do
			local found = letters[l]
			if found then
				for x = 1, 5 do
					comb[x] = comb[x] .. found[x] .. "⬛"
				end
			end
		end
		for _, line in next, comb do
			chat(line)
		end
	end
end)

window:Button("Chat Error", function()
	for i = 1, 3 do
		chat(" ")
	end
end)

window:Button("Wide Bubblechat", function()
	chat(" ৌৌৌৌৌৌৌৌৌৌৌৌৌৌৌৌৌৌৌৌৌৌৌৌৌৌৌৌৌৌৌৌৌৌৌৌৌৌৌৌৌৌৌৌৌৌৌৌৌৌৌৌৌৌৌৌৌৌৌৌৌৌৌৌৌৌৌৌৌৌৌৌৌৌৌৌৌৌৌৌৌৌৌৌৌৌৌৌৌৌৌৌৌৌৌৌৌৌৌৌৌৌৌৌৌৌৌৌৌৌৌৌৌৌৌৌৌৌৌৌৌৌৌৌৌৌৌৌৌৌৌৌৌৌৌৌৌৌৌৌৌৌৌৌৌৌৌৌৌৌৌৌৌৌৌৌৌৌৌৌৌৌৌৌৌৌৌৌৌৌৌৌৌৌৌৌৌৌৌৌৌৌৌৌৌৌৌৌৌৌৌৌৌৌৌৌৌৌৌ")
end)
