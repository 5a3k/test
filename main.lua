local fake_module_scripts = {}

do -- nil.ChatMain
	local script = Instance.new('ModuleScript', game:GetService("Chat"))
	script.Name = "ChatMain"
	local chatmain = script
	local function module_script()
		--!nonstrict
		
		--	// FileName: ChatMain.lua
		--	// Written by: Xsitsu
		--	// Description: Main module to handle initializing chat window UI and hooking up events to individual UI pieces.
		
		local moduleApiTable = {}
		moduleApiTable.Visible = nil
		moduleApiTable.IsCoreGuiEnabled = nil
		moduleApiTable.TopbarEnabled = nil
		moduleApiTable.VisibilityStateChanged = nil
		
		--// This section of code waits until all of the necessary RemoteEvents are found in EventFolder.
		--// I have to do some weird stuff since people could potentially already have pre-existing
		--// things in a folder with the same name, and they may have different class types.
		--// I do the useEvents thing and set EventFolder to useEvents so I can have a pseudo folder that
		--// the rest of the code can interface with and have the guarantee that the RemoteEvents they want
		--// exist with their desired names.
		
		local FFlagUserHandleChatHotKeyWithContextActionService = false do
			local ok, value = pcall(function()
				return UserSettings():IsUserFeatureEnabled("UserHandleChatHotKeyWithContextActionService")
			end)
			if ok then
				FFlagUserHandleChatHotKeyWithContextActionService = value
			end
		end
		
		local FFlagUserHandleFriendJoinNotifierOnClient = false
		do
			local success, value = pcall(function()
				return UserSettings():IsUserFeatureEnabled("UserHandleFriendJoinNotifierOnClient")
			end)
			if success then
				FFlagUserHandleFriendJoinNotifierOnClient = value
			end
		end
		
		local FFlagUserIsChatTranslationEnabled = false
		do
			local success, value = pcall(function()
				return UserSettings():IsUserFeatureEnabled("UserIsChatTranslationEnabled2")
			end)
			FFlagUserIsChatTranslationEnabled = success and value
		end
		
		local FFlagUserAddBetterConsoleCheckForLegacyChat do
			local success, result = pcall(function()
				return UserSettings():IsUserFeatureEnabled("UserAddBetterConsoleCheckForLegacyChat")
			end)
			FFlagUserAddBetterConsoleCheckForLegacyChat = success and result
		end
		
		local FILTER_MESSAGE_TIMEOUT = 60
		
		local RunService = game:GetService("RunService")
		local ReplicatedStorage = game:GetService("ReplicatedStorage")
		local Chat = game:GetService("Chat")
		local StarterGui = game:GetService("StarterGui")
		local ContextActionService = game:GetService("ContextActionService")
		
		local DefaultChatSystemChatEvents = ReplicatedStorage:WaitForChild("DefaultChatSystemChatEvents")
		local EventFolder = ReplicatedStorage:WaitForChild("DefaultChatSystemChatEvents")
		local clientChatModules = Chat:WaitForChild("ClientChatModules")
		local ChatConstants = require(clientChatModules:WaitForChild("ChatConstants"))
		local ChatSettings = require(clientChatModules:WaitForChild("ChatSettings"))
		local messageCreatorModules = clientChatModules:WaitForChild("MessageCreatorModules")
		local MessageCreatorUtil = require(messageCreatorModules:WaitForChild("Util"))
		
		local ChatLocalization = nil
		-- ROBLOX FIXME: Can we define ClientChatModules statically in the project config
		pcall(function() ChatLocalization = require((game:GetService("Chat") :: any).ClientChatModules.ChatLocalization :: any) end)
		if ChatLocalization == nil then ChatLocalization = {} function ChatLocalization:Get(key,default) return default end end
		
		local chatTranslationEnabled = nil
		if FFlagUserIsChatTranslationEnabled then
			chatTranslationEnabled = script:FindFirstChild("ChatTranslationEnabled")
			if chatTranslationEnabled == nil then
				local chatTranslationSettingSignal
				chatTranslationSettingSignal = script.ChildAdded:Connect(function(child)
					if child.Name == "ChatTranslationEnabled" then
						chatTranslationEnabled = child
		
						chatTranslationSettingSignal:Disconnect()
					end
				end)
			end
		end
		
		local numChildrenRemaining = 10 -- #waitChildren returns 0 because it's a dictionary
		local waitChildren = {
			OnNewMessage = "RemoteEvent",
			OnMessageDoneFiltering = "RemoteEvent",
			OnNewSystemMessage = "RemoteEvent",
			OnChannelJoined = "RemoteEvent",
			OnChannelLeft = "RemoteEvent",
			OnMuted = "RemoteEvent",
			OnUnmuted = "RemoteEvent",
			OnMainChannelSet = "RemoteEvent",
		
			SayMessageRequest = "RemoteEvent",
			GetInitDataRequest = "RemoteFunction",
		}
		
		-- waitChildren/EventFolder does not contain all the remote events, because the server version could be older than the client version.
		-- In that case it would not create the new events.
		-- These events are accessed directly from DefaultChatSystemChatEvents
		
		local useEvents = {}
		
		local FoundAllEventsEvent = Instance.new("BindableEvent")
		
		function TryRemoveChildWithVerifyingIsCorrectType(child)
			if (waitChildren[child.Name] and child:IsA(waitChildren[child.Name])) then
				waitChildren[child.Name] = nil
				useEvents[child.Name] = child
				numChildrenRemaining = numChildrenRemaining - 1
			end
		end
		
		for i, child in pairs(EventFolder:GetChildren()) do
			TryRemoveChildWithVerifyingIsCorrectType(child)
		end
		
		if (numChildrenRemaining > 0) then
			local con = EventFolder.ChildAdded:connect(function(child)
				TryRemoveChildWithVerifyingIsCorrectType(child)
				if (numChildrenRemaining < 1) then
					FoundAllEventsEvent:Fire()
				end
			end)
		
			FoundAllEventsEvent.Event:wait()
			con:disconnect()
		
			FoundAllEventsEvent:Destroy()
		end
		
		EventFolder = useEvents
		
		
		
		--// Rest of code after waiting for correct events.
		
		local UserInputService = game:GetService("UserInputService")
		local RunService = game:GetService("RunService")
		
		local Players = game:GetService("Players")
		local LocalPlayer = Players.LocalPlayer
		
		while not LocalPlayer do
			Players.ChildAdded:wait()
			LocalPlayer = Players.LocalPlayer
		end
		
		local canChat = true
		
		local ChatDisplayOrder = 6
		if ChatSettings.ScreenGuiDisplayOrder ~= nil then
			ChatDisplayOrder = ChatSettings.ScreenGuiDisplayOrder
		end
		
		local PlayerGui = LocalPlayer:WaitForChild("PlayerGui")
		local GuiParent = Instance.new("ScreenGui")
		GuiParent.Name = "Chat"
		GuiParent.ResetOnSpawn = false
		GuiParent.DisplayOrder = ChatDisplayOrder
		GuiParent.Parent = PlayerGui
		
		if FFlagUserAddBetterConsoleCheckForLegacyChat then
			if game:GetService("GuiService"):IsTenFootInterface() then
				GuiParent.Enabled = false
			end
		end
		
		local DidFirstChannelsLoads = false
		
		local modulesFolder = script
		
		local moduleChatWindow = require(modulesFolder:WaitForChild("ChatWindow"))
		local moduleChatBar = require(modulesFolder:WaitForChild("ChatBar"))
		local moduleChannelsBar = require(modulesFolder:WaitForChild("ChannelsBar"))
		local moduleMessageLabelCreator = require(modulesFolder:WaitForChild("MessageLabelCreator"))
		local moduleMessageLogDisplay = require(modulesFolder:WaitForChild("MessageLogDisplay"))
		local moduleChatChannel = require(modulesFolder:WaitForChild("ChatChannel"))
		local moduleCommandProcessor = require(modulesFolder:WaitForChild("CommandProcessor"))
		
		local ChatWindow = moduleChatWindow.new()
		local ChannelsBar = moduleChannelsBar.new()
		local MessageLogDisplay = moduleMessageLogDisplay.new()
		local CommandProcessor = moduleCommandProcessor.new()
		local ChatBar = moduleChatBar.new(CommandProcessor, ChatWindow)
		
		ChatWindow:CreateGuiObjects(GuiParent)
		
		ChatWindow:RegisterChatBar(ChatBar)
		ChatWindow:RegisterChannelsBar(ChannelsBar)
		ChatWindow:RegisterMessageLogDisplay(MessageLogDisplay)
		
		MessageCreatorUtil:RegisterChatWindow(ChatWindow)
		
		local MessageSender = require(modulesFolder:WaitForChild("MessageSender"))
		MessageSender:RegisterSayMessageFunction(EventFolder.SayMessageRequest)
		
		
		
		if (UserInputService.TouchEnabled) then
			ChatBar:SetTextLabelText(ChatLocalization:Get("GameChat_ChatMain_ChatBarTextTouch",'Tap here to chat'))
		else
			ChatBar:SetTextLabelText(ChatLocalization:Get("GameChat_ChatMain_ChatBarText",'To chat click here or press "/" key'))
		end
		
		spawn(function()
			local CurveUtil = require(modulesFolder:WaitForChild("CurveUtil"))
			local animationFps = ChatSettings.ChatAnimationFPS or 20.0
		
			local updateWaitTime = 1.0 / animationFps
			local lastTick = tick()
			while true do
				local currentTick = tick()
				local tickDelta = currentTick - lastTick
				local dtScale = CurveUtil:DeltaTimeToTimescale(tickDelta)
		
				if dtScale ~= 0 then
					ChatWindow:Update(dtScale)
				end
		
				lastTick = currentTick
				wait(updateWaitTime)
			end
		end)
		
		
		
		
		--////////////////////////////////////////////////////////////////////////////////////////////
		--////////////////////////////////////////////////////////////// Code to do chat window fading
		--////////////////////////////////////////////////////////////////////////////////////////////
		function CheckIfPointIsInSquare(checkPos, topLeft, bottomRight)
			return (topLeft.X <= checkPos.X and checkPos.X <= bottomRight.X and
				topLeft.Y <= checkPos.Y and checkPos.Y <= bottomRight.Y)
		end
		
		local backgroundIsFaded = false
		local textIsFaded = false
		local lastTextFadeTime = 0
		local lastBackgroundFadeTime = 0
		
		local fadedChanged = Instance.new("BindableEvent")
		local mouseStateChanged = Instance.new("BindableEvent")
		local chatBarFocusChanged = Instance.new("BindableEvent")
		
		function DoBackgroundFadeIn(setFadingTime)
			lastBackgroundFadeTime = tick()
			backgroundIsFaded = false
			fadedChanged:Fire()
			ChatWindow:FadeInBackground((setFadingTime or ChatSettings.ChatDefaultFadeDuration))
		
			local currentChannelObject = ChatWindow:GetCurrentChannel()
			if (currentChannelObject) then
		
				local Scroller = MessageLogDisplay.Scroller
				Scroller.ScrollingEnabled = true
				Scroller.ScrollBarThickness = moduleMessageLogDisplay.ScrollBarThickness
			end
		end
		
		function DoBackgroundFadeOut(setFadingTime)
			lastBackgroundFadeTime = tick()
			backgroundIsFaded = true
			fadedChanged:Fire()
			ChatWindow:FadeOutBackground((setFadingTime or ChatSettings.ChatDefaultFadeDuration))
		
			local currentChannelObject = ChatWindow:GetCurrentChannel()
			if (currentChannelObject) then
		
				local Scroller = MessageLogDisplay.Scroller
				Scroller.ScrollingEnabled = false
				Scroller.ScrollBarThickness = 0
			end
		end
		
		function DoTextFadeIn(setFadingTime)
			lastTextFadeTime = tick()
			textIsFaded = false
			fadedChanged:Fire()
			ChatWindow:FadeInText((setFadingTime or ChatSettings.ChatDefaultFadeDuration) * 0)
		end
		
		function DoTextFadeOut(setFadingTime)
			lastTextFadeTime = tick()
			textIsFaded = true
			fadedChanged:Fire()
			ChatWindow:FadeOutText((setFadingTime or ChatSettings.ChatDefaultFadeDuration))
		end
		
		function DoFadeInFromNewInformation()
			DoTextFadeIn()
			if ChatSettings.ChatShouldFadeInFromNewInformation then
				DoBackgroundFadeIn()
			end
		end
		
		function InstantFadeIn()
			DoBackgroundFadeIn(0)
			DoTextFadeIn(0)
		end
		
		function InstantFadeOut()
			DoBackgroundFadeOut(0)
			DoTextFadeOut(0)
		end
		
		local mouseIsInWindow = nil
		function UpdateFadingForMouseState(mouseState)
			mouseIsInWindow = mouseState
		
			mouseStateChanged:Fire()
		
			if (ChatBar:IsFocused()) then return end
		
			if (mouseState) then
				DoBackgroundFadeIn()
				DoTextFadeIn()
			else
				DoBackgroundFadeIn()
			end
		end
		
		
		spawn(function()
			while true do
				RunService.RenderStepped:wait()
		
				while (mouseIsInWindow or ChatBar:IsFocused()) do
					if (mouseIsInWindow) then
						mouseStateChanged.Event:wait()
					end
					if (ChatBar:IsFocused()) then
						chatBarFocusChanged.Event:wait()
					end
				end
		
				if (not backgroundIsFaded) then
					local timeDiff = tick() - lastBackgroundFadeTime
					if (timeDiff > ChatSettings.ChatWindowBackgroundFadeOutTime) then
						DoBackgroundFadeOut()
					end
		
				elseif (not textIsFaded) then
					local timeDiff = tick() - lastTextFadeTime
					if (timeDiff > ChatSettings.ChatWindowTextFadeOutTime) then
						DoTextFadeOut()
					end
		
				else
					fadedChanged.Event:wait()
		
				end
		
			end
		end)
		
		function getClassicChatEnabled()
			if ChatSettings.ClassicChatEnabled ~= nil then
				return ChatSettings.ClassicChatEnabled
			end
			return Players.ClassicChat
		end
		
		function getBubbleChatEnabled()
			if ChatSettings.BubbleChatEnabled ~= nil then
				return ChatSettings.BubbleChatEnabled
			end
			return Players.BubbleChat
		end
		
		function bubbleChatOnly()
			return not getClassicChatEnabled() and getBubbleChatEnabled()
		end
		
		function UpdateMousePosition(mousePos)
			if not (moduleApiTable.Visible and moduleApiTable.IsCoreGuiEnabled and (moduleApiTable.TopbarEnabled or ChatSettings.ChatOnWithTopBarOff)) then return end
		
			if bubbleChatOnly() then
				return
			end
		
			local windowPos = ChatWindow.GuiObject.AbsolutePosition
			local windowSize = ChatWindow.GuiObject.AbsoluteSize
		
			local newMouseState = CheckIfPointIsInSquare(mousePos, windowPos, windowPos + windowSize)
		
			if (newMouseState ~= mouseIsInWindow) then
				UpdateFadingForMouseState(newMouseState)
			end
		end
		
		UserInputService.InputChanged:connect(function(inputObject, gameProcessedEvent)
			if (inputObject.UserInputType == Enum.UserInputType.MouseMovement) then
				local mousePos = Vector2.new(inputObject.Position.X, inputObject.Position.Y)
				UpdateMousePosition(mousePos)
			end
		end)
		
		UserInputService.TouchTap:connect(function(tapPos, gameProcessedEvent)
			UpdateMousePosition(tapPos[1])
		end)
		
		UserInputService.TouchMoved:connect(function(inputObject, gameProcessedEvent)
			local tapPos = Vector2.new(inputObject.Position.X, inputObject.Position.Y)
			UpdateMousePosition(tapPos)
		end)
		
		UserInputService.Changed:connect(function(prop)
			if prop == "MouseBehavior" then
				if UserInputService.MouseBehavior == Enum.MouseBehavior.LockCenter then
					local windowPos = ChatWindow.GuiObject.AbsolutePosition
					local windowSize = ChatWindow.GuiObject.AbsoluteSize
					local screenSize = GuiParent.AbsoluteSize
		
					local centerScreenIsInWindow = CheckIfPointIsInSquare(screenSize/2, windowPos, windowPos + windowSize)
					if centerScreenIsInWindow then
						UserInputService.MouseBehavior = Enum.MouseBehavior.Default
					end
				end
			end
		end)
		
		--// Start and stop fading sequences / timers
		UpdateFadingForMouseState(true)
		UpdateFadingForMouseState(false)
		
		
		--////////////////////////////////////////////////////////////////////////////////////////////
		--///////////// Code to talk to topbar and maintain set/get core backwards compatibility stuff
		--////////////////////////////////////////////////////////////////////////////////////////////
		local Util = {}
		do
			function Util.Signal()
				local sig = {}
		
				local mSignaler = Instance.new('BindableEvent')
		
				local mArgData = nil
				local mArgDataCount = nil
		
				function sig:fire(...)
					mArgData = {...}
					mArgDataCount = select('#', ...)
					mSignaler:Fire()
				end
		
				function sig:connect(f)
					if not f then error("connect(nil)", 2) end
					return mSignaler.Event:connect(function()
						f(unpack(mArgData, 1, mArgDataCount))
					end)
				end
		
				function sig:wait()
					mSignaler.Event:wait()
					assert(mArgData, "Missing arg data, likely due to :TweenSize/Position corrupting threadrefs.")
					return unpack(mArgData, 1, mArgDataCount)
				end
		
				return sig
			end
		end
		
		
		function SetVisibility(val)
			ChatWindow:SetVisible(val)
			moduleApiTable.VisibilityStateChanged:fire(val)
			moduleApiTable.Visible = val
		
			if (moduleApiTable.IsCoreGuiEnabled) then
				if (val) then
					InstantFadeIn()
				else
					InstantFadeOut()
				end
			end
		end
		
		local DoChatBarFocus = nil
		
		do
			moduleApiTable.TopbarEnabled = true
			moduleApiTable.MessageCount = 0
			moduleApiTable.Visible = true
			moduleApiTable.IsCoreGuiEnabled = true
		
			function moduleApiTable:ToggleVisibility()
				SetVisibility(not ChatWindow:GetVisible())
			end
		
			function moduleApiTable:SetVisible(visible)
				if (ChatWindow:GetVisible() ~= visible) then
					SetVisibility(visible)
				end
			end
		
			function moduleApiTable:FocusChatBar()
				ChatBar:CaptureFocus()
			end
		
			function moduleApiTable:EnterWhisperState(player)
				ChatBar:EnterWhisperState(player)
			end
		
			function moduleApiTable:GetVisibility()
				return ChatWindow:GetVisible()
			end
		
			function moduleApiTable:GetMessageCount()
				return self.MessageCount
			end
		
			function moduleApiTable:TopbarEnabledChanged(enabled)
				self.TopbarEnabled = enabled
				self.CoreGuiEnabled:fire(game:GetService("StarterGui"):GetCoreGuiEnabled(Enum.CoreGuiType.Chat))
			end
		
			function moduleApiTable:IsFocused(useWasFocused)
				return ChatBar:IsFocused()
			end
		
			moduleApiTable.ChatBarFocusChanged = Util.Signal()
			moduleApiTable.VisibilityStateChanged = Util.Signal()
			moduleApiTable.MessagesChanged = Util.Signal()
		
		
			moduleApiTable.MessagePosted = Util.Signal()
			moduleApiTable.CoreGuiEnabled = Util.Signal()
		
			moduleApiTable.ChatMakeSystemMessageEvent = Util.Signal()
			moduleApiTable.ChatWindowPositionEvent = Util.Signal()
			moduleApiTable.ChatWindowSizeEvent = Util.Signal()
			moduleApiTable.ChatBarDisabledEvent = Util.Signal()
		
		
			function moduleApiTable:fChatWindowPosition()
				return ChatWindow.GuiObject.Position
			end
		
			function moduleApiTable:fChatWindowSize()
				return ChatWindow.GuiObject.Size
			end
		
			function moduleApiTable:fChatBarDisabled()
				return not ChatBar:GetEnabled()
			end
		
			if FFlagUserHandleChatHotKeyWithContextActionService then
				local TOGGLE_CHAT_ACTION_NAME = "ToggleChat"
		
				-- Callback when chat hotkey is pressed
				local function handleAction(actionName, inputState, inputObject)
					if actionName == TOGGLE_CHAT_ACTION_NAME and inputState == Enum.UserInputState.Begin and canChat and inputObject.UserInputType == Enum.UserInputType.Keyboard then
						DoChatBarFocus()
					end
				end
				ContextActionService:BindAction(TOGGLE_CHAT_ACTION_NAME, handleAction, true, Enum.KeyCode.Slash)
			else
				function moduleApiTable:SpecialKeyPressed(key, modifiers)
					if (key == Enum.SpecialKey.ChatHotkey) then
						if canChat then
							DoChatBarFocus()
						end
					end
				end
			end
		end
		
		moduleApiTable.CoreGuiEnabled:connect(function(enabled)
			moduleApiTable.IsCoreGuiEnabled = enabled
		
			enabled = enabled and (moduleApiTable.TopbarEnabled or ChatSettings.ChatOnWithTopBarOff)
		
			ChatWindow:SetCoreGuiEnabled(enabled)
		
			if (not enabled) then
				ChatBar:ReleaseFocus()
				InstantFadeOut()
			else
				InstantFadeIn()
			end
		end)
		
		function trimTrailingSpaces(str)
			local lastSpace = #str
			while lastSpace > 0 do
				--- The pattern ^%s matches whitespace at the start of the string. (Starting from lastSpace)
				if str:find("^%s", lastSpace) then
					lastSpace = lastSpace - 1
				else
					break
				end
			end
			return str:sub(1, lastSpace)
		end
		
		moduleApiTable.ChatMakeSystemMessageEvent:connect(function(valueTable)
			if (valueTable["Text"] and type(valueTable["Text"]) == "string") then
				while (not DidFirstChannelsLoads) do wait() end
		
				local channel = ChatSettings.GeneralChannelName
				local channelObj = ChatWindow:GetChannel(channel)
		
				if (channelObj) then
					local messageObject = {
						ID = -1,
						FromSpeaker = nil,
						SpeakerUserId = 0,
						OriginalChannel = channel,
						IsFiltered = true,
						MessageLength = string.len(valueTable.Text),
						MessageLengthUtf8 = utf8.len(utf8.nfcnormalize(valueTable.Text)),
						Message = trimTrailingSpaces(valueTable.Text),
						MessageType = ChatConstants.MessageTypeSetCore,
						Time = os.time(),
						ExtraData = valueTable,
					}
					channelObj:AddMessageToChannel(messageObject)
					ChannelsBar:UpdateMessagePostedInChannel(channel)
		
					moduleApiTable.MessageCount = moduleApiTable.MessageCount + 1
					moduleApiTable.MessagesChanged:fire(moduleApiTable.MessageCount)
				end
			end
		end)
		
		moduleApiTable.ChatBarDisabledEvent:connect(function(disabled)
			if canChat then
				ChatBar:SetEnabled(not disabled)
				if (disabled) then
					ChatBar:ReleaseFocus()
				end
			end
		end)
		
		moduleApiTable.ChatWindowSizeEvent:connect(function(size)
			ChatWindow.GuiObject.Size = size
		end)
		
		moduleApiTable.ChatWindowPositionEvent:connect(function(position)
			ChatWindow.GuiObject.Position = position
		end)
		
		--////////////////////////////////////////////////////////////////////////////////////////////
		--///////////////////////////////////////////////// Code to hook client UI up to server events
		--////////////////////////////////////////////////////////////////////////////////////////////
		
		function DoChatBarFocus()
			if (not ChatWindow:GetCoreGuiEnabled()) then return end
			if (not ChatBar:GetEnabled()) then return end
		
			if (not ChatBar:IsFocused() and ChatBar:GetVisible()) then
				moduleApiTable:SetVisible(true)
				InstantFadeIn()
				ChatBar:CaptureFocus()
				moduleApiTable.ChatBarFocusChanged:fire(true)
			end
		end
		
		chatBarFocusChanged.Event:connect(function(focused)
			moduleApiTable.ChatBarFocusChanged:fire(focused)
		end)
		
		function DoSwitchCurrentChannel(targetChannel)
			if (ChatWindow:GetChannel(targetChannel)) then
				ChatWindow:SwitchCurrentChannel(targetChannel)
			end
		end
		
		function SendMessageToSelfInTargetChannel(message, channelName, extraData)
			local channelObj = ChatWindow:GetChannel(channelName)
			if (channelObj) then
				local messageData = {
					ID = -1,
					FromSpeaker = nil,
					SpeakerUserId = 0,
					OriginalChannel = channelName,
					IsFiltered = true,
					MessageLength = string.len(message),
					MessageLengthUtf8 = utf8.len(utf8.nfcnormalize(message)),
					Message = trimTrailingSpaces(message),
					MessageType = ChatConstants.MessageTypeSystem,
					Time = os.time(),
					ExtraData = extraData,
				}
		
				channelObj:AddMessageToChannel(messageData)
			end
		end
		
		function chatBarFocused()
			if (not mouseIsInWindow) then
				DoBackgroundFadeIn()
				if (textIsFaded) then
					DoTextFadeIn()
				end
			end
		
			chatBarFocusChanged:Fire(true)
		end
		
		--// Event for making player say chat message.
		function chatBarFocusLost(enterPressed, inputObject)
			DoBackgroundFadeIn()
			chatBarFocusChanged:Fire(false)
		
			if (enterPressed) then
				local message = ChatBar:GetTextBox().Text
		
				if ChatBar:IsInCustomState() then
					local customMessage = ChatBar:GetCustomMessage()
					if customMessage then
						message = customMessage
					end
					local messageSunk = ChatBar:CustomStateProcessCompletedMessage(message)
					ChatBar:ResetCustomState()
					if messageSunk then
						return
					end
				end
		
				ChatBar:GetTextBox().Text = ""
		
				if message ~= "" then
					--// Sends signal to eventually call Player:Chat() to handle C++ side legacy stuff.
					moduleApiTable.MessagePosted:fire(message)
		
					if not CommandProcessor:ProcessCompletedChatMessage(message, ChatWindow) then
						if ChatSettings.DisallowedWhiteSpace then
							for i = 1, #ChatSettings.DisallowedWhiteSpace do
								if ChatSettings.DisallowedWhiteSpace[i] == "\t" then
									message = string.gsub(message, ChatSettings.DisallowedWhiteSpace[i], " ")
								else
									message = string.gsub(message, ChatSettings.DisallowedWhiteSpace[i], "")
								end
							end
						end
						message = string.gsub(message, "\n", "")
						message = string.gsub(message, "[ ]+", " ")
		
						local targetChannel = ChatWindow:GetTargetMessageChannel()
						if targetChannel then
							MessageSender:SendMessage(message, targetChannel)
						else
							MessageSender:SendMessage(message, nil)
						end
					end
				end
		
			end
		end
		
		local ChatBarConnections = {}
		function setupChatBarConnections()
			for i = 1, #ChatBarConnections do
				ChatBarConnections[i]:Disconnect()
			end
			ChatBarConnections = {}
		
			local focusLostConnection = ChatBar:GetTextBox().FocusLost:connect(chatBarFocusLost)
			table.insert(ChatBarConnections, focusLostConnection)
		
			local focusGainedConnection = ChatBar:GetTextBox().Focused:connect(chatBarFocused)
			table.insert(ChatBarConnections, focusGainedConnection)
		end
		
		setupChatBarConnections()
		ChatBar.GuiObjectsChanged:connect(setupChatBarConnections)
		
		function getEchoMessagesInGeneral()
			if ChatSettings.EchoMessagesInGeneralChannel == nil then
				return true
			end
			return ChatSettings.EchoMessagesInGeneralChannel
		end
		
		EventFolder.OnMessageDoneFiltering.OnClientEvent:connect(function(messageData)
			if not ChatSettings.ShowUserOwnFilteredMessage then
				if messageData.FromSpeaker == LocalPlayer.Name then
					return
				end
			end
		
			local channelName = messageData.OriginalChannel
			local channelObj = ChatWindow:GetChannel(channelName)
			if channelObj then
				channelObj:UpdateMessageFiltered(messageData)
			end
		
			if getEchoMessagesInGeneral() and ChatSettings.GeneralChannelName and channelName ~= ChatSettings.GeneralChannelName then
				local generalChannel = ChatWindow:GetChannel(ChatSettings.GeneralChannelName)
				if generalChannel then
					generalChannel:UpdateMessageFiltered(messageData)
				end
			end
		end)
		
		EventFolder.OnNewMessage.OnClientEvent:connect(function(messageData, channelName)
			local channelObj = ChatWindow:GetChannel(channelName)
			if (channelObj) then
				channelObj:AddMessageToChannel(messageData)
		
				if (messageData.FromSpeaker ~= LocalPlayer.Name) then
					ChannelsBar:UpdateMessagePostedInChannel(channelName)
				end
		
				if getEchoMessagesInGeneral() and ChatSettings.GeneralChannelName and channelName ~= ChatSettings.GeneralChannelName then
					local generalChannel = ChatWindow:GetChannel(ChatSettings.GeneralChannelName)
					if generalChannel then
						generalChannel:AddMessageToChannel(messageData)
					end
				end
		
				moduleApiTable.MessageCount = moduleApiTable.MessageCount + 1
				moduleApiTable.MessagesChanged:fire(moduleApiTable.MessageCount)
		
				DoFadeInFromNewInformation()
			end
		end)
		
		EventFolder.OnNewSystemMessage.OnClientEvent:connect(function(messageData, channelName)
			channelName = channelName or "System"
		
			local channelObj = ChatWindow:GetChannel(channelName)
			if (channelObj) then
				channelObj:AddMessageToChannel(messageData)
		
				ChannelsBar:UpdateMessagePostedInChannel(channelName)
		
				moduleApiTable.MessageCount = moduleApiTable.MessageCount + 1
				moduleApiTable.MessagesChanged:fire(moduleApiTable.MessageCount)
		
				DoFadeInFromNewInformation()
		
				if getEchoMessagesInGeneral() and ChatSettings.GeneralChannelName and channelName ~= ChatSettings.GeneralChannelName then
					local generalChannel = ChatWindow:GetChannel(ChatSettings.GeneralChannelName)
					if generalChannel then
						generalChannel:AddMessageToChannel(messageData)
					end
				end
			else
				warn(string.format("Just received system message for channel I'm not in [%s]", channelName))
			end
		end)
		
		
		function HandleChannelJoined(channel, welcomeMessage, messageLog, channelNameColor, addHistoryToGeneralChannel,
			addWelcomeMessageToGeneralChannel)
			if ChatWindow:GetChannel(channel) then
				--- If the channel has already been added, remove it first.
				ChatWindow:RemoveChannel(channel)
			end
		
			if (channel == ChatSettings.GeneralChannelName) then
				DidFirstChannelsLoads = true
			end
		
			if channelNameColor then
				ChatBar:SetChannelNameColor(channel, channelNameColor)
			end
		
			local channelObj = ChatWindow:AddChannel(channel)
		
			if (channelObj) then
				if (channel == ChatSettings.GeneralChannelName) then
					DoSwitchCurrentChannel(channel)
				end
		
				if (messageLog) then
					local startIndex = 1
					if #messageLog > ChatSettings.MessageHistoryLengthPerChannel then
						startIndex = #messageLog - ChatSettings.MessageHistoryLengthPerChannel
					end
		
					for i = startIndex, #messageLog do
						channelObj:AddMessageToChannel(messageLog[i])
					end
		
					if getEchoMessagesInGeneral() and addHistoryToGeneralChannel then
						if ChatSettings.GeneralChannelName and channel ~= ChatSettings.GeneralChannelName then
							local generalChannel = ChatWindow:GetChannel(ChatSettings.GeneralChannelName)
							if generalChannel then
								generalChannel:AddMessagesToChannelByTimeStamp(messageLog, startIndex)
							end
						end
					end
				end
		
				if (welcomeMessage ~= "") then
					local welcomeMessageObject = {
						ID = -1,
						FromSpeaker = nil,
						SpeakerUserId = 0,
						OriginalChannel = channel,
						IsFiltered = true,
						MessageLength = string.len(welcomeMessage),
						MessageLengthUtf8 = utf8.len(utf8.nfcnormalize(welcomeMessage)),
						Message = trimTrailingSpaces(welcomeMessage),
						MessageType = ChatConstants.MessageTypeWelcome,
						Time = os.time(),
						ExtraData = nil,
					}
					channelObj:AddMessageToChannel(welcomeMessageObject)
		
					if getEchoMessagesInGeneral() and addWelcomeMessageToGeneralChannel and not ChatSettings.ShowChannelsBar then
						if channel ~= ChatSettings.GeneralChannelName then
							local generalChannel = ChatWindow:GetChannel(ChatSettings.GeneralChannelName)
							if generalChannel then
								generalChannel:AddMessageToChannel(welcomeMessageObject)
							end
						end
					end
				end
		
				local translationOnboardingMessage = ChatLocalization:Get("GameChat_ChatMain_ChatTranslationOnboarding", "Text chat will be translated into your language. Tap the symbol in front of the message to see the original. You can turn off translations in the Settings menu.")
		
				if (FFlagUserIsChatTranslationEnabled and translationOnboardingMessage ~= "" and channel == ChatSettings.GeneralChannelName and chatTranslationEnabled ~= nil and chatTranslationEnabled.Value) then
					local translationOnboardingMessageObject = {
						ID = -2,
						FromSpeaker = nil,
						SpeakerUserId = 0,
						OriginalChannel = channel,
						IsFiltered = true,
						MessageLength = string.len(translationOnboardingMessage),
						MessageLengthUtf8 = utf8.len(utf8.nfcnormalize(translationOnboardingMessage)),
						Message = trimTrailingSpaces(translationOnboardingMessage),
						MessageType = ChatConstants.MessageTypeWelcome,
						Time = os.time(),
						ExtraData = nil,
					}
					channelObj:AddMessageToChannel(translationOnboardingMessageObject)
				end
		
				DoFadeInFromNewInformation()
			end
		
		end
		
		EventFolder.OnChannelJoined.OnClientEvent:connect(function(channel, welcomeMessage, messageLog, channelNameColor)
			HandleChannelJoined(channel, welcomeMessage, messageLog, channelNameColor, false, true)
		end)
		
		EventFolder.OnChannelLeft.OnClientEvent:connect(function(channel)
			ChatWindow:RemoveChannel(channel)
		
			DoFadeInFromNewInformation()
		end)
		
		EventFolder.OnMuted.OnClientEvent:connect(function(channel)
			--// Do something eventually maybe?
			--// This used to take away the chat bar in channels the player was muted in.
			--// We found out this behavior was inconvenient for doing chat commands though.
		end)
		
		EventFolder.OnUnmuted.OnClientEvent:connect(function(channel)
			--// Same as above.
		end)
		
		EventFolder.OnMainChannelSet.OnClientEvent:connect(function(channel)
			DoSwitchCurrentChannel(channel)
		end)
		
		coroutine.wrap(function()
			-- ChannelNameColorUpdated may not exist if the client version is older than the server version.
			local ChannelNameColorUpdated = DefaultChatSystemChatEvents:WaitForChild("ChannelNameColorUpdated", 5)
			if ChannelNameColorUpdated then
				ChannelNameColorUpdated.OnClientEvent:connect(function(channelName, channelNameColor)
					ChatBar:SetChannelNameColor(channelName, channelNameColor)
				end)
			end
		end)()
		
		
		--- Interaction with SetCore Player events.
		
		local PlayerBlockedEvent = nil
		local PlayerMutedEvent = nil
		local PlayerUnBlockedEvent = nil
		local PlayerUnMutedEvent = nil
		
		
		-- This is pcalled because the SetCore methods may not be released yet.
		pcall(function()
			PlayerBlockedEvent = StarterGui:GetCore("PlayerBlockedEvent")
			PlayerMutedEvent = StarterGui:GetCore("PlayerMutedEvent")
			PlayerUnBlockedEvent = StarterGui:GetCore("PlayerUnblockedEvent")
			PlayerUnMutedEvent = StarterGui:GetCore("PlayerUnmutedEvent")
		end)
		
		function SendSystemMessageToSelf(message)
			local currentChannel = ChatWindow:GetCurrentChannel()
		
			if currentChannel then
				local messageData = {
					ID = -1,
					FromSpeaker = nil,
					SpeakerUserId = 0,
					OriginalChannel = currentChannel.Name,
					IsFiltered = true,
					MessageLength = string.len(message),
					MessageLengthUtf8 = utf8.len(utf8.nfcnormalize(message)),
					Message = trimTrailingSpaces(message),
					MessageType = ChatConstants.MessageTypeSystem,
					Time = os.time(),
					ExtraData = nil,
				}
		
				currentChannel:AddMessageToChannel(messageData)
			end
		end
		
		function MutePlayer(player)
			local mutePlayerRequest = DefaultChatSystemChatEvents:FindFirstChild("MutePlayerRequest")
			if mutePlayerRequest then
				return mutePlayerRequest:InvokeServer(player.Name)
			end
			return false
		end
		
		if PlayerBlockedEvent then
			PlayerBlockedEvent.Event:connect(function(player)
				if MutePlayer(player) then
					local playerName
		
					if ChatSettings.PlayerDisplayNamesEnabled then
						playerName = player.DisplayName
					else
						playerName = player.Name
					end
		
					SendSystemMessageToSelf(
						ChatLocalization:Get(
							"GameChat_ChatMain_SpeakerHasBeenBlocked",
							string.format("Speaker '%s' has been blocked.", playerName),
							{ RBX_NAME = playerName }
						)
					)
				end
			end)
		end
		
		if FFlagUserHandleFriendJoinNotifierOnClient then
			local function ShowFriendJoinNotification()
				if ChatSettings.ShowFriendJoinNotification ~= nil then
					return ChatSettings.ShowFriendJoinNotification
				end
				return false
			end
		
			if ShowFriendJoinNotification() then
				Players.PlayerAdded:Connect(function(newPlayer)
					local success, isFriends = pcall(function()
						return newPlayer:IsFriendsWith(LocalPlayer.UserId)
					end)
		
					if success and isFriends then
						local joinedFriendName = newPlayer.Name
						if ChatSettings.PlayerDisplayNamesEnabled then
							joinedFriendName = newPlayer.DisplayName
						end
		
						local msg = ChatLocalization:FormatMessageToSend("GameChat_FriendChatNotifier_JoinMessage",
							string.format("Your friend %s has joined the game.", joinedFriendName),
							"RBX_NAME",
							joinedFriendName)
		
						SendSystemMessageToSelf(msg)
					end
				end)
			end
		end
		
		if PlayerMutedEvent then
			PlayerMutedEvent.Event:connect(function(player)
				if MutePlayer(player) then
					local playerName
		
					if ChatSettings.PlayerDisplayNamesEnabled then
						playerName = player.DisplayName
					else
						playerName = player.Name
					end
		
					SendSystemMessageToSelf(
						ChatLocalization:Get(
							"GameChat_ChatMain_SpeakerHasBeenMuted",
							string.format("Speaker '%s' has been muted.", playerName),
							{ RBX_NAME = playerName }
						)
					)
				end
			end)
		end
		
		function UnmutePlayer(player)
			local unmutePlayerRequest = DefaultChatSystemChatEvents:FindFirstChild("UnMutePlayerRequest")
			if unmutePlayerRequest then
				return unmutePlayerRequest:InvokeServer(player.Name)
			end
			return false
		end
		
		if PlayerUnBlockedEvent then
			PlayerUnBlockedEvent.Event:connect(function(player)
				if UnmutePlayer(player) then
					local playerName
		
					if ChatSettings.PlayerDisplayNamesEnabled then
						playerName = player.DisplayName
					else
						playerName = player.Name
					end
		
					SendSystemMessageToSelf(
						ChatLocalization:Get(
							"GameChat_ChatMain_SpeakerHasBeenUnBlocked",
							string.format("Speaker '%s' has been unblocked.", playerName),
							{ RBX_NAME = playerName }
						)
					)
				end
			end)
		end
		
		if PlayerUnMutedEvent then
			PlayerUnMutedEvent.Event:connect(function(player)
				if UnmutePlayer(player) then
					local playerName
		
					if ChatSettings.PlayerDisplayNamesEnabled then
						playerName = player.DisplayName
					else
						playerName = player.Name
					end
		
					SendSystemMessageToSelf(
						ChatLocalization:Get(
							"GameChat_ChatMain_SpeakerHasBeenUnMuted",
							string.format("Speaker '%s' has been unmuted.", playerName),
							{ RBX_NAME = playerName }
						)
					)
				end
			end)
		end
		
		-- Get a list of blocked users from the corescripts.
		-- Spawned because this method can yeild.
		spawn(function()
			-- Pcalled because this method is not released on all platforms yet.
			if LocalPlayer.UserId > 0 then
				pcall(function()
					local blockedUserIds = StarterGui:GetCore("GetBlockedUserIds")
					if #blockedUserIds > 0 then
						local setInitalBlockedUserIds = DefaultChatSystemChatEvents:FindFirstChild("SetBlockedUserIdsRequest")
						if setInitalBlockedUserIds then
							setInitalBlockedUserIds:FireServer(blockedUserIds)
						end
					end
				end)
			end
		end)
		
		spawn(function()
			local success, canLocalUserChat = pcall(function()
				return Chat:CanUserChatAsync(LocalPlayer.UserId)
			end)
			if success then
				canChat = RunService:IsStudio() or canLocalUserChat
			end
		end)
		
		local initData = EventFolder.GetInitDataRequest:InvokeServer()
		
		-- Handle joining general channel first.
		for i, channelData in pairs(initData.Channels) do
			if channelData[1] == ChatSettings.GeneralChannelName then
				HandleChannelJoined(channelData[1], channelData[2], channelData[3], channelData[4], true, false)
			end
		end
		
		for i, channelData in pairs(initData.Channels) do
			if channelData[1] ~= ChatSettings.GeneralChannelName then
				HandleChannelJoined(channelData[1], channelData[2], channelData[3], channelData[4], true, false)
			end
		end
		
		return moduleApiTable
		
	end
	fake_module_scripts[script] = module_script
