local library = loadstring(game:HttpGet("https://raw.githubusercontent.com/bloodball/-back-ups-for-libs/main/turtle"))()
local window = library:Window("Chat Hax V3 by @userhater")

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

local function gen(Message, Invis)
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
		wait(0.2)
		chat(text)
	end
end)

window:Box("Hitler Bypass", function(text, focuslost)
	if focuslost then
		fake(rng(8) .. " i hate ")
		wait(0.2)
		chat(text)
	end
end)

window:Box("Filter Reset", function(text, focuslost)
	if focuslost then
		for i = 1, 10 do fake(rng(i) .. " es un gran memento") end
		wait(0.2)
		chat(text)
	end
end)

window:Box("Leaked Bypass #1", function(text, focuslost)
	if focuslost then
		chat(" ̌̌̌  ॓᳚॓     ̌̌̌  ᳚᳚᳚ť" .. gen(text))
	end
end)

window:Box("Leaked Bypass #2", function(text, focuslost)
	if focuslost then
		chat("SLU#T" .. gen(text:gsub(" ", ""), true))
	end
end)

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
			wait()
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