end
do -- nil.ChatChannel
	local script = Instance.new('ModuleScript', chatmain)
	script.Name = "ChatChannel"
	local function module_script()
		--!nonstrict
		--	// FileName: ChatChannel.lua
		--	// Written by: Xsitsu
		--	// Description: ChatChannel class for handling messages being added and removed from the chat channel.
		
		local UserFlagRemoveMessageFromMessageLog do
			local success, value = pcall(function()
				return UserSettings():IsUserFeatureEnabled("UserFlagRemoveMessageFromMessageLog")
			end)
			UserFlagRemoveMessageFromMessageLog = success and value
		end
		
		local userIsChatTranslationEnabled = false
		do
			local success, value = pcall(function()
				return UserSettings():IsUserFeatureEnabled("UserIsChatTranslationEnabled2")
			end)
			userIsChatTranslationEnabled = success and value
		end
		
		local module = {}
		--////////////////////////////// Include
		--//////////////////////////////////////
		local Chat = game:GetService("Chat")
		local clientChatModules = Chat:WaitForChild("ClientChatModules")
		local modulesFolder = script.Parent
		
		local ChatSettings = require(clientChatModules:WaitForChild("ChatSettings"))
		
		local chatTranslationEnabled = nil
		if userIsChatTranslationEnabled then
			chatTranslationEnabled = modulesFolder:FindFirstChild("ChatTranslationEnabled")
			if chatTranslationEnabled == nil then
				local chatTranslationSettingSignal
				chatTranslationSettingSignal = modulesFolder.ChildAdded:Connect(function(child)
					if child.Name == "ChatTranslationEnabled" then
						chatTranslationEnabled = child
		
						chatTranslationSettingSignal:Disconnect()
					end
				end)
			end
		end
		
		--////////////////////////////// Methods
		--//////////////////////////////////////
		local methods = {}
		methods.__index = methods
		
		function methods:Destroy()
			self.Destroyed = true
		end
		
		function methods:SetActive(active)
			if active == self.Active then
				return
			end
			if active == false then
				self.MessageLogDisplay:Clear()
			else
				self.MessageLogDisplay:SetCurrentChannelName(self.Name)
				for i = 1, #self.MessageLog do
					self.MessageLogDisplay:AddMessage(self.MessageLog[i])
				end
			end
			self.Active = active
		end
		
		function methods:UpdateMessageFiltered(messageData)
			local searchIndex = 1
			local searchTable = self.MessageLog
			local messageObj = nil
			while (#searchTable >= searchIndex) do
				local obj = searchTable[searchIndex]
		
				if (obj.ID == messageData.ID) then
					messageObj = obj
					break
				end
		
				searchIndex = searchIndex + 1
			end
		
			if messageObj then
				messageObj.Message = messageData.Message
				messageObj.IsFiltered = true
				if userIsChatTranslationEnabled and chatTranslationEnabled ~= nil and chatTranslationEnabled.Value then
					messageObj.TranslatedMessage = messageData.TranslatedMessage
					messageObj.ShowTranslated = true
				end
				if self.Active then
					if UserFlagRemoveMessageFromMessageLog then
						if messageObj.Message == "" then
							table.remove(self.MessageLog, searchIndex)
						end
					end
					self.MessageLogDisplay:UpdateMessageFiltered(messageObj)
				end
			else
				-- We have not seen this filtered message before, but we should still add it to our log.
				self:AddMessageToChannelByTimeStamp(messageData)
			end
		end
		
		function methods:AddMessageToChannel(messageData)
			table.insert(self.MessageLog, messageData)
			if self.Active then
				self.MessageLogDisplay:AddMessage(messageData)
			end
			if #self.MessageLog > ChatSettings.MessageHistoryLengthPerChannel then
				self:RemoveLastMessageFromChannel()
			end
		end
		
		function methods:InternalAddMessageAtTimeStamp(messageData)
			for i = 1, #self.MessageLog do
				if messageData.Time < self.MessageLog[i].Time then
					table.insert(self.MessageLog, i, messageData)
					return
				end
			end
			table.insert(self.MessageLog, messageData)
		end
		
		function methods:AddMessagesToChannelByTimeStamp(messageLog, startIndex)
			for i = startIndex, #messageLog do
				self:InternalAddMessageAtTimeStamp(messageLog[i])
			end
			while #self.MessageLog > ChatSettings.MessageHistoryLengthPerChannel do
				table.remove(self.MessageLog, 1)
			end
			if self.Active then
				self.MessageLogDisplay:Clear()
				for i = 1, #self.MessageLog do
					self.MessageLogDisplay:AddMessage(self.MessageLog[i])
				end
			end
		end
		
		function methods:AddMessageToChannelByTimeStamp(messageData)
			if #self.MessageLog >= 1 then
				-- These are the fast cases to evalutate.
				if self.MessageLog[1].Time > messageData.Time then
					return
				elseif messageData.Time >= self.MessageLog[#self.MessageLog].Time then
					self:AddMessageToChannel(messageData)
					return
				end
		
				for i = 1, #self.MessageLog do
					if messageData.Time < self.MessageLog[i].Time then
						table.insert(self.MessageLog, i, messageData)
		
						if #self.MessageLog > ChatSettings.MessageHistoryLengthPerChannel then
							self:RemoveLastMessageFromChannel()
						end
		
						if self.Active then
							self.MessageLogDisplay:AddMessageAtIndex(messageData, i)
						end
		
						return
					end
				end
			else
				self:AddMessageToChannel(messageData)
			end
		end
		
		function methods:RemoveLastMessageFromChannel()
			table.remove(self.MessageLog, 1)
		
			if self.Active then
				self.MessageLogDisplay:RemoveLastMessage()
			end
		end
		
		function methods:ClearMessageLog()
			self.MessageLog = {}
		
			if self.Active then
				self.MessageLogDisplay:Clear()
			end
		end
		
		function methods:RegisterChannelTab(tab)
			self.ChannelTab = tab
		end
		
		--///////////////////////// Constructors
		--//////////////////////////////////////
		
		function module.new(channelName, messageLogDisplay)
			local obj = setmetatable({}, methods)
			obj.Destroyed = false
			obj.Active = false
		
			obj.MessageLog = {}
			obj.MessageLogDisplay = messageLogDisplay
			obj.ChannelTab = nil
			obj.Name = channelName
		
			return obj
		end
		
		return module
		
	end
	fake_module_scripts[script] = module_script
end
do -- nil.ChannelsTab
	local script = Instance.new('ModuleScript', chatmain)
	script.Name = "ChannelsTab"
	local function module_script()
		--!nonstrict
		--	// FileName: ChannelsTab.lua
		--	// Written by: Xsitsu
		--	// Description: Channel tab button for selecting current channel and also displaying if currently selected.
		
		local module = {}
		--////////////////////////////// Include
		--//////////////////////////////////////
		local Chat = game:GetService("Chat")
		local clientChatModules = Chat:WaitForChild("ClientChatModules")
		local modulesFolder = script.Parent
		local ChatSettings = require(clientChatModules:WaitForChild("ChatSettings"))
		local CurveUtil = require(modulesFolder:WaitForChild("CurveUtil"))
		
		--////////////////////////////// Methods
		--//////////////////////////////////////
		local methods = {}
		methods.__index = methods
		
		local function CreateGuiObjects()
			local BaseFrame = Instance.new("Frame")
			BaseFrame.Selectable = false
			BaseFrame.Size = UDim2.new(1, 0, 1, 0)
			BaseFrame.BackgroundTransparency = 1
		
			local gapOffsetX = 1
			local gapOffsetY = 1
		
			local BackgroundFrame = Instance.new("Frame")
			BackgroundFrame.Selectable = false
			BackgroundFrame.Name = "BackgroundFrame"
			BackgroundFrame.Size = UDim2.new(1, -gapOffsetX * 2, 1, -gapOffsetY * 2)
			BackgroundFrame.Position = UDim2.new(0, gapOffsetX, 0, gapOffsetY)
			BackgroundFrame.BackgroundTransparency = 1
			BackgroundFrame.Parent = BaseFrame
		
			local UnselectedFrame = Instance.new("Frame")
			UnselectedFrame.Selectable = false
			UnselectedFrame.Name = "UnselectedFrame"
			UnselectedFrame.Size = UDim2.new(1, 0, 1, 0)
			UnselectedFrame.Position = UDim2.new(0, 0, 0, 0)
			UnselectedFrame.BorderSizePixel = 0
			UnselectedFrame.BackgroundColor3 = ChatSettings.ChannelsTabUnselectedColor
			UnselectedFrame.BackgroundTransparency = 0.6
			UnselectedFrame.Parent = BackgroundFrame
		
			local SelectedFrame = Instance.new("Frame")
			SelectedFrame.Selectable = false
			SelectedFrame.Name = "SelectedFrame"
			SelectedFrame.Size = UDim2.new(1, 0, 1, 0)
			SelectedFrame.Position = UDim2.new(0, 0, 0, 0)
			SelectedFrame.BorderSizePixel = 0
			SelectedFrame.BackgroundColor3 = ChatSettings.ChannelsTabSelectedColor
			SelectedFrame.BackgroundTransparency = 1
			SelectedFrame.Parent = BackgroundFrame
		
			local SelectedFrameBackgroundImage = Instance.new("ImageLabel")
			SelectedFrameBackgroundImage.Selectable = false
			SelectedFrameBackgroundImage.Name = "BackgroundImage"
			SelectedFrameBackgroundImage.BackgroundTransparency = 1
			SelectedFrameBackgroundImage.BorderSizePixel = 0
			SelectedFrameBackgroundImage.Size = UDim2.new(1, 0, 1, 0)
			SelectedFrameBackgroundImage.Position = UDim2.new(0, 0, 0, 0)
			SelectedFrameBackgroundImage.ScaleType = Enum.ScaleType.Slice
			SelectedFrameBackgroundImage.Parent = SelectedFrame
		
			SelectedFrameBackgroundImage.BackgroundTransparency = 0.6 - 1
			local rate = 1.2 * 1
			SelectedFrameBackgroundImage.BackgroundColor3 = Color3.fromRGB(78 * rate, 84 * rate, 96 * rate)
		
			local borderXOffset = 2
			local blueBarYSize = 4
			local BlueBarLeft = Instance.new("ImageLabel")
			BlueBarLeft.Selectable = false
			BlueBarLeft.Size = UDim2.new(0.5, -borderXOffset, 0, blueBarYSize)
			BlueBarLeft.BackgroundTransparency = 1
			BlueBarLeft.ScaleType = Enum.ScaleType.Slice
			BlueBarLeft.SliceCenter = Rect.new(3,3,32,21)
			BlueBarLeft.Parent = SelectedFrame
		
			local BlueBarRight = BlueBarLeft:Clone()
			BlueBarRight.Parent = SelectedFrame
		
			BlueBarLeft.Position = UDim2.new(0, borderXOffset, 1, -blueBarYSize)
			BlueBarRight.Position = UDim2.new(0.5, 0, 1, -blueBarYSize)
			BlueBarLeft.Image = "rbxasset://textures/ui/Settings/Slider/SelectedBarLeft.png"
			BlueBarRight.Image = "rbxasset://textures/ui/Settings/Slider/SelectedBarRight.png"
		
			BlueBarLeft.Name = "BlueBarLeft"
			BlueBarRight.Name = "BlueBarRight"
		
			local NameTag = Instance.new("TextButton")
			NameTag.Selectable = ChatSettings.GamepadNavigationEnabled
			NameTag.Size = UDim2.new(1, 0, 1, 0)
			NameTag.Position = UDim2.new(0, 0, 0, 0)
			NameTag.BackgroundTransparency = 1
			NameTag.Font = ChatSettings.DefaultFont
			NameTag.TextSize = ChatSettings.ChatChannelsTabTextSize
			NameTag.TextColor3 = Color3.new(1, 1, 1)
			NameTag.TextStrokeTransparency = 0.75
			NameTag.Parent = BackgroundFrame
		
			local NameTagNonSelect = NameTag:Clone()
			local NameTagSelect = NameTag:Clone()
			NameTagNonSelect.Parent = UnselectedFrame
			NameTagSelect.Parent = SelectedFrame
			NameTagNonSelect.Font = Enum.Font.SourceSans
			NameTagNonSelect.Active = false
			NameTagSelect.Active = false
		
			local NewMessageIconFrame = Instance.new("Frame")
			NewMessageIconFrame.Selectable = false
			NewMessageIconFrame.Size = UDim2.new(0, 18, 0, 18)
			NewMessageIconFrame.Position = UDim2.new(0.8, -9, 0.5, -9)
			NewMessageIconFrame.BackgroundTransparency = 1
			NewMessageIconFrame.Parent = BackgroundFrame
		
			local NewMessageIcon = Instance.new("ImageLabel")
			NewMessageIcon.Selectable = false
			NewMessageIcon.Size = UDim2.new(1, 0, 1, 0)
			NewMessageIcon.BackgroundTransparency = 1
			NewMessageIcon.Image = "rbxasset://textures/ui/Chat/MessageCounter.png"
			NewMessageIcon.Visible = false
			NewMessageIcon.Parent = NewMessageIconFrame
		
			local NewMessageIconText = Instance.new("TextLabel")
			NewMessageIconText.Selectable = false
			NewMessageIconText.BackgroundTransparency = 1
			NewMessageIconText.Size = UDim2.new(0, 13, 0, 9)
			NewMessageIconText.Position = UDim2.new(0.5, -7, 0.5, -7)
			NewMessageIconText.Font = ChatSettings.DefaultFont
			NewMessageIconText.TextSize = 14
			NewMessageIconText.TextColor3 = Color3.new(1, 1, 1)
			NewMessageIconText.Text = ""
			NewMessageIconText.Parent = NewMessageIcon
		
			return BaseFrame, NameTag, NameTagNonSelect, NameTagSelect, NewMessageIcon, UnselectedFrame, SelectedFrame
		end
		
		function methods:Destroy()
			self.GuiObject:Destroy()
		end
		
		function methods:UpdateMessagePostedInChannel(ignoreActive)
			if (self.Active and (ignoreActive ~= true)) then return end
		
			local count = self.UnreadMessageCount + 1
			self.UnreadMessageCount = count
		
			local label = self.NewMessageIcon
			label.Visible = true
			label.TextLabel.Text = (count < 100) and tostring(count) or "!"
		
			local tweenTime = 0.15
			local tweenPosOffset = UDim2.new(0, 0, -0.1, 0)
		
			local curPos = label.Position
			local outPos = curPos + tweenPosOffset
			local easingDirection = Enum.EasingDirection.Out
			local easingStyle = Enum.EasingStyle.Quad
		
			label.Position = UDim2.new(0, 0, -0.15, 0)
			label:TweenPosition(UDim2.new(0, 0, 0, 0), easingDirection, easingStyle, tweenTime, true)
		
		end
		
		function methods:SetActive(active)
			self.Active = active
			self.UnselectedFrame.Visible = not active
			self.SelectedFrame.Visible = active
		
			if (active) then
				self.UnreadMessageCount = 0
				self.NewMessageIcon.Visible = false
		
				self.NameTag.Font = Enum.Font.SourceSansBold
			else
				self.NameTag.Font = Enum.Font.SourceSans
		
			end
		end
		
		function methods:SetTextSize(textSize)
			self.NameTag.TextSize = textSize
		end
		
		function methods:FadeOutBackground(duration)
			self.AnimParams.Background_TargetTransparency = 1
			self.AnimParams.Background_NormalizedExptValue = CurveUtil:NormalizedDefaultExptValueInSeconds(duration)
		end
		
		function methods:FadeInBackground(duration)
			self.AnimParams.Background_TargetTransparency = 0.6
			self.AnimParams.Background_NormalizedExptValue = CurveUtil:NormalizedDefaultExptValueInSeconds(duration)
		end
		
		function methods:FadeOutText(duration)
			self.AnimParams.Text_TargetTransparency = 1
			self.AnimParams.Text_NormalizedExptValue = CurveUtil:NormalizedDefaultExptValueInSeconds(duration)
			self.AnimParams.TextStroke_TargetTransparency = 1
			self.AnimParams.TextStroke_NormalizedExptValue = CurveUtil:NormalizedDefaultExptValueInSeconds(duration)
		end
		
		function methods:FadeInText(duration)
			self.AnimParams.Text_TargetTransparency = 0
			self.AnimParams.Text_NormalizedExptValue = CurveUtil:NormalizedDefaultExptValueInSeconds(duration)
			self.AnimParams.TextStroke_TargetTransparency = 0.75
			self.AnimParams.TextStroke_NormalizedExptValue = CurveUtil:NormalizedDefaultExptValueInSeconds(duration)
		end
		
		function methods:AnimGuiObjects()
			self.UnselectedFrame.BackgroundTransparency = self.AnimParams.Background_CurrentTransparency
			self.SelectedFrame.BackgroundImage.BackgroundTransparency = self.AnimParams.Background_CurrentTransparency
			self.SelectedFrame.BlueBarLeft.ImageTransparency = self.AnimParams.Background_CurrentTransparency
			self.SelectedFrame.BlueBarRight.ImageTransparency = self.AnimParams.Background_CurrentTransparency
			self.NameTagNonSelect.TextTransparency = self.AnimParams.Background_CurrentTransparency
			self.NameTagNonSelect.TextStrokeTransparency = self.AnimParams.Background_CurrentTransparency
		
			self.NameTag.TextTransparency = self.AnimParams.Text_CurrentTransparency
			self.NewMessageIcon.ImageTransparency = self.AnimParams.Text_CurrentTransparency
			self.WhiteTextNewMessageNotification.TextTransparency = self.AnimParams.Text_CurrentTransparency
			self.NameTagSelect.TextTransparency = self.AnimParams.Text_CurrentTransparency
		
			self.NameTag.TextStrokeTransparency = self.AnimParams.TextStroke_CurrentTransparency
			self.WhiteTextNewMessageNotification.TextStrokeTransparency = self.AnimParams.TextStroke_CurrentTransparency
			self.NameTagSelect.TextStrokeTransparency = self.AnimParams.TextStroke_CurrentTransparency
		end
		
		function methods:InitializeAnimParams()
			self.AnimParams.Text_TargetTransparency = 0
			self.AnimParams.Text_CurrentTransparency = 0
			self.AnimParams.Text_NormalizedExptValue = CurveUtil:NormalizedDefaultExptValueInSeconds(0)
		
			self.AnimParams.TextStroke_TargetTransparency = 0.75
			self.AnimParams.TextStroke_CurrentTransparency = 0.75
			self.AnimParams.TextStroke_NormalizedExptValue = CurveUtil:NormalizedDefaultExptValueInSeconds(0)
		
			self.AnimParams.Background_TargetTransparency = 0.6
			self.AnimParams.Background_CurrentTransparency = 0.6
			self.AnimParams.Background_NormalizedExptValue = CurveUtil:NormalizedDefaultExptValueInSeconds(0)
		end
		
		function methods:Update(dtScale)
			self.AnimParams.Background_CurrentTransparency = CurveUtil:Expt(
					self.AnimParams.Background_CurrentTransparency,
					self.AnimParams.Background_TargetTransparency,
					self.AnimParams.Background_NormalizedExptValue,
					dtScale
			)
			self.AnimParams.Text_CurrentTransparency = CurveUtil:Expt(
					self.AnimParams.Text_CurrentTransparency,
					self.AnimParams.Text_TargetTransparency,
					self.AnimParams.Text_NormalizedExptValue,
					dtScale
			)
			self.AnimParams.TextStroke_CurrentTransparency = CurveUtil:Expt(
					self.AnimParams.TextStroke_CurrentTransparency,
					self.AnimParams.TextStroke_TargetTransparency,
					self.AnimParams.TextStroke_NormalizedExptValue,
					dtScale
			)
		
			self:AnimGuiObjects()
		end
		
		--///////////////////////// Constructors
		--//////////////////////////////////////
		
		function module.new(channelName)
			local obj = setmetatable({}, methods)
		
			local BaseFrame, NameTag, NameTagNonSelect, NameTagSelect, NewMessageIcon, UnselectedFrame, SelectedFrame = CreateGuiObjects()
			obj.GuiObject = BaseFrame
			obj.NameTag = NameTag
			obj.NameTagNonSelect = NameTagNonSelect
			obj.NameTagSelect = NameTagSelect
			obj.NewMessageIcon = NewMessageIcon
			obj.UnselectedFrame = UnselectedFrame
			obj.SelectedFrame = SelectedFrame
		
			obj.BlueBarLeft = SelectedFrame.BlueBarLeft
			obj.BlueBarRight = SelectedFrame.BlueBarRight
			obj.BackgroundImage = SelectedFrame.BackgroundImage
			obj.WhiteTextNewMessageNotification = obj.NewMessageIcon.TextLabel
		
			obj.ChannelName = channelName
			obj.UnreadMessageCount = 0
			obj.Active = false
		
			obj.GuiObject.Name = "Frame_" .. obj.ChannelName
		
			if (string.len(channelName) > ChatSettings.MaxChannelNameLength) then
				channelName = string.sub(channelName, 1, ChatSettings.MaxChannelNameLength - 3) .. "..."
			end
		
			--obj.NameTag.Text = channelName
		
			obj.NameTag.Text = ""
			obj.NameTagNonSelect.Text = channelName
			obj.NameTagSelect.Text = channelName
		
			obj.AnimParams = {}
		
			obj:InitializeAnimParams()
			obj:AnimGuiObjects()
			obj:SetActive(false)
		
			return obj
		end
		
		return module
		
	end
	fake_module_scripts[script] = module_script
end
do -- nil.ObjectPool
	local script = Instance.new('ModuleScript', chatmain)
	script.Name = "ObjectPool"
	local function module_script()
		--	// FileName: ObjectPool.lua
		--	// Written by: TheGamer101
		--	// Description: An object pool class used to avoid unnecessarily instantiating Instances.
		
		local module = {}
		--////////////////////////////// Include
		--//////////////////////////////////////
		
		--////////////////////////////// Methods
		--//////////////////////////////////////
		local methods = {}
		methods.__index = methods
		
		function methods:GetInstance(className)
		  if self.InstancePoolsByClass[className] == nil then
		    self.InstancePoolsByClass[className] = {}
		  end
		  local availableInstances = #self.InstancePoolsByClass[className]
		  if availableInstances > 0 then
		    local instance = self.InstancePoolsByClass[className][availableInstances]
		    table.remove(self.InstancePoolsByClass[className])
		    return instance
		  end
		  return Instance.new(className)
		end
		
		function methods:ReturnInstance(instance)
		  if self.InstancePoolsByClass[instance.ClassName] == nil then
		    self.InstancePoolsByClass[instance.ClassName] = {}
		  end
		  if #self.InstancePoolsByClass[instance.ClassName] < self.PoolSizePerType then
		    table.insert(self.InstancePoolsByClass[instance.ClassName], instance)
		  else
		    instance:Destroy()
		  end
		end
		
		--///////////////////////// Constructors
		--//////////////////////////////////////
		
		function module.new(poolSizePerType)
			local obj = setmetatable({}, methods)
			obj.InstancePoolsByClass = {}
			obj.Name = "ObjectPool"
		  obj.PoolSizePerType = poolSizePerType
		
			return obj
		end
		
		return module
		
	end
	fake_module_scripts[script] = module_script
end
do -- nil.CommandProcessor
	local script = Instance.new('ModuleScript', chatmain)
	script.Name = "CommandProcessor"
	local function module_script()
		--!nonstrict
		--	// FileName: ProcessCommands.lua
		--	// Written by: TheGamer101
		--	// Description: Module for processing commands using the client CommandModules
		
		local module = {}
		local methods = {}
		methods.__index = methods
		
		--////////////////////////////// Include
		--//////////////////////////////////////
		local Chat = game:GetService("Chat")
		local clientChatModules = Chat:WaitForChild("ClientChatModules")
		local commandModules = clientChatModules:WaitForChild("CommandModules")
		local commandUtil = require(commandModules:WaitForChild("Util"))
		local modulesFolder = script.Parent
		local ChatSettings = require(clientChatModules:WaitForChild("ChatSettings"))
		
		function methods:SetupCommandProcessors()
			local commands = commandModules:GetChildren()
			for i = 1, #commands do
				if commands[i]:IsA("ModuleScript") then
					if commands[i].Name ~= "Util" then
						local commandProcessor = require(commands[i])
						local processorType = commandProcessor[commandUtil.KEY_COMMAND_PROCESSOR_TYPE]
						local processorFunction = commandProcessor[commandUtil.KEY_PROCESSOR_FUNCTION]
						if processorType == commandUtil.IN_PROGRESS_MESSAGE_PROCESSOR then
							table.insert(self.InProgressMessageProcessors, processorFunction)
						elseif processorType == commandUtil.COMPLETED_MESSAGE_PROCESSOR then
							table.insert(self.CompletedMessageProcessors, processorFunction)
						end
					end
				end
			end
		end
		
		function methods:ProcessCompletedChatMessage(message, ChatWindow)
			for i = 1, #self.CompletedMessageProcessors do
				local processedCommand = self.CompletedMessageProcessors[i](message, ChatWindow, ChatSettings)
				if processedCommand then
					return true
				end
			end
			return false
		end
		
		function methods:ProcessInProgressChatMessage(message, ChatWindow, ChatBar)
			for i = 1, #self.InProgressMessageProcessors do
				local customState = self.InProgressMessageProcessors[i](message, ChatWindow, ChatBar, ChatSettings)
				if customState then
					return customState
				end
			end
			return nil
		end
		
		--///////////////////////// Constructors
		--//////////////////////////////////////
		
		function module.new()
			local obj = setmetatable({}, methods)
		
			obj.CompletedMessageProcessors = {}
			obj.InProgressMessageProcessors = {}
		
			obj:SetupCommandProcessors()
		
			return obj
		end
		
		return module
		
	end
	fake_module_scripts[script] = module_script
end
do -- nil.CurveUtil
	local script = Instance.new('ModuleScript', chatmain)
	script.Name = "CurveUtil"
	local function module_script()
		--!nonstrict
		local CurveUtil = {	}
		local DEFAULT_THRESHOLD = 0.01
		
		function CurveUtil:Expt(start, to, pct, dt_scale)
			if math.abs(to - start) < DEFAULT_THRESHOLD then
				return to
			end
		
			local y = CurveUtil:Expty(start,to,pct,dt_scale)
		
			--rtv = start + (to - start) * timescaled_friction--
			local delta = (to - start) * y
			return start + delta
		end
		
		function CurveUtil:Expty(start, to, pct, dt_scale)
			--y = e ^ (-a * timescale)--
			local friction = 1 - pct
			local a = -math.log(friction)
			return 1 - math.exp(-a * dt_scale)
		end
		
		function CurveUtil:Sign(val)
			if val > 0 then
				return 1
			elseif val < 0 then
				return -1
			else
				return 0
			end
		end
		
		function CurveUtil:BezierValForT(p0, p1, p2, p3, t)
			local cp0 = (1 - t) * (1 - t) * (1 - t)
			local cp1 = 3 * t * (1-t)*(1-t)
			local cp2 = 3 * t * t * (1 - t)
			local cp3 = t * t * t
			return cp0 * p0 + cp1 * p1 + cp2 * p2 + cp3 * p3
		end
		
		CurveUtil._BezierPt2ForT = { x = 0; y = 0 }
		function CurveUtil:BezierPt2ForT(
			p0x, p0y,
			p1x, p1y,
			p2x, p2y,
			p3x, p3y,
			t)
		
			CurveUtil._BezierPt2ForT.x = CurveUtil:BezierValForT(p0x,p1x,p2x,p3x,t)
			CurveUtil._BezierPt2ForT.y = CurveUtil:BezierValForT(p0y,p1y,p2y,p3y,t)
			return CurveUtil._BezierPt2ForT
		end
		
		function CurveUtil:YForPointOf2PtLine(pt1, pt2, x)
			--(y - y1)/(x - x1) = m--
			local m = (pt1.y - pt2.y) / (pt1.x - pt2.x)
			--y - mx = b--
			local b = pt1.y - m * pt1.x
			return m * x + b
		end
		
		function CurveUtil:DeltaTimeToTimescale(s_frame_delta_time)
			return s_frame_delta_time / (1.0 / 60.0)
		end
		
		function CurveUtil:SecondsToTick(sec)
			return (1 / 60.0) / sec
		end
		
		function CurveUtil:ExptValueInSeconds(threshold, start, seconds)
				return 1 - math.pow((threshold / start), 1 / (60.0 * seconds))
		end
		
		function CurveUtil:NormalizedDefaultExptValueInSeconds(seconds)
				return self:ExptValueInSeconds(DEFAULT_THRESHOLD, 1, seconds)
		end
		
		return CurveUtil
		
	end
	fake_module_scripts[script] = module_script
end
do -- nil.ChannelsBar
	local script = Instance.new('ModuleScript', chatmain)
	script.Name = "ChannelsBar"
	local function module_script()
		--!nonstrict
		--	// FileName: ChannelsBar.lua
		--	// Written by: Xsitsu
		--	// Description: Manages creating, destroying, and displaying ChannelTabs.
		
		local module = {}
		
		--////////////////////////////// Include
		--//////////////////////////////////////
		local Chat = game:GetService("Chat")
		local clientChatModules = Chat:WaitForChild("ClientChatModules")
		local modulesFolder = script.Parent
		local moduleChannelsTab = require(modulesFolder:WaitForChild("ChannelsTab"))
		local MessageSender = require(modulesFolder:WaitForChild("MessageSender"))
		local ChatSettings = require(clientChatModules:WaitForChild("ChatSettings"))
		local CurveUtil = require(modulesFolder:WaitForChild("CurveUtil"))
		
		--////////////////////////////// Methods
		--//////////////////////////////////////
		local methods = {}
		methods.__index = methods
		
		function methods:CreateGuiObjects(targetParent)
			local BaseFrame = Instance.new("Frame")
			BaseFrame.Selectable = false
			BaseFrame.Size = UDim2.new(1, 0, 1, 0)
			BaseFrame.BackgroundTransparency = 1
			BaseFrame.Parent = targetParent
		
			local ScrollingBase = Instance.new("Frame")
			ScrollingBase.Selectable = false
			ScrollingBase.Name = "ScrollingBase"
			ScrollingBase.BackgroundTransparency = 1
			ScrollingBase.ClipsDescendants = true
			ScrollingBase.Size = UDim2.new(1, 0, 1, 0)
			ScrollingBase.Position = UDim2.new(0, 0, 0, 0)
			ScrollingBase.Parent = BaseFrame
		
			local ScrollerSizer = Instance.new("Frame")
			ScrollerSizer.Selectable = false
			ScrollerSizer.Name = "ScrollerSizer"
			ScrollerSizer.BackgroundTransparency = 1
			ScrollerSizer.Size = UDim2.new(1, 0, 1, 0)
			ScrollerSizer.Position = UDim2.new(0, 0, 0, 0)
			ScrollerSizer.Parent = ScrollingBase
		
			local ScrollerFrame = Instance.new("Frame")
			ScrollerFrame.Selectable = false
			ScrollerFrame.Name = "ScrollerFrame"
			ScrollerFrame.BackgroundTransparency = 1
			ScrollerFrame.Size = UDim2.new(1, 0, 1, 0)
			ScrollerFrame.Position = UDim2.new(0, 0, 0, 0)
			ScrollerFrame.Parent = ScrollerSizer
		
			local LeaveConfirmationFrameBase = Instance.new("Frame")
			LeaveConfirmationFrameBase.Selectable = false
			LeaveConfirmationFrameBase.Size = UDim2.new(1, 0, 1, 0)
			LeaveConfirmationFrameBase.Position = UDim2.new(0, 0, 0, 0)
			LeaveConfirmationFrameBase.ClipsDescendants = true
			LeaveConfirmationFrameBase.BackgroundTransparency = 1
			LeaveConfirmationFrameBase.Parent = BaseFrame
		
			local LeaveConfirmationFrame = Instance.new("Frame")
			LeaveConfirmationFrame.Selectable = false
			LeaveConfirmationFrame.Name = "LeaveConfirmationFrame"
			LeaveConfirmationFrame.Size = UDim2.new(1, 0, 1, 0)
			LeaveConfirmationFrame.Position = UDim2.new(0, 0, 1, 0)
			LeaveConfirmationFrame.BackgroundTransparency = 0.6
			LeaveConfirmationFrame.BorderSizePixel = 0
			LeaveConfirmationFrame.BackgroundColor3 = Color3.new(0, 0, 0)
			LeaveConfirmationFrame.Parent = LeaveConfirmationFrameBase
		
			local InputBlocker = Instance.new("TextButton")
			InputBlocker.Selectable = false
			InputBlocker.Size = UDim2.new(1, 0, 1, 0)
			InputBlocker.BackgroundTransparency = 1
			InputBlocker.Text = ""
			InputBlocker.Parent = LeaveConfirmationFrame
		
			local LeaveConfirmationButtonYes = Instance.new("TextButton")
			LeaveConfirmationButtonYes.Selectable = false
			LeaveConfirmationButtonYes.Size = UDim2.new(0.25, 0, 1, 0)
			LeaveConfirmationButtonYes.BackgroundTransparency = 1
			LeaveConfirmationButtonYes.Font = ChatSettings.DefaultFont
			LeaveConfirmationButtonYes.TextSize = 18
			LeaveConfirmationButtonYes.TextStrokeTransparency = 0.75
			LeaveConfirmationButtonYes.Position = UDim2.new(0, 0, 0, 0)
			LeaveConfirmationButtonYes.TextColor3 = Color3.new(0, 1, 0)
			LeaveConfirmationButtonYes.Text = "Confirm"
			LeaveConfirmationButtonYes.Parent = LeaveConfirmationFrame
		
			local LeaveConfirmationButtonNo = LeaveConfirmationButtonYes:Clone()
			LeaveConfirmationButtonNo.Parent = LeaveConfirmationFrame
			LeaveConfirmationButtonNo.Position = UDim2.new(0.75, 0, 0, 0)
			LeaveConfirmationButtonNo.TextColor3 = Color3.new(1, 0, 0)
			LeaveConfirmationButtonNo.Text = "Cancel"
		
			local LeaveConfirmationNotice = Instance.new("TextLabel")
			LeaveConfirmationNotice.Selectable = false
			LeaveConfirmationNotice.Size = UDim2.new(0.5, 0, 1, 0)
			LeaveConfirmationNotice.Position = UDim2.new(0.25, 0, 0, 0)
			LeaveConfirmationNotice.BackgroundTransparency = 1
			LeaveConfirmationNotice.TextColor3 = Color3.new(1, 1, 1)
			LeaveConfirmationNotice.TextStrokeTransparency = 0.75
			LeaveConfirmationNotice.Text = "Leave channel <XX>?"
			LeaveConfirmationNotice.Font = ChatSettings.DefaultFont
			LeaveConfirmationNotice.TextSize = 18
			LeaveConfirmationNotice.Parent = LeaveConfirmationFrame
		
			local LeaveTarget = Instance.new("StringValue")
			LeaveTarget.Name = "LeaveTarget"
			LeaveTarget.Parent = LeaveConfirmationFrame
		
			local outPos = LeaveConfirmationFrame.Position
			LeaveConfirmationButtonYes.MouseButton1Click:connect(function()
				MessageSender:SendMessage(string.format("/leave %s", LeaveTarget.Value), nil)
				LeaveConfirmationFrame:TweenPosition(outPos, Enum.EasingDirection.Out, Enum.EasingStyle.Quad, 0.2, true)
			end)
			LeaveConfirmationButtonNo.MouseButton1Click:connect(function()
				LeaveConfirmationFrame:TweenPosition(outPos, Enum.EasingDirection.Out, Enum.EasingStyle.Quad, 0.2, true)
			end)
		
		
		
			local scale = 0.7
			local scaleOther = (1 - scale) / 2
			local pageButtonImage = "rbxasset://textures/ui/Chat/TabArrowBackground.png"
			local pageButtonArrowImage = "rbxasset://textures/ui/Chat/TabArrow.png"
		
			--// ToDo: Remove these lines when the assets are put into trunk.
			--// These grab unchanging versions hosted on the site, and not from the content folder.
			pageButtonImage = "rbxassetid://471630199"
			pageButtonArrowImage = "rbxassetid://471630112"
		
		
			local PageLeftButton = Instance.new("ImageButton", BaseFrame)
			PageLeftButton.Selectable = ChatSettings.GamepadNavigationEnabled
			PageLeftButton.Name = "PageLeftButton"
			PageLeftButton.SizeConstraint = Enum.SizeConstraint.RelativeYY
			PageLeftButton.Size = UDim2.new(scale, 0, scale, 0)
			PageLeftButton.BackgroundTransparency = 1
			PageLeftButton.Position = UDim2.new(0, 4, scaleOther, 0)
			PageLeftButton.Visible = false
			PageLeftButton.Image = pageButtonImage
			local ArrowLabel = Instance.new("ImageLabel", PageLeftButton)
			ArrowLabel.Name = "ArrowLabel"
			ArrowLabel.BackgroundTransparency = 1
			ArrowLabel.Size = UDim2.new(0.4, 0, 0.4, 0)
			ArrowLabel.Image = pageButtonArrowImage
		
			local PageRightButtonPositionalHelper = Instance.new("Frame", BaseFrame)
			PageRightButtonPositionalHelper.Selectable = false
			PageRightButtonPositionalHelper.BackgroundTransparency = 1
			PageRightButtonPositionalHelper.Name = "PositionalHelper"
			PageRightButtonPositionalHelper.Size = PageLeftButton.Size
			PageRightButtonPositionalHelper.SizeConstraint = PageLeftButton.SizeConstraint
			PageRightButtonPositionalHelper.Position = UDim2.new(1, 0, scaleOther, 0)
		
			local PageRightButton = PageLeftButton:Clone()
			PageRightButton.Parent = PageRightButtonPositionalHelper
			PageRightButton.Name = "PageRightButton"
			PageRightButton.Size = UDim2.new(1, 0, 1, 0)
			PageRightButton.SizeConstraint = Enum.SizeConstraint.RelativeXY
			PageRightButton.Position = UDim2.new(-1, -4, 0, 0)
		
			local positionOffset = UDim2.new(0.05, 0, 0, 0)
		
			PageRightButton.ArrowLabel.Position = UDim2.new(0.3, 0, 0.3, 0) + positionOffset
			PageLeftButton.ArrowLabel.Position = UDim2.new(0.3, 0, 0.3, 0) - positionOffset
			PageLeftButton.ArrowLabel.Rotation = 180
		
		
			self.GuiObject = BaseFrame
		
			self.GuiObjects.BaseFrame = BaseFrame
			self.GuiObjects.ScrollerSizer = ScrollerSizer
			self.GuiObjects.ScrollerFrame = ScrollerFrame
			self.GuiObjects.PageLeftButton = PageLeftButton
			self.GuiObjects.PageRightButton = PageRightButton
			self.GuiObjects.LeaveConfirmationFrame = LeaveConfirmationFrame
			self.GuiObjects.LeaveConfirmationNotice = LeaveConfirmationNotice
		
			self.GuiObjects.PageLeftButtonArrow = PageLeftButton.ArrowLabel
			self.GuiObjects.PageRightButtonArrow = PageRightButton.ArrowLabel
			self:AnimGuiObjects()
		
			PageLeftButton.MouseButton1Click:connect(function() self:ScrollChannelsFrame(-1) end)
			PageRightButton.MouseButton1Click:connect(function() self:ScrollChannelsFrame(1) end)
		
			self:ScrollChannelsFrame(0)
		end
		
		
		function methods:UpdateMessagePostedInChannel(channelName)
			local tab = self:GetChannelTab(channelName)
			if (tab) then
				tab:UpdateMessagePostedInChannel()
			else
				warn("ChannelsTab '" .. channelName .. "' does not exist!")
			end
		end
		
		function methods:AddChannelTab(channelName)
			if (self:GetChannelTab(channelName)) then
				error("Channel tab '" .. channelName .. "'already exists!")
			end
		
			local tab = moduleChannelsTab.new(channelName)
			tab.GuiObject.Parent = self.GuiObjects.ScrollerFrame
			self.ChannelTabs[channelName:lower()] = tab
		
			self.NumTabs = self.NumTabs + 1
			self:OrganizeChannelTabs()
		
			if (ChatSettings.RightClickToLeaveChannelEnabled) then
				tab.NameTag.MouseButton2Click:connect(function()
					self.LeaveConfirmationNotice.Text = string.format("Leave channel %s?", tab.ChannelName)
					self.LeaveConfirmationFrame.LeaveTarget.Value = tab.ChannelName
					self.LeaveConfirmationFrame:TweenPosition(UDim2.new(0, 0, 0, 0), Enum.EasingDirection.In, Enum.EasingStyle.Quad, 0.2, true)
				end)
			end
		
			return tab
		end
		
		function methods:RemoveChannelTab(channelName)
			if (not self:GetChannelTab(channelName)) then
				error("Channel tab '" .. channelName .. "'does not exist!")
			end
		
			local indexName = channelName:lower()
			self.ChannelTabs[indexName]:Destroy()
			self.ChannelTabs[indexName] = nil
		
			self.NumTabs = self.NumTabs - 1
			self:OrganizeChannelTabs()
		end
		
		function methods:GetChannelTab(channelName)
			return self.ChannelTabs[channelName:lower()]
		end
		
		function methods:OrganizeChannelTabs()
			local order = {}
		
			table.insert(order, self:GetChannelTab(ChatSettings.GeneralChannelName))
			table.insert(order, self:GetChannelTab("System"))
		
			for tabIndexName, tab in pairs(self.ChannelTabs) do
				if (tab.ChannelName ~= ChatSettings.GeneralChannelName and tab.ChannelName ~= "System") then
					table.insert(order, tab)
				end
			end
		
			for index, tab in pairs(order) do
				tab.GuiObject.Position = UDim2.new(index - 1, 0, 0, 0)
			end
		
			--// Dynamic tab resizing
			self.GuiObjects.ScrollerSizer.Size = UDim2.new(1 / math.max(1, math.min(ChatSettings.ChannelsBarFullTabSize, self.NumTabs)), 0, 1, 0)
		
			self:ScrollChannelsFrame(0)
		end
		
		function methods:ResizeChannelTabText(textSize)
			for i, tab in pairs(self.ChannelTabs) do
				tab:SetTextSize(textSize)
			end
		end
		
		function methods:ScrollChannelsFrame(dir)
			if (self.ScrollChannelsFrameLock) then return end
			self.ScrollChannelsFrameLock = true
		
			local tabNumber = ChatSettings.ChannelsBarFullTabSize
		
			local newPageNum = self.CurPageNum + dir
			if (newPageNum < 0) then
				newPageNum = 0
			elseif (newPageNum > 0 and newPageNum + tabNumber > self.NumTabs) then
				newPageNum = self.NumTabs - tabNumber
			end
		
			self.CurPageNum = newPageNum
		
			local tweenTime = 0.15
			local endPos = UDim2.new(-self.CurPageNum, 0, 0, 0)
		
			self.GuiObjects.PageLeftButton.Visible = (self.CurPageNum > 0)
			self.GuiObjects.PageRightButton.Visible = (self.CurPageNum + tabNumber < self.NumTabs)
		
			if dir == 0 then
				self.ScrollChannelsFrameLock = false
				return
			end
		
			local function UnlockFunc()
				self.ScrollChannelsFrameLock = false
			end
		
			self:WaitUntilParentedCorrectly()
		
			self.GuiObjects.ScrollerFrame:TweenPosition(endPos, Enum.EasingDirection.InOut, Enum.EasingStyle.Quad, tweenTime, true, UnlockFunc)
		end
		
		function methods:FadeOutBackground(duration)
			for channelName, channelObj in pairs(self.ChannelTabs) do
				channelObj:FadeOutBackground(duration)
			end
		
			self.AnimParams.Background_TargetTransparency = 1
			self.AnimParams.Background_NormalizedExptValue = CurveUtil:NormalizedDefaultExptValueInSeconds(duration)
		end
		
		function methods:FadeInBackground(duration)
			for channelName, channelObj in pairs(self.ChannelTabs) do
				channelObj:FadeInBackground(duration)
			end
		
			self.AnimParams.Background_TargetTransparency = 0.6
			self.AnimParams.Background_NormalizedExptValue = CurveUtil:NormalizedDefaultExptValueInSeconds(duration)
		end
		
		function methods:FadeOutText(duration)
			for channelName, channelObj in pairs(self.ChannelTabs) do
				channelObj:FadeOutText(duration)
			end
		end
		
		function methods:FadeInText(duration)
			for channelName, channelObj in pairs(self.ChannelTabs) do
				channelObj:FadeInText(duration)
			end
		end
		
		function methods:AnimGuiObjects()
			self.GuiObjects.PageLeftButton.ImageTransparency = self.AnimParams.Background_CurrentTransparency
			self.GuiObjects.PageRightButton.ImageTransparency = self.AnimParams.Background_CurrentTransparency
			self.GuiObjects.PageLeftButtonArrow.ImageTransparency = self.AnimParams.Background_CurrentTransparency
			self.GuiObjects.PageRightButtonArrow.ImageTransparency = self.AnimParams.Background_CurrentTransparency
		end
		
		function methods:InitializeAnimParams()
			self.AnimParams.Background_TargetTransparency = 0.6
			self.AnimParams.Background_CurrentTransparency = 0.6
			self.AnimParams.Background_NormalizedExptValue = CurveUtil:NormalizedDefaultExptValueInSeconds(0)
		end
		
		function methods:Update(dtScale)
			for channelName, channelObj in pairs(self.ChannelTabs) do
				channelObj:Update(dtScale)
			end
		
			self.AnimParams.Background_CurrentTransparency = CurveUtil:Expt(
					self.AnimParams.Background_CurrentTransparency,
					self.AnimParams.Background_TargetTransparency,
					self.AnimParams.Background_NormalizedExptValue,
					dtScale
			)
		
			self:AnimGuiObjects()
		end
		
		--// ToDo: Move to common modules
		function methods:WaitUntilParentedCorrectly()
			while (not self.GuiObject:IsDescendantOf(game:GetService("Players").LocalPlayer)) do
				self.GuiObject.AncestryChanged:wait()
			end
		end
		
		--///////////////////////// Constructors
		--//////////////////////////////////////
		
		function module.new()
			local obj = setmetatable({}, methods)
		
			obj.GuiObject = nil
			obj.GuiObjects = {}
		
			obj.ChannelTabs = {}
			obj.NumTabs = 0
			obj.CurPageNum = 0
		
			obj.ScrollChannelsFrameLock = false
		
			obj.AnimParams = {}
		
			obj:InitializeAnimParams()
		
			ChatSettings.SettingsChanged:connect(function(setting, value)
				if (setting == "ChatChannelsTabTextSize") then
					obj:ResizeChannelTabText(value)
				end
			end)
		
			return obj
		end
		
		return module
		
	end
	fake_module_scripts[script] = module_script
end
do -- nil.MessageLogDisplay
	local script = Instance.new('ModuleScript', chatmain)
	script.Name = "MessageLogDisplay"
	local function module_script()
		--!nonstrict
		--	// FileName: MessageLogDisplay.lua
		--	// Written by: Xsitsu, TheGamer101
		--	// Description: ChatChannel window for displaying messages.
		
		local UserFlagRemoveMessageOnTextFilterFailures do
			local success, value = pcall(function()
				return UserSettings():IsUserFeatureEnabled("UserRemoveMessageOnTextFilterFailures")
			end)
			UserFlagRemoveMessageOnTextFilterFailures = success and value
		end
		
		local userIsChatTranslationEnabled = false
		do
			local success, value = pcall(function()
				return UserSettings():IsUserFeatureEnabled("UserIsChatTranslationEnabled2")
			end)
			userIsChatTranslationEnabled = success and value
		end
		
		local module = {}
		module.ScrollBarThickness = 4
		
		--////////////////////////////// Include
		--//////////////////////////////////////
		local Chat = game:GetService("Chat")
		local clientChatModules = Chat:WaitForChild("ClientChatModules")
		local modulesFolder = script.Parent
		local moduleMessageLabelCreator = require(modulesFolder:WaitForChild("MessageLabelCreator"))
		local CurveUtil = require(modulesFolder:WaitForChild("CurveUtil"))
		
		local ChatSettings = require(clientChatModules:WaitForChild("ChatSettings"))
		
		local MessageLabelCreator = moduleMessageLabelCreator.new()
		
		--////////////////////////////// Methods
		--//////////////////////////////////////
		local methods = {}
		methods.__index = methods
		
		
		local function CreateGuiObjects()
			local BaseFrame = Instance.new("Frame")
			BaseFrame.Selectable = false
			BaseFrame.Size = UDim2.new(1, 0, 1, 0)
			BaseFrame.BackgroundTransparency = 1
		
			local Scroller = Instance.new("ScrollingFrame")
			Scroller.Selectable = ChatSettings.GamepadNavigationEnabled
			Scroller.Name = "Scroller"
			Scroller.BackgroundTransparency = 1
			Scroller.BorderSizePixel = 0
			Scroller.Position = UDim2.new(0, 0, 0, 3)
			Scroller.Size = UDim2.new(1, -4, 1, -6)
			Scroller.CanvasSize = UDim2.new(0, 0, 0, 0)
			Scroller.ScrollBarThickness = module.ScrollBarThickness
			Scroller.Active = true
			Scroller.Parent = BaseFrame
		
			local Layout = Instance.new("UIListLayout")
			Layout.SortOrder = Enum.SortOrder.LayoutOrder
			Layout.Parent = Scroller
		
			return BaseFrame, Scroller, Layout
		end
		
		function methods:Destroy()
			self.GuiObject:Destroy()
			self.Destroyed = true
		end
		
		function methods:SetActive(active)
			self.GuiObject.Visible = active
		end
		
		function methods:UpdateMessageFiltered(messageData)
			local messageObject = nil
			local searchIndex = 1
			local searchTable = self.MessageObjectLog
		
			while (#searchTable >= searchIndex) do
				local obj = searchTable[searchIndex]
		
				if obj.ID == messageData.ID then
					messageObject = obj
					break
				end
		
				searchIndex = searchIndex + 1
			end
		
			if messageObject then
				if UserFlagRemoveMessageOnTextFilterFailures then
					if messageData.Message == "" then
						self:RemoveMessageAtIndex(searchIndex)
					else
						messageObject.UpdateTextFunction(messageData)
						self:PositionMessageLabelInWindow(messageObject, searchIndex)
					end
				else
					messageObject.UpdateTextFunction(messageData)
					self:PositionMessageLabelInWindow(messageObject, searchIndex)
				end
			end
		end
		
		function methods:RefreshMessagePlacement(messageData)
			local messageObject = nil
			local searchIndex = 1
			local searchTable = self.MessageObjectLog
		
			while (#searchTable >= searchIndex) do
				local obj = searchTable[searchIndex]
		
				if obj.ID == messageData.ID then
					messageObject = obj
					break
				end
		
				searchIndex = searchIndex + 1
			end
		
			if messageObject then
				self:PositionMessageLabelInWindow(messageObject, searchIndex)
			end
		end
		
		
		function methods:AddMessage(messageData)
			self:WaitUntilParentedCorrectly()
			
			local messageObject
			if userIsChatTranslationEnabled then
				local refreshCallback = function()
					self:RefreshMessagePlacement(messageData)
				end
				
				messageObject = MessageLabelCreator:CreateMessageLabel_Chat(messageData, self.CurrentChannelName, refreshCallback)
			else
				messageObject = MessageLabelCreator:CreateMessageLabel(messageData, self.CurrentChannelName)
			end
		
			if messageObject == nil then
				return
			end
		
			table.insert(self.MessageObjectLog, messageObject)
			self:PositionMessageLabelInWindow(messageObject, #self.MessageObjectLog)
		end
		
		function methods:RemoveMessageAtIndex(index)
			self:WaitUntilParentedCorrectly()
		
			local removeThis = self.MessageObjectLog[index]
		
			if removeThis then
				removeThis:Destroy()
				table.remove(self.MessageObjectLog, index)
			end
		end
		
		function methods:AddMessageAtIndex(messageData, index)
			local messageObject
			if userIsChatTranslationEnabled then
				local refreshCallback = function()
					self:RefreshMessagePlacement(messageData)
				end
				
				messageObject = MessageLabelCreator:CreateMessageLabel_Chat(messageData, self.CurrentChannelName, refreshCallback)
			else
				messageObject = MessageLabelCreator:CreateMessageLabel(messageData, self.CurrentChannelName)
			end
			
			if messageObject == nil then
				return
			end
		
			table.insert(self.MessageObjectLog, index, messageObject)
		
			self:PositionMessageLabelInWindow(messageObject, index)
		end
		
		function methods:RemoveLastMessage()
			self:WaitUntilParentedCorrectly()
		
			local lastMessage = self.MessageObjectLog[1]
		
			lastMessage:Destroy()
			table.remove(self.MessageObjectLog, 1)
		end
		
		function methods:IsScrolledDown()
			local yCanvasSize = self.Scroller.CanvasSize.Y.Offset
			local yContainerSize = self.Scroller.AbsoluteWindowSize.Y
			local yScrolledPosition = self.Scroller.CanvasPosition.Y
		
			return (yCanvasSize < yContainerSize or
				yCanvasSize - yScrolledPosition <= yContainerSize + 5)
		end
		
		function methods:UpdateMessageTextHeight(messageObject)
			local baseFrame = messageObject.BaseFrame
			for i = 1, 10 do
				if messageObject.BaseMessage.TextFits then
					break
				end
		
				local trySize = self.Scroller.AbsoluteSize.X - i
				baseFrame.Size = UDim2.new(1, 0, 0, messageObject.GetHeightFunction(trySize))
			end
		end
		
		function methods:PositionMessageLabelInWindow(messageObject, index)
			self:WaitUntilParentedCorrectly()
		
			local wasScrolledDown = self:IsScrolledDown()
		
			local baseFrame = messageObject.BaseFrame
		
			local layoutOrder = 1
			if self.MessageObjectLog[index - 1] then
				if index == #self.MessageObjectLog then
					layoutOrder = self.MessageObjectLog[index - 1].BaseFrame.LayoutOrder + 1
				else
					layoutOrder = self.MessageObjectLog[index - 1].BaseFrame.LayoutOrder
				end
			end
			baseFrame.LayoutOrder = layoutOrder
		
			baseFrame.Size = UDim2.new(1, 0, 0, messageObject.GetHeightFunction(self.Scroller.AbsoluteSize.X))
			baseFrame.Parent = self.Scroller
		
			if messageObject.BaseMessage then
				self:UpdateMessageTextHeight(messageObject)
			end
		
			if wasScrolledDown then
				self.Scroller.CanvasPosition = Vector2.new(
					0, math.max(0, self.Scroller.CanvasSize.Y.Offset - self.Scroller.AbsoluteSize.Y))
			end
		end
		
		function methods:ReorderAllMessages()
			self:WaitUntilParentedCorrectly()
		
			--// Reordering / reparenting with a size less than 1 causes weird glitches to happen
			-- with scrolling as repositioning happens.
			if self.GuiObject.AbsoluteSize.Y < 1 then return end
		
			local oldCanvasPositon = self.Scroller.CanvasPosition
			local wasScrolledDown = self:IsScrolledDown()
		
			for _, messageObject in pairs(self.MessageObjectLog) do
				self:UpdateMessageTextHeight(messageObject)
			end
		
			if not wasScrolledDown then
				self.Scroller.CanvasPosition = oldCanvasPositon
			else
				self.Scroller.CanvasPosition = Vector2.new(
					0, math.max(0, self.Scroller.CanvasSize.Y.Offset - self.Scroller.AbsoluteSize.Y))
			end
		end
		
		function methods:Clear()
			for _, v in pairs(self.MessageObjectLog) do
				v:Destroy()
			end
			self.MessageObjectLog = {}
		end
		
		function methods:SetCurrentChannelName(name)
			self.CurrentChannelName = name
		end
		
		function methods:FadeOutBackground(duration)
			--// Do nothing
		end
		
		function methods:FadeInBackground(duration)
			--// Do nothing
		end
		
		function methods:FadeOutText(duration)
			for i = 1, #self.MessageObjectLog do
				if self.MessageObjectLog[i].FadeOutFunction then
					self.MessageObjectLog[i].FadeOutFunction(duration, CurveUtil)
				end
			end
		end
		
		function methods:FadeInText(duration)
			for i = 1, #self.MessageObjectLog do
				if self.MessageObjectLog[i].FadeInFunction then
					self.MessageObjectLog[i].FadeInFunction(duration, CurveUtil)
				end
			end
		end
		
		function methods:Update(dtScale)
			for i = 1, #self.MessageObjectLog do
				if self.MessageObjectLog[i].UpdateAnimFunction then
					self.MessageObjectLog[i].UpdateAnimFunction(dtScale, CurveUtil)
				end
			end
		end
		
		--// ToDo: Move to common modules
		function methods:WaitUntilParentedCorrectly()
			while (not self.GuiObject:IsDescendantOf(game:GetService("Players").LocalPlayer)) do
				self.GuiObject.AncestryChanged:wait()
			end
		end
		
		--///////////////////////// Constructors
		--//////////////////////////////////////
		
		function module.new()
			local obj = setmetatable({}, methods)
			obj.Destroyed = false
		
			local BaseFrame, Scroller, Layout = CreateGuiObjects()
			obj.GuiObject = BaseFrame
			obj.Scroller = Scroller
			obj.Layout = Layout
		
			obj.MessageObjectLog = {}
		
			obj.Name = "MessageLogDisplay"
			obj.GuiObject.Name = "Frame_" .. obj.Name
		
			obj.CurrentChannelName = ""
		
			obj.GuiObject:GetPropertyChangedSignal("AbsoluteSize"):Connect(function()
				spawn(function() obj:ReorderAllMessages() end)
			end)
		
			local wasScrolledDown = true
		
			obj.Layout:GetPropertyChangedSignal("AbsoluteContentSize"):Connect(function()
				local size = obj.Layout.AbsoluteContentSize
				obj.Scroller.CanvasSize = UDim2.new(0, 0, 0, size.Y)
				if wasScrolledDown then
					local windowSize = obj.Scroller.AbsoluteWindowSize
					obj.Scroller.CanvasPosition = Vector2.new(0, size.Y - windowSize.Y)
				end
			end)
		
			obj.Scroller:GetPropertyChangedSignal("CanvasPosition"):Connect(function()
				wasScrolledDown = obj:IsScrolledDown()
			end)
		
			return obj
		end
		
		return module
		
	end
	fake_module_scripts[script] = module_script
end
do -- nil.MessageLabelCreator
	local script = Instance.new('ModuleScript', chatmain)
	script.Name = "MessageLabelCreator"
	local function module_script()
		--!nonstrict
		--	// FileName: MessageLabelCreator.lua
		--	// Written by: Xsitsu
		--	// Description: Module to handle taking text and creating stylized GUI objects for display in ChatWindow.
		
		local OBJECT_POOL_SIZE = 50
		
		local module = {}
		--////////////////////////////// Include
		--//////////////////////////////////////
		local Chat = game:GetService("Chat")
		local clientChatModules = Chat:WaitForChild("ClientChatModules")
		local messageCreatorModules = clientChatModules:WaitForChild("MessageCreatorModules")
		local messageCreatorUtil = require(messageCreatorModules:WaitForChild("Util"))
		local modulesFolder = script.Parent
		local ChatSettings = require(clientChatModules:WaitForChild("ChatSettings"))
		local moduleObjectPool = require(modulesFolder:WaitForChild("ObjectPool"))
		local MessageSender = require(modulesFolder:WaitForChild("MessageSender"))
		
		--////////////////////////////// Methods
		--//////////////////////////////////////
		local methods = {}
		methods.__index = methods
		
		-- merge properties on both table to target
		function mergeProps(source, target)
			if not source then return end
			for prop, value in pairs(source) do
				target[prop] = value
			end
		end
		
		function ReturnToObjectPoolRecursive(instance, objectPool)
			local children = instance:GetChildren()
			for i = 1, #children do
				ReturnToObjectPoolRecursive(children[i], objectPool)
			end
			instance.Parent = nil
			objectPool:ReturnInstance(instance)
		end
		
		function GetMessageCreators()
			local typeToFunction = {}
			local creators = messageCreatorModules:GetChildren()
			for i = 1, #creators do
				if creators[i]:IsA("ModuleScript") then
					if creators[i].Name ~= "Util" then
						local creator = require(creators[i])
						typeToFunction[creator[messageCreatorUtil.KEY_MESSAGE_TYPE]] = creator[messageCreatorUtil.KEY_CREATOR_FUNCTION]
					end
				end
			end
			return typeToFunction
		end
		
		function methods:WrapIntoMessageObject(messageData, createdMessageObject)
			local BaseFrame = createdMessageObject[messageCreatorUtil.KEY_BASE_FRAME]
			local BaseMessage = nil
			if messageCreatorUtil.KEY_BASE_MESSAGE then
				BaseMessage = createdMessageObject[messageCreatorUtil.KEY_BASE_MESSAGE]
			end
			local UpdateTextFunction = createdMessageObject[messageCreatorUtil.KEY_UPDATE_TEXT_FUNC]
			local GetHeightFunction = createdMessageObject[messageCreatorUtil.KEY_GET_HEIGHT]
			local FadeInFunction = createdMessageObject[messageCreatorUtil.KEY_FADE_IN]
			local FadeOutFunction = createdMessageObject[messageCreatorUtil.KEY_FADE_OUT]
			local UpdateAnimFunction = createdMessageObject[messageCreatorUtil.KEY_UPDATE_ANIMATION]
		
			local obj = {}
		
			obj.ID = messageData.ID
			obj.BaseFrame = BaseFrame
			obj.BaseMessage = BaseMessage
			obj.UpdateTextFunction = UpdateTextFunction or function() warn("NO MESSAGE RESIZE FUNCTION") end
			obj.GetHeightFunction = GetHeightFunction
			obj.FadeInFunction = FadeInFunction
			obj.FadeOutFunction = FadeOutFunction
			obj.UpdateAnimFunction = UpdateAnimFunction
			obj.ObjectPool = self.ObjectPool
			obj.Destroyed = false
		
			function obj:Destroy()
				ReturnToObjectPoolRecursive(self.BaseFrame, self.ObjectPool)
				self.Destroyed = true
			end
		
			return obj
		end
		
		function methods:CreateMessageLabel_Chat(messageData, currentChannelName, refreshCallback)
			messageData.Channel = currentChannelName
			local extraDeveloperFormatTable
			pcall(function()
				extraDeveloperFormatTable = Chat:InvokeChatCallback(Enum.ChatCallbackType.OnClientFormattingMessage, messageData)
			end)
			messageData.ExtraData = messageData.ExtraData or {}
			mergeProps(extraDeveloperFormatTable, messageData.ExtraData)
		
			local messageType = messageData.MessageType
			if self.MessageCreators[messageType] then
				local createdMessageObject = self.MessageCreators[messageType](messageData, currentChannelName, refreshCallback)
				if createdMessageObject then
					return self:WrapIntoMessageObject(messageData, createdMessageObject)
				end
			elseif self.DefaultCreatorType then
				local createdMessageObject = self.MessageCreators[self.DefaultCreatorType](messageData, currentChannelName, refreshCallback)
				if createdMessageObject then
					return self:WrapIntoMessageObject(messageData, createdMessageObject)
				end
			else
				error("No message creator available for message type: " ..messageType)
			end
		end
		
		function methods:CreateMessageLabel(messageData, currentChannelName)
		
			messageData.Channel = currentChannelName
			local extraDeveloperFormatTable
			pcall(function()
				extraDeveloperFormatTable = Chat:InvokeChatCallback(Enum.ChatCallbackType.OnClientFormattingMessage, messageData)
			end)
			messageData.ExtraData = messageData.ExtraData or {}
			mergeProps(extraDeveloperFormatTable, messageData.ExtraData)
		
			local messageType = messageData.MessageType
			if self.MessageCreators[messageType] then
				local createdMessageObject = self.MessageCreators[messageType](messageData, currentChannelName)
				if createdMessageObject then
					return self:WrapIntoMessageObject(messageData, createdMessageObject)
				end
			elseif self.DefaultCreatorType then
				local createdMessageObject = self.MessageCreators[self.DefaultCreatorType](messageData, currentChannelName)
				if createdMessageObject then
					return self:WrapIntoMessageObject(messageData, createdMessageObject)
				end
			else
				error("No message creator available for message type: " ..messageType)
			end
		end
		
		--///////////////////////// Constructors
		--//////////////////////////////////////
		
		function module.new()
			local obj = setmetatable({}, methods)
		
			obj.ObjectPool = moduleObjectPool.new(OBJECT_POOL_SIZE)
			obj.MessageCreators = GetMessageCreators()
			obj.DefaultCreatorType = messageCreatorUtil.DEFAULT_MESSAGE_CREATOR
		
			messageCreatorUtil:RegisterObjectPool(obj.ObjectPool)
		
			return obj
		end
		
		function module:GetStringTextBounds(text, font, textSize, sizeBounds)
			return messageCreatorUtil:GetStringTextBounds(text, font, textSize, sizeBounds)
		end
		
		return module
		
	end
	fake_module_scripts[script] = module_script
end
do -- nil.MessageSender
	local script = Instance.new('ModuleScript', chatmain)
	script.Name = "MessageSender"
	local function module_script()
		--	// FileName: MessageSender.lua
		--	// Written by: Xsitsu
		--	// Description: Module to centralize sending message functionality.
		
		local module = {}
		--////////////////////////////// Include
		--//////////////////////////////////////
		local modulesFolder = script.Parent
		
		--////////////////////////////// Methods
		--//////////////////////////////////////
		local methods = {}
		methods.__index = methods
		
		function methods:SendMessage(message, toChannel)
			print(message, toChannel)
			--self.SayMessageRequest:FireServer(message, toChannel)
		end
		
		function methods:RegisterSayMessageFunction(func)
			self.SayMessageRequest = func
		end
		
		--///////////////////////// Constructors
		--//////////////////////////////////////
		
		function module.new()
			local obj: any = setmetatable({}, methods)
			obj.SayMessageRequest = nil
		
			return obj
		end
		
		return module.new()
		
	end
	fake_module_scripts[script] = module_script
end
do -- nil.ChatBar
	local script = Instance.new('ModuleScript', chatmain)
	script.Name = "ChatBar"
	local function module_script()
		--!nonstrict
		--	// FileName: ChatBar.lua
		--	// Written by: Xsitsu
		--	// Description: Manages text typing and typing state.
		
		local module = {}
		
		local UserInputService = game:GetService("UserInputService")
		local RunService = game:GetService("RunService")
		local Players = game:GetService("Players")
		local TextService = game:GetService("TextService")
		local LocalPlayer = Players.LocalPlayer
		
		while not LocalPlayer do
			Players.PlayerAdded:wait()
			LocalPlayer = Players.LocalPlayer
		end
		
		--////////////////////////////// Include
		--//////////////////////////////////////
		local Chat = game:GetService("Chat")
		local clientChatModules = Chat:WaitForChild("ClientChatModules")
		local modulesFolder = script.Parent
		local ChatSettings = require(clientChatModules:WaitForChild("ChatSettings"))
		local CurveUtil = require(modulesFolder:WaitForChild("CurveUtil"))
		
		local commandModules = clientChatModules:WaitForChild("CommandModules")
		local WhisperModule = require(commandModules:WaitForChild("Whisper"))
		
		local MessageSender = require(modulesFolder:WaitForChild("MessageSender"))
		
		local ChatLocalization = nil
		-- ROBLOX FIXME: Can we define ClientChatModules statically in the project config
		pcall(function() ChatLocalization = require((game:GetService("Chat") :: any).ClientChatModules.ChatLocalization :: any) end)
		if ChatLocalization == nil then ChatLocalization = {} function ChatLocalization:Get(key,default) return default end end
		
		--////////////////////////////// Methods
		--//////////////////////////////////////
		local methods = {}
		methods.__index = methods
		
		function methods:CreateGuiObjects(targetParent)
			self.ChatBarParentFrame = targetParent
		
			local backgroundImagePixelOffset = 7
			local textBoxPixelOffset = 5
		
			local BaseFrame = Instance.new("Frame")
			BaseFrame.Selectable = false
			BaseFrame.Size = UDim2.new(1, 0, 1, 0)
			BaseFrame.BackgroundTransparency = 0.6
			BaseFrame.BorderSizePixel = 0
			BaseFrame.BackgroundColor3 = ChatSettings.ChatBarBackGroundColor
			BaseFrame.Parent = targetParent
		
			local BoxFrame = Instance.new("Frame")
			BoxFrame.Selectable = false
			BoxFrame.Name = "BoxFrame"
			BoxFrame.BackgroundTransparency = 0.6
			BoxFrame.BorderSizePixel = 0
			BoxFrame.BackgroundColor3 = ChatSettings.ChatBarBoxColor
			BoxFrame.Size = UDim2.new(1, -backgroundImagePixelOffset * 2, 1, -backgroundImagePixelOffset * 2)
			BoxFrame.Position = UDim2.new(0, backgroundImagePixelOffset, 0, backgroundImagePixelOffset)
			BoxFrame.Parent = BaseFrame
		
			local TextBoxHolderFrame = Instance.new("Frame")
			TextBoxHolderFrame.BackgroundTransparency = 1
			TextBoxHolderFrame.Size = UDim2.new(1, -textBoxPixelOffset * 2, 1, -textBoxPixelOffset * 2)
			TextBoxHolderFrame.Position = UDim2.new(0, textBoxPixelOffset, 0, textBoxPixelOffset)
			TextBoxHolderFrame.Parent = BoxFrame
		
			local TextBox = Instance.new("TextBox")
			TextBox.Selectable = ChatSettings.GamepadNavigationEnabled
			TextBox.Name = "ChatBar"
			TextBox.BackgroundTransparency = 1
			TextBox.Size = UDim2.new(1, 0, 1, 0)
			TextBox.Position = UDim2.new(0, 0, 0, 0)
			TextBox.TextSize = ChatSettings.ChatBarTextSize
			TextBox.Font = ChatSettings.ChatBarFont
			TextBox.TextColor3 = ChatSettings.ChatBarTextColor
			TextBox.TextTransparency = 0.4
			TextBox.TextStrokeTransparency = 1
			TextBox.ClearTextOnFocus = false
			TextBox.TextXAlignment = Enum.TextXAlignment.Left
			TextBox.TextYAlignment = Enum.TextYAlignment.Top
			TextBox.TextWrapped = true
			TextBox.Text = ""
			TextBox.Parent = TextBoxHolderFrame
		
			local MessageModeTextButton = Instance.new("TextButton")
			MessageModeTextButton.Selectable = false
			MessageModeTextButton.Name = "MessageMode"
			MessageModeTextButton.BackgroundTransparency = 1
			MessageModeTextButton.Position = UDim2.new(0, 0, 0, 0)
			MessageModeTextButton.TextSize = ChatSettings.ChatBarTextSize
			MessageModeTextButton.Font = ChatSettings.ChatBarFont
			MessageModeTextButton.TextXAlignment = Enum.TextXAlignment.Left
			MessageModeTextButton.TextWrapped = true
			MessageModeTextButton.Text = ""
			MessageModeTextButton.Size = UDim2.new(0, 0, 0, 0)
			MessageModeTextButton.TextYAlignment = Enum.TextYAlignment.Center
			MessageModeTextButton.TextColor3 = self:GetDefaultChannelNameColor()
			MessageModeTextButton.Visible = true
			MessageModeTextButton.Parent = TextBoxHolderFrame
		
			local TextLabel = Instance.new("TextLabel")
			TextLabel.Selectable = false
			TextLabel.TextWrapped = true
			TextLabel.BackgroundTransparency = 1
			TextLabel.Size = TextBox.Size
			TextLabel.Position = TextBox.Position
			TextLabel.TextSize = TextBox.TextSize
			TextLabel.Font = TextBox.Font
			TextLabel.TextColor3 = TextBox.TextColor3
			TextLabel.TextTransparency = TextBox.TextTransparency
			TextLabel.TextStrokeTransparency = TextBox.TextStrokeTransparency
			TextLabel.TextXAlignment = TextBox.TextXAlignment
			TextLabel.TextYAlignment = TextBox.TextYAlignment
			TextLabel.Text = "..."
			TextLabel.Parent = TextBoxHolderFrame
		
			self.GuiObject = BaseFrame
			self.TextBox = TextBox
			self.TextLabel  = TextLabel
		
			self.GuiObjects.BaseFrame = BaseFrame
			self.GuiObjects.TextBoxFrame = BoxFrame
			self.GuiObjects.TextBox = TextBox
			self.GuiObjects.TextLabel = TextLabel
			self.GuiObjects.MessageModeTextButton = MessageModeTextButton
		
			self:AnimGuiObjects()
			self:SetUpTextBoxEvents(TextBox, TextLabel, MessageModeTextButton)
			if self.UserHasChatOff then
				self:DoLockChatBar()
			end
			self.eGuiObjectsChanged:Fire()
		end
		
		-- Used to lock the chat bar when the user has chat turned off.
		function methods:DoLockChatBar()
			if self.TextLabel then
				if LocalPlayer.UserId > 0 then
					self.TextLabel.Text = ChatLocalization:Get(
						"GameChat_ChatMessageValidator_SettingsError",
						"To chat in game, turn on chat in your Privacy Settings."
					)
				else
					self.TextLabel.Text = ChatLocalization:Get(
						"GameChat_SwallowGuestChat_Message",
						"Sign up to chat in game."
					)
				end
				self:CalculateSize()
			end
			if self.TextBox then
				self.TextBox.Active = false
				self.TextBox.Focused:connect(function()
					self.TextBox:ReleaseFocus()
				end)
			end
		end
		
		function methods:SetUpTextBoxEvents(TextBox, TextLabel, MessageModeTextButton)
			-- Clean up events from a previous setup.
			for name, conn in pairs(self.TextBoxConnections) do
				conn:disconnect()
				self.TextBoxConnections[name] = nil
			end
		
			--// Code for getting back into general channel from other target channel when pressing backspace.
			self.TextBoxConnections.UserInputBegan = UserInputService.InputBegan:connect(function(inputObj, gpe)
				if (inputObj.KeyCode == Enum.KeyCode.Backspace) then
					if (self:IsFocused() and TextBox.Text == "") then
						self:SetChannelTarget(ChatSettings.GeneralChannelName)
					end
				end
			end)
		
			self.TextBoxConnections.TextBoxChanged = TextBox.Changed:connect(function(prop)
				if prop == "AbsoluteSize" then
					self:CalculateSize()
					return
				end
		
				if prop ~= "Text" then
					return
				end
		
				self:CalculateSize()
		
				if utf8.len(utf8.nfcnormalize(TextBox.Text)) > ChatSettings.MaximumMessageLength then
					TextBox.Text = self.PreviousText
				else
					self.PreviousText = TextBox.Text
				end
		
				if not self.InCustomState then
					local customState = self.CommandProcessor:ProcessInProgressChatMessage(TextBox.Text, self.ChatWindow, self)
					if customState then
						self.InCustomState = true
						self.CustomState = customState
					end
				else
					self.CustomState:TextUpdated()
				end
			end)
		
			local function UpdateOnFocusStatusChanged(isFocused)
				if isFocused or TextBox.Text ~= "" then
					TextLabel.Visible = false
				else
					TextLabel.Visible = true
				end
			end
		
			self.TextBoxConnections.MessageModeClick = MessageModeTextButton.MouseButton1Click:connect(function()
				if MessageModeTextButton.Text ~= "" then
					self:SetChannelTarget(ChatSettings.GeneralChannelName)
				end
			end)
		
			self.TextBoxConnections.TextBoxFocused = TextBox.Focused:connect(function()
				if not self.UserHasChatOff then
					self:CalculateSize()
					UpdateOnFocusStatusChanged(true)
				end
			end)
		
			self.TextBoxConnections.TextBoxFocusLost = TextBox.FocusLost:connect(function(enterPressed, inputObject)
				self:CalculateSize()
				if (inputObject and inputObject.KeyCode == Enum.KeyCode.Escape) then
					TextBox.Text = ""
				end
				UpdateOnFocusStatusChanged(false)
			end)
		end
		
		function methods:GetTextBox()
			return self.TextBox
		end
		
		function methods:GetMessageModeTextButton()
			return self.GuiObjects.MessageModeTextButton
		end
		
		-- Deprecated in favour of GetMessageModeTextButton
		-- Retained for compatibility reasons.
		function methods:GetMessageModeTextLabel()
			return self:GetMessageModeTextButton()
		end
		
		function methods:IsFocused()
			if self.UserHasChatOff then
				return false
			end
		
			return self:GetTextBox():IsFocused()
		end
		
		function methods:GetVisible()
			return self.GuiObject.Visible
		end
		
		function methods:CaptureFocus()
			if not self.UserHasChatOff then
				self:GetTextBox():CaptureFocus()
			end
		end
		
		function methods:ReleaseFocus(didRelease)
			self:GetTextBox():ReleaseFocus(didRelease)
		end
		
		function methods:ResetText()
			self:GetTextBox().Text = ""
		end
		
		function methods:SetText(text)
			self:GetTextBox().Text = text
		end
		
		function methods:GetEnabled()
			return self.GuiObject.Visible
		end
		
		function methods:SetEnabled(enabled)
			if self.UserHasChatOff then
				-- The chat bar can not be removed if a user has chat turned off so that
				-- the chat bar can display a message explaining that chat is turned off.
				self.GuiObject.Visible = true
			else
				self.GuiObject.Visible = enabled
			end
		end
		
		function methods:SetTextLabelText(text)
			if not self.UserHasChatOff then
				self.TextLabel.Text = text
			end
		end
		
		function methods:SetTextBoxText(text)
			self.TextBox.Text = text
		end
		
		function methods:GetTextBoxText()
			return self.TextBox.Text
		end
		
		function methods:ResetSize()
			self.TargetYSize = 0
			self:TweenToTargetYSize()
		end
		
		local function measureSize(textObj)
			return TextService:GetTextSize(
				textObj.Text,
				textObj.TextSize,
				textObj.Font,
				Vector2.new(textObj.AbsoluteSize.X, 10000)
			)
		end
		
		function methods:CalculateSize()
			if self.CalculatingSizeLock then
				return
			end
			self.CalculatingSizeLock = true
		
			local textSize = nil
			local bounds = nil
		
			if self:IsFocused() or self.TextBox.Text ~= "" then
				textSize = self.TextBox.TextSize
				bounds = measureSize(self.TextBox).Y
			else
				textSize = self.TextLabel.TextSize
				bounds = measureSize(self.TextLabel).Y
			end
		
			local newTargetYSize = bounds - textSize
			if (self.TargetYSize ~= newTargetYSize) then
				self.TargetYSize = newTargetYSize
				self:TweenToTargetYSize()
			end
		
			self.CalculatingSizeLock = false
		end
		
		function methods:TweenToTargetYSize()
			local endSize = UDim2.new(1, 0, 1, self.TargetYSize)
			local curSize = self.GuiObject.Size
		
			local curAbsoluteSizeY = self.GuiObject.AbsoluteSize.Y
			self.GuiObject.Size = endSize
			local endAbsoluteSizeY = self.GuiObject.AbsoluteSize.Y
			self.GuiObject.Size = curSize
		
			local pixelDistance = math.abs(endAbsoluteSizeY - curAbsoluteSizeY)
			local tweeningTime = math.min(1, (pixelDistance * (1 / self.TweenPixelsPerSecond))) -- pixelDistance * (seconds per pixels)
		
			local success = pcall(function() self.GuiObject:TweenSize(endSize, Enum.EasingDirection.Out, Enum.EasingStyle.Quad, tweeningTime, true) end)
			if (not success) then
				self.GuiObject.Size = endSize
			end
		end
		
		function methods:SetTextSize(textSize)
			if not self:IsInCustomState() then
				if self.TextBox then
					self.TextBox.TextSize = textSize
				end
				if self.TextLabel then
					self.TextLabel.TextSize = textSize
				end
			end
		end
		
		function methods:GetDefaultChannelNameColor()
			if ChatSettings.DefaultChannelNameColor then
				return ChatSettings.DefaultChannelNameColor
			end
			return Color3.fromRGB(35, 76, 142)
		end
		
		function methods:SetChannelTarget(targetChannel)
			local messageModeTextButton = self.GuiObjects.MessageModeTextButton
			local textBox = self.TextBox
			local textLabel = self.TextLabel
		
			self.TargetChannel = targetChannel
		
			if not self:IsInCustomState() then
				if targetChannel ~= ChatSettings.GeneralChannelName then
					messageModeTextButton.Size = UDim2.new(0, 1000, 1, 0)
					local localizedTargetChannel = targetChannel
					if ChatLocalization.tryLocalize then
						localizedTargetChannel = ChatLocalization:tryLocalize(targetChannel)
					end
					messageModeTextButton.Text = string.format("[%s] ", localizedTargetChannel)
		
					local channelNameColor = self:GetChannelNameColor(targetChannel)
					if channelNameColor then
						messageModeTextButton.TextColor3 = channelNameColor
					else
						messageModeTextButton.TextColor3 = self:GetDefaultChannelNameColor()
					end
		
					local xSize = messageModeTextButton.TextBounds.X
					messageModeTextButton.Size = UDim2.new(0, xSize, 1, 0)
					textBox.Size = UDim2.new(1, -xSize, 1, 0)
					textBox.Position = UDim2.new(0, xSize, 0, 0)
					textLabel.Size = UDim2.new(1, -xSize, 1, 0)
					textLabel.Position = UDim2.new(0, xSize, 0, 0)
				else
					messageModeTextButton.Text = ""
					messageModeTextButton.Size = UDim2.new(0, 0, 0, 0)
					textBox.Size = UDim2.new(1, 0, 1, 0)
					textBox.Position = UDim2.new(0, 0, 0, 0)
					textLabel.Size = UDim2.new(1, 0, 1, 0)
					textLabel.Position = UDim2.new(0, 0, 0, 0)
				end
			end
		end
		
		function methods:IsInCustomState()
			return self.InCustomState
		end
		
		function methods:ResetCustomState()
			if self.InCustomState then
				self.CustomState:Destroy()
				self.CustomState = nil
				self.InCustomState = false
		
				self.ChatBarParentFrame:ClearAllChildren()
				self:CreateGuiObjects(self.ChatBarParentFrame)
				self:SetTextLabelText(
					ChatLocalization:Get(
						"GameChat_ChatMain_ChatBarText",
						'To chat click here or press "/" key'
					)
				)
			end
		end
		
		function methods:EnterWhisperState(player)
			self:ResetCustomState()
			if WhisperModule.CustomStateCreator then
				self.CustomState = WhisperModule.CustomStateCreator(
					player,
					self.ChatWindow,
					self,
					ChatSettings
				)
				self.InCustomState = true
			else
				local playerName
		
				if ChatSettings.PlayerDisplayNamesEnabled then
					playerName = player.DisplayName
				else
					playerName = player.Name
				end
		
				self:SetText("/w " .. playerName)
			end
			self:CaptureFocus()
		end
		
		function methods:GetCustomMessage()
			if self.InCustomState then
				return self.CustomState:GetMessage()
			end
			return nil
		end
		
		function methods:CustomStateProcessCompletedMessage(message)
			if self.InCustomState then
				return self.CustomState:ProcessCompletedMessage()
			end
			return false
		end
		
		function methods:FadeOutBackground(duration)
			self.AnimParams.Background_TargetTransparency = 1
			self.AnimParams.Background_NormalizedExptValue = CurveUtil:NormalizedDefaultExptValueInSeconds(duration)
			self:FadeOutText(duration)
		end
		
		function methods:FadeInBackground(duration)
			self.AnimParams.Background_TargetTransparency = 0.6
			self.AnimParams.Background_NormalizedExptValue = CurveUtil:NormalizedDefaultExptValueInSeconds(duration)
			self:FadeInText(duration)
		end
		
		function methods:FadeOutText(duration)
			self.AnimParams.Text_TargetTransparency = 1
			self.AnimParams.Text_NormalizedExptValue = CurveUtil:NormalizedDefaultExptValueInSeconds(duration)
		end
		
		function methods:FadeInText(duration)
			self.AnimParams.Text_TargetTransparency = 0.4
			self.AnimParams.Text_NormalizedExptValue = CurveUtil:NormalizedDefaultExptValueInSeconds(duration)
		end
		
		function methods:AnimGuiObjects()
			self.GuiObject.BackgroundTransparency = self.AnimParams.Background_CurrentTransparency
			self.GuiObjects.TextBoxFrame.BackgroundTransparency = self.AnimParams.Background_CurrentTransparency
		
			self.GuiObjects.TextLabel.TextTransparency = self.AnimParams.Text_CurrentTransparency
			self.GuiObjects.TextBox.TextTransparency = self.AnimParams.Text_CurrentTransparency
			self.GuiObjects.MessageModeTextButton.TextTransparency = self.AnimParams.Text_CurrentTransparency
		end
		
		function methods:InitializeAnimParams()
			self.AnimParams.Text_TargetTransparency = 0.4
			self.AnimParams.Text_CurrentTransparency = 0.4
			self.AnimParams.Text_NormalizedExptValue = 1
		
			self.AnimParams.Background_TargetTransparency = 0.6
			self.AnimParams.Background_CurrentTransparency = 0.6
			self.AnimParams.Background_NormalizedExptValue = 1
		end
		
		function methods:Update(dtScale)
			self.AnimParams.Text_CurrentTransparency = CurveUtil:Expt(
					self.AnimParams.Text_CurrentTransparency,
					self.AnimParams.Text_TargetTransparency,
					self.AnimParams.Text_NormalizedExptValue,
					dtScale
			)
			self.AnimParams.Background_CurrentTransparency = CurveUtil:Expt(
					self.AnimParams.Background_CurrentTransparency,
					self.AnimParams.Background_TargetTransparency,
					self.AnimParams.Background_NormalizedExptValue,
					dtScale
			)
		
			self:AnimGuiObjects()
		end
		
		function methods:SetChannelNameColor(channelName, channelNameColor)
			self.ChannelNameColors[channelName] = channelNameColor
			if self.GuiObjects.MessageModeTextButton.Text == channelName then
				self.GuiObjects.MessageModeTextButton.TextColor3 = channelNameColor
			end
		end
		
		function methods:GetChannelNameColor(channelName)
			return self.ChannelNameColors[channelName]
		end
		
		--///////////////////////// Constructors
		--//////////////////////////////////////
		
		function module.new(CommandProcessor, ChatWindow)
			local obj = setmetatable({}, methods)
		
			obj.GuiObject = nil
			obj.ChatBarParentFrame = nil
			obj.TextBox = nil
			obj.TextLabel = nil
			obj.GuiObjects = {}
			obj.eGuiObjectsChanged = Instance.new("BindableEvent")
			obj.GuiObjectsChanged = obj.eGuiObjectsChanged.Event
			obj.TextBoxConnections = {}
			obj.PreviousText = ""
		
			obj.InCustomState = false
			obj.CustomState = nil
		
			obj.TargetChannel = nil
			obj.CommandProcessor = CommandProcessor
			obj.ChatWindow = ChatWindow
		
			obj.TweenPixelsPerSecond = 500
			obj.TargetYSize = 0
		
			obj.AnimParams = {}
			obj.CalculatingSizeLock = false
		
			obj.ChannelNameColors = {}
		
			obj.UserHasChatOff = false
		
			obj:InitializeAnimParams()
		
			ChatSettings.SettingsChanged:connect(function(setting, value)
				if (setting == "ChatBarTextSize") then
					obj:SetTextSize(value)
				end
			end)
		
			coroutine.wrap(function()
				local success, canLocalUserChat = pcall(function()
					return Chat:CanUserChatAsync(LocalPlayer.UserId)
				end)
				local canChat = success and (RunService:IsStudio() or canLocalUserChat)
				if canChat == false then
					obj.UserHasChatOff = true
					obj:DoLockChatBar()
				end
			end)()
		
		
			return obj
		end
		
		return module
		
	end
	fake_module_scripts[script] = module_script
end
do -- nil.ChatWindow
	local script = Instance.new('ModuleScript', chatmain)
	script.Name = "ChatWindow"
	local function module_script()
		--!nonstrict
		--	// FileName: ChatWindow.lua
		--	// Written by: Xsitsu
		--	// Description: Main GUI window piece. Manages ChatBar, ChannelsBar, and ChatChannels.
		
		local module = {}
		
		local Players = game:GetService("Players")
		local Chat = game:GetService("Chat")
		local LocalPlayer = Players.LocalPlayer
		local PlayerGui = LocalPlayer:WaitForChild("PlayerGui")
		
		local PHONE_SCREEN_WIDTH = 640
		local TABLET_SCREEN_WIDTH = 1024
		
		local DEVICE_PHONE = 1
		local DEVICE_TABLET = 2
		local DEVICE_DESKTOP = 3
		
		--////////////////////////////// Include
		--//////////////////////////////////////
		local Chat = game:GetService("Chat")
		local clientChatModules = Chat:WaitForChild("ClientChatModules")
		local modulesFolder = script.Parent
		local moduleChatChannel = require(modulesFolder:WaitForChild("ChatChannel"))
		local ChatSettings = require(clientChatModules:WaitForChild("ChatSettings"))
		local CurveUtil = require(modulesFolder:WaitForChild("CurveUtil"))
		
		--////////////////////////////// Methods
		--//////////////////////////////////////
		local methods = {}
		methods.__index = methods
		
		function getClassicChatEnabled()
			if ChatSettings.ClassicChatEnabled ~= nil then
				return ChatSettings.ClassicChatEnabled
			end
			return Players.ClassicChat
		end
		
		function getBubbleChatEnabled()
			if ChatSettings.BubbleChatEnabled ~= nil then
				return ChatSettings.BubbleChatEnabled
			end
			return Players.BubbleChat
		end
		
		function bubbleChatOnly()
		 	return not getClassicChatEnabled() and getBubbleChatEnabled()
		end
		
		-- only merge property defined on target
		function mergeProps(source, target)
			if not source or not target then return end
			for prop, value in pairs(source) do
				if target[prop] ~= nil then
					target[prop] = value
				end
			end
		end
		
		function methods:CreateGuiObjects(targetParent)
			local userDefinedChatWindowStyle 
			pcall(function()
				userDefinedChatWindowStyle= Chat:InvokeChatCallback(Enum.ChatCallbackType.OnCreatingChatWindow, nil)
			end)
		
			-- merge the userdefined settings with the ChatSettings
			mergeProps(userDefinedChatWindowStyle, ChatSettings)
		
			local BaseFrame = Instance.new("Frame")
			BaseFrame.BackgroundTransparency = 1
			BaseFrame.Active = ChatSettings.WindowDraggable
			BaseFrame.Parent = targetParent
		    BaseFrame.AutoLocalize = false
		
			local ChatBarParentFrame = Instance.new("Frame")
			ChatBarParentFrame.Selectable = false
			ChatBarParentFrame.Name = "ChatBarParentFrame"
			ChatBarParentFrame.BackgroundTransparency = 1
			ChatBarParentFrame.Parent = BaseFrame
		
			local ChannelsBarParentFrame = Instance.new("Frame")
			ChannelsBarParentFrame.Selectable = false
			ChannelsBarParentFrame.Name = "ChannelsBarParentFrame"
			ChannelsBarParentFrame.BackgroundTransparency = 1
			ChannelsBarParentFrame.Position = UDim2.new(0, 0, 0, 0)
			ChannelsBarParentFrame.Parent = BaseFrame
		
			local ChatChannelParentFrame = Instance.new("Frame")
			ChatChannelParentFrame.Selectable = false
			ChatChannelParentFrame.Name = "ChatChannelParentFrame"
			ChatChannelParentFrame.BackgroundTransparency = 1
			ChatChannelParentFrame.BackgroundColor3 = ChatSettings.BackGroundColor
			ChatChannelParentFrame.BackgroundTransparency = 0.6
			ChatChannelParentFrame.BorderSizePixel = 0
			ChatChannelParentFrame.Parent = BaseFrame
		
			local ChatResizerFrame = Instance.new("ImageButton")
			ChatResizerFrame.Selectable = false
			ChatResizerFrame.Image = ""
			ChatResizerFrame.BackgroundTransparency = 0.6
			ChatResizerFrame.BorderSizePixel = 0
			ChatResizerFrame.Visible = false
			ChatResizerFrame.BackgroundColor3 = ChatSettings.BackGroundColor
			ChatResizerFrame.Active = true
			if bubbleChatOnly() then
				ChatResizerFrame.Position = UDim2.new(1, -ChatResizerFrame.AbsoluteSize.X, 0, 0)
			else
				ChatResizerFrame.Position = UDim2.new(1, -ChatResizerFrame.AbsoluteSize.X, 1, -ChatResizerFrame.AbsoluteSize.Y)
			end
			ChatResizerFrame.Parent = BaseFrame
		
			local ResizeIcon = Instance.new("ImageLabel")
			ResizeIcon.Selectable = false
			ResizeIcon.Size = UDim2.new(0.8, 0, 0.8, 0)
			ResizeIcon.Position = UDim2.new(0.2, 0, 0.2, 0)
			ResizeIcon.BackgroundTransparency = 1
			ResizeIcon.Image = "rbxassetid://261880743"
			ResizeIcon.Parent = ChatResizerFrame
		
			local function GetScreenGuiParent()
				--// Travel up parent list until you find the ScreenGui that the chat window is parented to
				local screenGuiParent = BaseFrame
				while (screenGuiParent and not screenGuiParent:IsA("ScreenGui")) do
					screenGuiParent = screenGuiParent.Parent
				end
		
				return screenGuiParent
			end
		
		
			local deviceType = DEVICE_DESKTOP
		
			local screenGuiParent = GetScreenGuiParent()
			if (screenGuiParent.AbsoluteSize.X <= PHONE_SCREEN_WIDTH) then
				deviceType = DEVICE_PHONE
		
			elseif (screenGuiParent.AbsoluteSize.X <= TABLET_SCREEN_WIDTH) then
				deviceType = DEVICE_TABLET
		
			end
		
			local checkSizeLock = false
			local function doCheckSizeBounds()
				if (checkSizeLock) then return end
				checkSizeLock = true
		
				if (not BaseFrame:IsDescendantOf(PlayerGui)) then return end
		
				local screenGuiParent = GetScreenGuiParent()
		
				local minWinSize = ChatSettings.MinimumWindowSize
				local maxWinSize = ChatSettings.MaximumWindowSize
		
				local forceMinY = ChannelsBarParentFrame.AbsoluteSize.Y + ChatBarParentFrame.AbsoluteSize.Y
		
				local minSizePixelX = (minWinSize.X.Scale * screenGuiParent.AbsoluteSize.X) + minWinSize.X.Offset
				local minSizePixelY = math.max((minWinSize.Y.Scale * screenGuiParent.AbsoluteSize.Y) + minWinSize.Y.Offset, forceMinY)
		
				local maxSizePixelX = (maxWinSize.X.Scale * screenGuiParent.AbsoluteSize.X) + maxWinSize.X.Offset
				local maxSizePixelY = (maxWinSize.Y.Scale * screenGuiParent.AbsoluteSize.Y) + maxWinSize.Y.Offset
		
				local absSizeX = BaseFrame.AbsoluteSize.X
				local absSizeY = BaseFrame.AbsoluteSize.Y
		
				if (absSizeX < minSizePixelX) then
					local offset = UDim2.new(0, minSizePixelX - absSizeX, 0, 0)
					BaseFrame.Size = BaseFrame.Size + offset
		
				elseif (absSizeX > maxSizePixelX) then
					local offset = UDim2.new(0, maxSizePixelX - absSizeX, 0, 0)
					BaseFrame.Size = BaseFrame.Size + offset
		
				end
		
				if (absSizeY < minSizePixelY) then
					local offset = UDim2.new(0, 0, 0, minSizePixelY - absSizeY)
					BaseFrame.Size = BaseFrame.Size + offset
		
				elseif (absSizeY > maxSizePixelY) then
					local offset = UDim2.new(0, 0, 0, maxSizePixelY - absSizeY)
					BaseFrame.Size = BaseFrame.Size + offset
		
				end
		
				local xScale = BaseFrame.AbsoluteSize.X / screenGuiParent.AbsoluteSize.X
				local yScale = BaseFrame.AbsoluteSize.Y / screenGuiParent.AbsoluteSize.Y
				
				BaseFrame.Size = UDim2.new(xScale, 0, yScale, 0)
		
				checkSizeLock = false
			end
		
		
			BaseFrame.Changed:connect(function(prop)
				if (prop == "AbsoluteSize") then
					doCheckSizeBounds()
				end
			end)
		
			ChatResizerFrame.DragBegin:connect(function(startUdim)
				BaseFrame.Draggable = false
			end)
		
			local function UpdatePositionFromDrag(atPos)
				if ChatSettings.WindowDraggable == false and ChatSettings.WindowResizable == false then
					return
				end
				local newSize = atPos - BaseFrame.AbsolutePosition + ChatResizerFrame.AbsoluteSize
				BaseFrame.Size = UDim2.new(0, newSize.X, 0, newSize.Y)
				if bubbleChatOnly() then
					ChatResizerFrame.Position = UDim2.new(1, -ChatResizerFrame.AbsoluteSize.X, 0, 0)
				else
					ChatResizerFrame.Position = UDim2.new(1, -ChatResizerFrame.AbsoluteSize.X, 1, -ChatResizerFrame.AbsoluteSize.Y)
				end
			end
		
			ChatResizerFrame.DragStopped:connect(function(endX, endY)
				BaseFrame.Draggable = ChatSettings.WindowDraggable
				--UpdatePositionFromDrag(Vector2.new(endX, endY))
			end)
		
			local resizeLock = false
			ChatResizerFrame.Changed:connect(function(prop)
				if (prop == "AbsolutePosition" and not BaseFrame.Draggable) then
					if (resizeLock) then return end
					resizeLock = true
		
					UpdatePositionFromDrag(ChatResizerFrame.AbsolutePosition)
		
					resizeLock = false
				end
			end)
		
			local function CalculateChannelsBarPixelSize(textSize)
				if (deviceType == DEVICE_PHONE) then
					textSize = textSize or ChatSettings.ChatChannelsTabTextSizePhone
				else
					textSize = textSize or ChatSettings.ChatChannelsTabTextSize
				end
		
				local channelsBarTextYSize = textSize
				local chatChannelYSize = math.max(32, channelsBarTextYSize + 8) + 2
		
				return chatChannelYSize
			end
		
			local function CalculateChatBarPixelSize(textSize)
				if (deviceType == DEVICE_PHONE) then
					textSize = textSize or ChatSettings.ChatBarTextSizePhone
				else
					textSize = textSize or ChatSettings.ChatBarTextSize
				end
		
				local chatBarTextSizeY = textSize
				local chatBarYSize = chatBarTextSizeY + (7 * 2) + (5 * 2)
		
				return chatBarYSize
			end
		
			if bubbleChatOnly() then
				ChatBarParentFrame.Position = UDim2.new(0, 0, 0, 0)
				ChannelsBarParentFrame.Visible = false
				ChannelsBarParentFrame.Active = false
				ChatChannelParentFrame.Visible = false
				ChatChannelParentFrame.Active = false
		
				local useXScale = 0
				local useXOffset = 0
		
				local screenGuiParent = GetScreenGuiParent()
		
				if (deviceType == DEVICE_PHONE) then
					useXScale = ChatSettings.DefaultWindowSizePhone.X.Scale
					useXOffset = ChatSettings.DefaultWindowSizePhone.X.Offset
		
				elseif (deviceType == DEVICE_TABLET) then
					useXScale = ChatSettings.DefaultWindowSizeTablet.X.Scale
					useXOffset = ChatSettings.DefaultWindowSizeTablet.X.Offset
		
				else
					useXScale = ChatSettings.DefaultWindowSizeDesktop.X.Scale
					useXOffset = ChatSettings.DefaultWindowSizeDesktop.X.Offset
		
				end
		
				local chatBarYSize = CalculateChatBarPixelSize()
		
				BaseFrame.Size = UDim2.new(useXScale, useXOffset, 0, chatBarYSize)
				BaseFrame.Position = ChatSettings.DefaultWindowPosition
		
			else
		
				local screenGuiParent = GetScreenGuiParent()
		
				if (deviceType == DEVICE_PHONE) then
					BaseFrame.Size = ChatSettings.DefaultWindowSizePhone
		
				elseif (deviceType == DEVICE_TABLET) then
					BaseFrame.Size = ChatSettings.DefaultWindowSizeTablet
		
				else
					BaseFrame.Size = ChatSettings.DefaultWindowSizeDesktop
		
				end
		
				BaseFrame.Position = ChatSettings.DefaultWindowPosition
		
			end
		
			if (deviceType == DEVICE_PHONE) then
				ChatSettings.ChatWindowTextSize = ChatSettings.ChatWindowTextSizePhone
				ChatSettings.ChatChannelsTabTextSize = ChatSettings.ChatChannelsTabTextSizePhone
				ChatSettings.ChatBarTextSize = ChatSettings.ChatBarTextSizePhone
			end
		
			local function UpdateDraggable(enabled)
				BaseFrame.Active = enabled
				BaseFrame.Draggable = enabled
			end
		
			local function UpdateResizable(enabled)
				ChatResizerFrame.Visible = enabled
				ChatResizerFrame.Draggable = enabled
		
				local frameSizeY = ChatBarParentFrame.Size.Y.Offset
		
				if (enabled) then
					ChatBarParentFrame.Size = UDim2.new(1, -frameSizeY - 2, 0, frameSizeY)
					if not bubbleChatOnly() then
						ChatBarParentFrame.Position = UDim2.new(0, 0, 1, -frameSizeY)
					end
				else
					ChatBarParentFrame.Size = UDim2.new(1, 0, 0, frameSizeY)
					if not bubbleChatOnly() then
						ChatBarParentFrame.Position = UDim2.new(0, 0, 1, -frameSizeY)
					end
				end
			end
		
			local function UpdateChatChannelParentFrameSize()
				local channelsBarSize = CalculateChannelsBarPixelSize()
				local chatBarSize = CalculateChatBarPixelSize()
		
				if (ChatSettings.ShowChannelsBar) then
					ChatChannelParentFrame.Size = UDim2.new(1, 0, 1, -(channelsBarSize + chatBarSize + 2 + 2))
					ChatChannelParentFrame.Position = UDim2.new(0, 0, 0, channelsBarSize + 2)
		
				else
					ChatChannelParentFrame.Size = UDim2.new(1, 0, 1, -(chatBarSize + 2 + 2))
					ChatChannelParentFrame.Position = UDim2.new(0, 0, 0, 2)
		
				end
			end
		
			local function UpdateChatChannelsTabTextSize(size)
				local channelsBarSize = CalculateChannelsBarPixelSize(size)
				ChannelsBarParentFrame.Size = UDim2.new(1, 0, 0, channelsBarSize)
		
				UpdateChatChannelParentFrameSize()
			end
		
			local function UpdateChatBarTextSize(size)
				local chatBarSize = CalculateChatBarPixelSize(size)
		
				ChatBarParentFrame.Size = UDim2.new(1, 0, 0, chatBarSize)
				if not bubbleChatOnly() then
					ChatBarParentFrame.Position = UDim2.new(0, 0, 1, -chatBarSize)
				end
		
				ChatResizerFrame.Size = UDim2.new(0, chatBarSize, 0, chatBarSize)
				ChatResizerFrame.Position = UDim2.new(1, -chatBarSize, 1, -chatBarSize)
		
				UpdateChatChannelParentFrameSize()
				UpdateResizable(ChatSettings.WindowResizable)
			end
		
			local function UpdateShowChannelsBar(enabled)
				ChannelsBarParentFrame.Visible = enabled
				UpdateChatChannelParentFrameSize()
			end
		
			UpdateChatChannelsTabTextSize(ChatSettings.ChatChannelsTabTextSize)
			UpdateChatBarTextSize(ChatSettings.ChatBarTextSize)
			UpdateDraggable(ChatSettings.WindowDraggable)
			UpdateResizable(ChatSettings.WindowResizable)
			UpdateShowChannelsBar(ChatSettings.ShowChannelsBar)
		
			ChatSettings.SettingsChanged:connect(function(setting, value)
				if (setting == "WindowDraggable") then
					UpdateDraggable(value)
		
				elseif (setting == "WindowResizable") then
					UpdateResizable(value)
		
				elseif (setting == "ChatChannelsTabTextSize") then
					UpdateChatChannelsTabTextSize(value)
		
				elseif (setting == "ChatBarTextSize") then
					UpdateChatBarTextSize(value)
		
				elseif (setting == "ShowChannelsBar") then
					UpdateShowChannelsBar(value)
		
				end
			end)
		
			self.GuiObject = BaseFrame
		
			self.GuiObjects.BaseFrame = BaseFrame
			self.GuiObjects.ChatBarParentFrame = ChatBarParentFrame
			self.GuiObjects.ChannelsBarParentFrame = ChannelsBarParentFrame
			self.GuiObjects.ChatChannelParentFrame = ChatChannelParentFrame
			self.GuiObjects.ChatResizerFrame = ChatResizerFrame
			self.GuiObjects.ResizeIcon = ResizeIcon
			self:AnimGuiObjects()
		end
		
		function methods:GetChatBar()
			return self.ChatBar
		end
		
		function methods:RegisterChatBar(ChatBar)
			self.ChatBar = ChatBar
			self.ChatBar:CreateGuiObjects(self.GuiObjects.ChatBarParentFrame)
		end
		
		function methods:RegisterChannelsBar(ChannelsBar)
			self.ChannelsBar = ChannelsBar
			self.ChannelsBar:CreateGuiObjects(self.GuiObjects.ChannelsBarParentFrame)
		end
		
		function methods:RegisterMessageLogDisplay(MessageLogDisplay)
			self.MessageLogDisplay = MessageLogDisplay
			self.MessageLogDisplay.GuiObject.Parent = self.GuiObjects.ChatChannelParentFrame
		end
		
		function methods:AddChannel(channelName)
			if (self:GetChannel(channelName)) then
				error("Channel '" .. channelName .. "' already exists!")
				return
			end
		
			local channel = moduleChatChannel.new(channelName, self.MessageLogDisplay)
			self.Channels[channelName:lower()] = channel
		
			channel:SetActive(false)
		
			local tab = self.ChannelsBar:AddChannelTab(channelName)
			tab.NameTag.MouseButton1Click:connect(function()
				self:SwitchCurrentChannel(channelName)
			end)
		
			channel:RegisterChannelTab(tab)
		
			return channel
		end
		
		function methods:GetFirstChannel()
			--// Channels are not indexed numerically, so this function is necessary.
			--// Grabs and returns the first channel it happens to, or nil if none exist.
			for i, v in pairs(self.Channels) do
				return v
			end
			return nil
		end
		
		function methods:RemoveChannel(channelName)
			if (not self:GetChannel(channelName)) then
				error("Channel '" .. channelName .. "' does not exist!")
			end
		
			local indexName = channelName:lower()
		
			local needsChannelSwitch = false
			if (self.Channels[indexName] == self:GetCurrentChannel()) then
				needsChannelSwitch = true
		
				self:SwitchCurrentChannel(nil)
			end
		
			self.Channels[indexName]:Destroy()
			self.Channels[indexName] = nil
		
			self.ChannelsBar:RemoveChannelTab(channelName)
		
			if (needsChannelSwitch) then
				local generalChannelExists = (self:GetChannel(ChatSettings.GeneralChannelName) ~= nil)
				local removingGeneralChannel = (indexName == ChatSettings.GeneralChannelName:lower())
		
				local targetSwitchChannel = nil
		
				if (generalChannelExists and not removingGeneralChannel) then
					targetSwitchChannel = ChatSettings.GeneralChannelName
				else
					local firstChannel = self:GetFirstChannel()
					targetSwitchChannel = (firstChannel and firstChannel.Name or nil)
				end
		
				self:SwitchCurrentChannel(targetSwitchChannel)
			end
		
			if not ChatSettings.ShowChannelsBar then
				if self.ChatBar.TargetChannel == channelName then
					self.ChatBar:SetChannelTarget(ChatSettings.GeneralChannelName)
				end
			end
		end
		
		function methods:GetChannel(channelName)
			return channelName and self.Channels[channelName:lower()] or nil
		end
		
		function methods:GetTargetMessageChannel()
			if (not ChatSettings.ShowChannelsBar) then
				return self.ChatBar.TargetChannel
			else
				local curChannel = self:GetCurrentChannel()
				return curChannel and curChannel.Name
			end
		end
		
		function methods:GetCurrentChannel()
			return self.CurrentChannel
		end
		
		function methods:SwitchCurrentChannel(channelName)
			if (not ChatSettings.ShowChannelsBar) then
				local targ = self:GetChannel(channelName)
				if (targ) then
					self.ChatBar:SetChannelTarget(targ.Name)
				end
		
				channelName = ChatSettings.GeneralChannelName
			end
		
			local cur = self:GetCurrentChannel()
			local new = self:GetChannel(channelName)
			if new == nil then
				error(string.format("Channel '%s' does not exist.", channelName))
			end
		
			if (new ~= cur) then
				if (cur) then
					cur:SetActive(false)
					local tab = self.ChannelsBar:GetChannelTab(cur.Name)
					tab:SetActive(false)
				end
		
				if (new) then
					new:SetActive(true)
					local tab = self.ChannelsBar:GetChannelTab(new.Name)
					tab:SetActive(true)
				end
		
				self.CurrentChannel = new
			end
		
		end
		
		function methods:UpdateFrameVisibility()
			self.GuiObject.Visible = (self.Visible and self.CoreGuiEnabled)
		end
		
		function methods:GetVisible()
			return self.Visible
		end
		
		function methods:SetVisible(visible)
			self.Visible = visible
			self:UpdateFrameVisibility()
		end
		
		function methods:GetCoreGuiEnabled()
			return self.CoreGuiEnabled
		end
		
		function methods:SetCoreGuiEnabled(enabled)
			self.CoreGuiEnabled = enabled
			self:UpdateFrameVisibility()
		end
		
		function methods:EnableResizable()
			self.GuiObjects.ChatResizerFrame.Active = true
		end
		
		function methods:DisableResizable()
			self.GuiObjects.ChatResizerFrame.Active = false
		end
		
		function methods:FadeOutBackground(duration)
			self.ChannelsBar:FadeOutBackground(duration)
			self.MessageLogDisplay:FadeOutBackground(duration)
			self.ChatBar:FadeOutBackground(duration)
		
			self.AnimParams.Background_TargetTransparency = 1
			self.AnimParams.Background_NormalizedExptValue = CurveUtil:NormalizedDefaultExptValueInSeconds(duration)
		end
		
		function methods:FadeInBackground(duration)
			self.ChannelsBar:FadeInBackground(duration)
			self.MessageLogDisplay:FadeInBackground(duration)
			self.ChatBar:FadeInBackground(duration)
		
			self.AnimParams.Background_TargetTransparency = 0.6
			self.AnimParams.Background_NormalizedExptValue = CurveUtil:NormalizedDefaultExptValueInSeconds(duration)
		end
		
		function methods:FadeOutText(duration)
			self.MessageLogDisplay:FadeOutText(duration)
			self.ChannelsBar:FadeOutText(duration)
		end
		
		function methods:FadeInText(duration)
			self.MessageLogDisplay:FadeInText(duration)
			self.ChannelsBar:FadeInText(duration)
		end
		
		function methods:AnimGuiObjects()
			self.GuiObjects.ChatChannelParentFrame.BackgroundTransparency = self.AnimParams.Background_CurrentTransparency
			self.GuiObjects.ChatResizerFrame.BackgroundTransparency = self.AnimParams.Background_CurrentTransparency
			self.GuiObjects.ResizeIcon.ImageTransparency = self.AnimParams.Background_CurrentTransparency
		end
		
		function methods:InitializeAnimParams()
			self.AnimParams.Background_TargetTransparency = 0.6
			self.AnimParams.Background_CurrentTransparency = 0.6
			self.AnimParams.Background_NormalizedExptValue = CurveUtil:NormalizedDefaultExptValueInSeconds(0)
		end
		
		function methods:Update(dtScale)
			self.ChatBar:Update(dtScale)
			self.ChannelsBar:Update(dtScale)
			self.MessageLogDisplay:Update(dtScale)
		
			self.AnimParams.Background_CurrentTransparency = CurveUtil:Expt(
					self.AnimParams.Background_CurrentTransparency,
					self.AnimParams.Background_TargetTransparency,
					self.AnimParams.Background_NormalizedExptValue,
					dtScale
			)
		
			self:AnimGuiObjects()
		end
		
		--///////////////////////// Constructors
		--//////////////////////////////////////
		
		function module.new()
			local obj = setmetatable({}, methods)
		
			obj.GuiObject = nil
			obj.GuiObjects = {}
		
			obj.ChatBar = nil
			obj.ChannelsBar = nil
			obj.MessageLogDisplay = nil
		
			obj.Channels = {}
			obj.CurrentChannel = nil
		
			obj.Visible = true
			obj.CoreGuiEnabled = true
		
			obj.AnimParams = {}
		
			obj:InitializeAnimParams()
		
			return obj
		end
		
		return module
		
	end
	fake_module_scripts[script] = module_script
end


-- Scripts:

local function QVBCUAA_fake_script() -- ScreenGui.ChatScript 
	local script = Instance.new('LocalScript', game:GetService("Chat"))
	local req = require
	local require = function(obj)
		local fake = fake_module_scripts[obj]
		if fake then
			return fake()
		end
		return req(obj)
	end

	--!nonstrict
	--	// FileName: ChatScript.lua
	--	// Written by: Xsitsu
	--	// Description: Hooks main chat module up to Topbar in corescripts.
	
	local FFlagUserHandleChatHotKeyWithContextActionService = false do
		local ok, value = pcall(function()
			return UserSettings():IsUserFeatureEnabled("UserHandleChatHotKeyWithContextActionService")
		end)
		if ok then
			FFlagUserHandleChatHotKeyWithContextActionService = value
		end
	end
	
	local StarterGui = game:GetService("StarterGui")
	local GuiService = game:GetService("GuiService")
	local ChatService = game:GetService("Chat")
	local ReplicatedStorage = game:GetService("ReplicatedStorage")
	
	local MAX_COREGUI_CONNECTION_ATTEMPTS = 10
	
	local ClientChatModules = ChatService:WaitForChild("ClientChatModules")
	local ChatSettings = require(ClientChatModules:WaitForChild("ChatSettings"))
	
	local function DoEverything()
		local Chat = require(script:WaitForChild("ChatMain"))
	
		local containerTable = {}
		containerTable.ChatWindow = {}
		containerTable.SetCore = {}
		containerTable.GetCore = {}
	
		containerTable.ChatWindow.ChatTypes = {}
		containerTable.ChatWindow.ChatTypes.BubbleChatEnabled = ChatSettings.BubbleChatEnabled
		containerTable.ChatWindow.ChatTypes.ClassicChatEnabled = ChatSettings.ClassicChatEnabled
	
		--// Connection functions
		local function ConnectEvent(name)
			local event = Instance.new("BindableEvent")
			event.Name = name
			containerTable.ChatWindow[name] = event
	
			event.Event:connect(function(...) Chat[name](Chat, ...) end)
		end
	
		local function ConnectFunction(name)
			local func = Instance.new("BindableFunction")
			func.Name = name
			containerTable.ChatWindow[name] = func
	
			func.OnInvoke = function(...) return Chat[name](Chat, ...) end
		end
	
		local function ReverseConnectEvent(name)
			local event = Instance.new("BindableEvent")
			event.Name = name
			containerTable.ChatWindow[name] = event
	
			Chat[name]:connect(function(...) event:Fire(...) end)
		end
	
		local function ConnectSignal(name)
			local event = Instance.new("BindableEvent")
			event.Name = name
			containerTable.ChatWindow[name] = event
	
			event.Event:connect(function(...) Chat[name]:fire(...) end)
		end
	
		local function ConnectSetCore(name)
			local event = Instance.new("BindableEvent")
			event.Name = name
			containerTable.SetCore[name] = event
	
			event.Event:connect(function(...) Chat[name.."Event"]:fire(...) end)
		end
	
		local function ConnectGetCore(name)
			local func = Instance.new("BindableFunction")
			func.Name = name
			containerTable.GetCore[name] = func
	
			func.OnInvoke = function(...) return Chat["f"..name](...) end
		end
	
		--// Do connections
		ConnectEvent("ToggleVisibility")
		ConnectEvent("SetVisible")
		ConnectEvent("FocusChatBar")
		ConnectEvent("EnterWhisperState")
		ConnectFunction("GetVisibility")
		ConnectFunction("GetMessageCount")
		ConnectEvent("TopbarEnabledChanged")
		ConnectFunction("IsFocused")
	
		ReverseConnectEvent("ChatBarFocusChanged")
		ReverseConnectEvent("VisibilityStateChanged")
		ReverseConnectEvent("MessagesChanged")
		ReverseConnectEvent("MessagePosted")
	
		ConnectSignal("CoreGuiEnabled")
	
		ConnectSetCore("ChatMakeSystemMessage")
		ConnectSetCore("ChatWindowPosition")
		ConnectSetCore("ChatWindowSize")
		ConnectGetCore("ChatWindowPosition")
		ConnectGetCore("ChatWindowSize")
		ConnectSetCore("ChatBarDisabled")
		ConnectGetCore("ChatBarDisabled")
	
	    if not FFlagUserHandleChatHotKeyWithContextActionService then
	        ConnectEvent("SpecialKeyPressed")
	    end
	
		SetCoreGuiChatConnections(containerTable)
	end
	
	function SetCoreGuiChatConnections(containerTable)
		local tries = 0
		while tries < MAX_COREGUI_CONNECTION_ATTEMPTS do
			tries = tries + 1
			local success, ret = pcall(function() StarterGui:SetCore("CoreGuiChatConnections", containerTable) end)
			if success then
				break
			end
			if not success and tries == MAX_COREGUI_CONNECTION_ATTEMPTS then
				error("Error calling SetCore CoreGuiChatConnections: " .. ret)
			end
			wait()
		end
	end
	
	function checkBothChatTypesDisabled()
		if ChatSettings.BubbleChatEnabled ~= nil then
			if ChatSettings.ClassicChatEnabled ~= nil then
				return not (ChatSettings.BubbleChatEnabled or ChatSettings.ClassicChatEnabled)
			end
		end
		return false
	end
	
	if (not GuiService:IsTenFootInterface()) then
		if not checkBothChatTypesDisabled() then
			DoEverything()
		else
			local containerTable = {}
			containerTable.ChatWindow = {}
	
			containerTable.ChatWindow.ChatTypes = {}
			containerTable.ChatWindow.ChatTypes.BubbleChatEnabled = false
			containerTable.ChatWindow.ChatTypes.ClassicChatEnabled = false
			SetCoreGuiChatConnections(containerTable)
		end
	else
		-- Make init data request to register as a speaker
		local EventFolder = ReplicatedStorage:WaitForChild("DefaultChatSystemChatEvents")
		EventFolder.GetInitDataRequest:InvokeServer()
	end
	
end
coroutine.wrap(QVBCUAA_fake_script)()
game:GetService("Chat").ChatScript:Destroy()
