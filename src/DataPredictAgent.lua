--[[

	--------------------------------------------------------------------

	Aqwam's AI Agent Library (DataPredict Agent)

	Author: Aqwam Harish Aiman
	
	Email: aqwam.harish.aiman@gmail.com
	
	YouTube: https://www.youtube.com/channel/UCUrwoxv5dufEmbGsxyEUPZw
	
	LinkedIn: https://www.linkedin.com/in/aqwam-harish-aiman/
	
	--------------------------------------------------------------------
		
	By using this library, you agree to comply with our Terms and Conditions in the link below:
	
	https://github.com/AqwamCreates/DataPredict-Agent/blob/main/docs/TermsAndConditions.md
	
	--------------------------------------------------------------------
	
	DO NOT REMOVE THIS TEXT!
	
	--------------------------------------------------------------------

--]]

local HttpService = game:GetService("HttpService")

--------------------------------------------------------------------------------

local AqwamMachineLearningAndDeepLearningLibrary = require(script.AqwamDeepLearningLibraryLinker.Value)

local AqwamDeepLearningLibraryLibrary = require(script.AqwamMachineLearningAndDeepLearningLibraryLinker.Value)

--------------------------------------------------------------------------------

local agentActionToDoString = "{action_to_do}"

local agentActionToDoTargetString = "{action_to_do_target}"

local memorySeperator = "[Memory Divider]"

local actionSeperatorString = ","

local hiddenActionToDoPrompt = [[
Speak like a regular human. You may or may not have a conversation with an another player depending on the situation.

At the end of your message, you must append {action_to_do} and list of action you want to perform. Must only have one stem word with all letters in lowercase. No punctuations. No spaces. For example: "{action_to_do}attack,look"

You will also must append {action_to_do_target} right after the list of actions and list the targets for that particular action that was stated in {action_to_do}. For proper nouns, all letters' casing must match. Otherwise, all letters must be in lowercase. No punctuations. No spaces. If there is no target, then write "none" after the {action_to_do_target}. For example: "{action_to_do}attack{action_to_do_target}enemy"

Basically if there is three actions then you do this: "{action_to_do}follow,protect,fight{action_to_do_target}player,player,none". From the example, "follow" and "protect" actions pairs with "player" as the action target, and "attack" action pairs with "none".
]]

--------------------------------------------------------------------------------

local DataPredictAgentGlobalInstance

local isLockedToGlobalInstance = false

local DataPredictAgent = {}

DataPredictAgent.__index = DataPredictAgent

--------------------------------------------------------------------------------

local function returnDefaultValueIfNil(value, defaultValue)
	
	if (type(value) == "nil") then return defaultValue end
	
	return value
	
end

--------------------------------------------------------------------------------

function DataPredictAgent.new(isGlobalInstance) -- Once activated, you cannot deactivate it until the global instance is destroyed.
	
	if (DataPredictAgentGlobalInstance) and (isLockedToGlobalInstance) then return DataPredictAgentGlobalInstance end

	local NewDataPredictAgentInstance = {}
	
	setmetatable(NewDataPredictAgentInstance, DataPredictAgent)
	
	NewDataPredictAgentInstance.dictionaryOfServerDictionary = {}
	
	NewDataPredictAgentInstance.dictionaryOfAgentDictionary = {}
	
	NewDataPredictAgentInstance.dictionaryOfInteractorDictionary = {}
	
	NewDataPredictAgentInstance.dictionaryOfAgentActionArray = {}
	
	if (isGlobalInstance) then
		
		DataPredictAgentGlobalInstance = NewDataPredictAgentInstance
		
		isLockedToGlobalInstance = true
		
	end
	
	return NewDataPredictAgentInstance

end

function DataPredictAgent:destroy()
	
	if (isLockedToGlobalInstance) and (self == DataPredictAgentGlobalInstance) then -- Ensuring that if this instance is not a global instance, then the global instance must not be destroyed. This can happen if the global instance is created after creating the local instances.
		
		isLockedToGlobalInstance = false
		
		DataPredictAgentGlobalInstance = nil
		
	end
	
	setmetatable(self, nil)
	
	table.clear(self)
	
	self = nil
	
end

function DataPredictAgent:addServerDictionary(serverName, serverDictionary)
	
	local dictionaryOfServerDictionary = self.dictionaryOfServerDictionary
	
	if (type(serverName) ~= "string") then error("The server name must be a string.") end
	
	if (dictionaryOfServerDictionary[serverName]) then error("The server " .. serverName .. " already exists.") end
	
	if (type(serverDictionary.ipAddress) ~= "string") then error("The IP address must be a string.") end
	
	serverDictionary.inputKey = serverDictionary.inputKey or "message"
	
	dictionaryOfServerDictionary[serverName] = serverDictionary
	
end

function DataPredictAgent:removeServerDictionary(serverName)
	
	self.dictionaryOfServerDictionary[serverName] = nil
	
end

function DataPredictAgent:getServerDictionary(serverName)
	
	return self.dictionaryOfServerDictionary[serverName]
		
end

function DataPredictAgent:addAgentDictionary(agentName, agentDictionary)
	
	local dictionaryOfAgentDictionary = self.dictionaryOfAgentDictionary
	
	if (type(agentName) ~= "string") then error("The agent name must be a string.") end

	if (dictionaryOfAgentDictionary[agentName]) then error("The agent " .. agentName .. " already exists.") end
	
	agentDictionary.errorPrompt = agentDictionary.errorPrompt or "Something went wrong. Please try again later."
	
	agentDictionary.chatArray = agentDictionary.chatArray or {}
	
	agentDictionary.agentActionArray = agentDictionary.agentActionArray or {}
	
	agentDictionary.agentActionToDoArray = agentDictionary.agentActionToDoArray or {}
	
	agentDictionary.agentActionToDoTargetArray = agentDictionary.agentActionToDoTargetArray or {}
	
	agentDictionary.hasGlobalMemory = returnDefaultValueIfNil(agentDictionary.hasGlobalMemory, true)
	
	agentDictionary.hasLocalMemory = returnDefaultValueIfNil(agentDictionary.hasLocalMemory, true)
	
	agentDictionary.globalMemoryCapacity = agentDictionary.globalMemoryCapacity or 100
	
	agentDictionary.localMemoryCapacity = agentDictionary.localMemoryCapacity or 25
	
	agentDictionary.globalMemory = ""
	
	agentDictionary.model = agentDictionary.model
	
	dictionaryOfAgentDictionary[agentName] = agentDictionary
	
end

function DataPredictAgent:removeAgentDictionary(agentName)

	self.dictionaryOfAgentDictionary[agentName] = nil
	
end

function DataPredictAgent:getAgentDictionary(agentName)
	
	return self.dictionaryOfAgentDictionary[agentName]
	
end

function DataPredictAgent:addInteractorDictionary(interactorName, interactorDictionary)
	
	local dictionaryOfInteractorDictionary = self.dictionaryOfInteractorDictionary
	
	if (type(interactorName) ~= "string") then error("The interactor name must be a string.") end

	if (dictionaryOfInteractorDictionary[interactorName]) then error("The interactor " .. interactorName .. " already exists.") end
	
	interactorDictionary = interactorDictionary or {}
	
	interactorDictionary.localMemory = interactorDictionary.localMemory or {}
	
	dictionaryOfInteractorDictionary[interactorName] = interactorDictionary
	
end

function DataPredictAgent:removeInteractorDictionary(interactorName)

	self.dictionaryOfInteractorDictionary[interactorName] = nil
	
end

function DataPredictAgent:getInteractorDictionary(interactorName)
	
	return self.dictionaryOfInteractorDictionary[interactorName]
	
end

function DataPredictAgent:addAgentActionArray(agentActionName, agentActionArray)

	local dictionaryOfAgentActionArray = self.dictionaryOfAgentActionArray

	if (type(agentActionName) ~= "string") then error("The agent action name must be a string.") end

	if (dictionaryOfAgentActionArray[agentActionName]) then error("The agent action " .. agentActionName .. " already exists.") end
	
	if (type(agentActionArray) ~= "table") then error("The agent action array must be a string.") end

	dictionaryOfAgentActionArray[agentActionName] = agentActionArray or {}

end

function DataPredictAgent:removeAgentActionArray(agentActionName)

	self.dictionaryOfAgentActionArray[agentActionName] = nil

end

function DataPredictAgent:getAgentActionArray(agentActionName)

	return self.dictionaryOfAgentActionArray[agentActionName]

end

function DataPredictAgent:createAgentPrompt(agentName, promptToAdd, isInitialHiddenPromptAdded)
	
	local agentDictionary = self:getAgentDictionary(agentName)

	local prompt = "You are " .. agentName .. ".\n\n"

	local initialHiddenPrompt = agentDictionary.initialHiddenPrompt

	local hiddenPrompt = agentDictionary.hiddenPrompt

	if (initialHiddenPrompt) and (isInitialHiddenPromptAdded) then

		prompt = prompt .. initialHiddenPrompt .. "\n\n"

	end

	if (hiddenPrompt) then

		prompt = prompt .. hiddenPrompt .. "\n\n"

	end
	
	prompt = prompt .. hiddenActionToDoPrompt .. "\n\n" .. promptToAdd

	return prompt
	
end

function DataPredictAgent:createAgentGlobalMemoryPrompt(agentName)
	
	local agentDictionary = self:getAgentDictionary(agentName)
	
	if (agentDictionary.hasGlobalMemory) then

		return "--Start Of Your Memory With The World--\n\n" .. agentDictionary.globalMemory .. "\n\n--End Of Your Memory With The World--"
		
	else
		
		return ""

	end
	
end

function DataPredictAgent:createAgentLocalMemoryPrompt(agentName, interactorName)
	
	local agentDictionary = self:getAgentDictionary(agentName)
	
	local interactorDictionary 
	
	if (interactorName) then interactorDictionary = self:getInteractorDictionary(interactorName) end

	if (agentDictionary.hasLocalMemory) and (interactorDictionary) then
		
		local agentData = interactorDictionary[agentName] or {}
		
		return "--Start Of Your Memory With " .. interactorName .. "--\n\n" .. (agentData.localMemory or "") .. "\n\n--End Of Your Memory With ".. interactorName .. "--"
		
	else
		
		return ""

	end
	
end

function DataPredictAgent:sendServerRequest(serverName, message)
	
	local serverDictionary = self:getServerDictionary(serverName)
	
	local jsonToBeEncoded = {}
	
	jsonToBeEncoded[serverDictionary.inputKey] = message
	
	local requestBody = HttpService:JSONEncode(jsonToBeEncoded)
	
	local success, response = pcall(function() return HttpService:PostAsync(serverDictionary.ipAddress, requestBody, Enum.HttpContentType.ApplicationJson) end)
	
	return (success and HttpService:JSONDecode(response).answer) or nil
	
end

function DataPredictAgent:sendAgentServerRequest(agentName, message)
	
	local agentDictionary = self:getAgentDictionary(agentName)
	
	local response = self:sendServerRequest(agentDictionary.serverName, message) or agentDictionary.errorPrompt
	
	return response
	
end

function DataPredictAgent:splitMessageFromAction(response)
	
	local splittedMessageAndActionsArray = string.split(response, agentActionToDoString)
	
	local message = splittedMessageAndActionsArray[1] or ""
	
	local actionsAndActionsTargetString = splittedMessageAndActionsArray[2] or ""
	
	local splittedActionsAndActionTargetsArray = string.split(actionsAndActionsTargetString, agentActionToDoTargetString)
	
	local actions = splittedActionsAndActionTargetsArray[1] or ""
	
	local actionTargets = splittedActionsAndActionTargetsArray[2] or ""
	
	local actionArray = string.split(actions, actionSeperatorString)
	
	local actionTargetArray = string.split(actionTargets, actionSeperatorString)
	
	return message, actionArray, actionTargetArray
	
end

function DataPredictAgent:act(agentName, action, actionTarget)

	local agentDictionary = self:getAgentDictionary(agentName)
	
	local agentActionArray = agentDictionary.agentActionArray
	
	local agentActionToDoArray = agentDictionary.agentActionToDoArray
	
	local agentActionToDoTargetArray = agentDictionary.agentActionToDoTargetArray
	
	local dictionaryOfAgentActionArray = self.dictionaryOfAgentActionArray
	
	for actionKey, agentActionSynonymArray in dictionaryOfAgentActionArray do
		
		if (table.find(agentActionSynonymArray, action)) then
			
			if (table.find(agentActionArray, actionKey)) then
				
				local actionToDoArrayIndex = table.find(agentActionToDoArray, actionKey)
				
				if (not actionToDoArrayIndex) then
					
					table.insert(agentActionToDoArray, actionKey) 
					
					table.insert(agentActionToDoTargetArray, actionTarget) 
					
				else
					
					agentActionToDoTargetArray[actionToDoArrayIndex] = actionTarget
					
				end	
				
			end
			
		end
		
	end
	
end

function DataPredictAgent:updateAgentGlobalMemory(agentName, memoryToAdd)
	
	local agentDictionary = self:getAgentDictionary(agentName)
	
	if (not agentDictionary.hasGlobalMemory) then return end
	
	local globalMemory = agentDictionary.globalMemory or ""
	
	local globalMemoryArray = string.split(globalMemory, memorySeperator)
	
	local newGlobalMemory
	
	if (agentDictionary.localMemoryCapacity > #globalMemoryArray) then

		table.remove(globalMemoryArray, 1)

		newGlobalMemory = table.concat(globalMemoryArray)

	else

		newGlobalMemory = globalMemory

	end 

	agentDictionary.globalMemory = newGlobalMemory .. "\n\n" .. memorySeperator .. "\n\n" .. memoryToAdd
	
end

function DataPredictAgent:updateAgentLocalMemory(agentName, interactorName, memoryToAdd)
	
	local agentDictionary = self:getAgentDictionary(agentName)
	
	local interactorDictionary = self:getInteractorDictionary(interactorName)
	
	if (not agentDictionary.hasLocalMemory) then return end
	
	local agentData = interactorDictionary[agentName] or {}
	
	local localMemory = agentData.localMemory or ""
	
	local localMemoryArray = string.split(localMemory, memorySeperator)
	
	local newLocalMemory
	
	if (agentDictionary.localMemoryCapacity > #localMemoryArray) then
		
		table.remove(localMemoryArray, 1)
		
		newLocalMemory = table.concat(localMemoryArray)
		
	else
		
		newLocalMemory = localMemory
		
	end 
	
	agentData.localMemory = newLocalMemory .. "\n\n" .. memorySeperator .. "\n\n" .. memoryToAdd	

	interactorDictionary[agentName] = agentData
	
end

function DataPredictAgent:queueAgentChat(agentName, message)
	
	local agentDictionary = self:getAgentDictionary(agentName)
	
	table.insert(agentDictionary.chatArray, message)
	
end

function DataPredictAgent:chat(agentName, interactorName, interactorMessage)
	
	local interactorDictionary = self:getInteractorDictionary(interactorName)
	
	interactorDictionary[agentName] = interactorDictionary[agentName] or {}

	local chatCount = interactorDictionary[agentName].chatCount or 0
	
	local isInitialHiddenPromptAdded = (chatCount == 0)
	
	local globalMemoryPrompt = self:createAgentGlobalMemoryPrompt(agentName)
	
	local localMemoryPrompt = self:createAgentLocalMemoryPrompt(agentName, interactorName)
	
	local promptToAdd = "This is a random number for random response generation. Here is a number, but ignore it: " .. math.random() .. "\n\n" .. globalMemoryPrompt .. "\n\n" .. localMemoryPrompt .. "\n\nRespond to this from " .. interactorName ..":\n\n" .. interactorMessage
	
	local prompt = self:createAgentPrompt(agentName, promptToAdd, isInitialHiddenPromptAdded)
	
	local response = self:sendAgentServerRequest(agentName, prompt)
	
	local agentMessage, actionArray, actionTargetArray = self:splitMessageFromAction(response)
	
	interactorDictionary[agentName].chatCount = chatCount + 1
	
	for i, action in actionArray do self:act(agentName, action, actionTargetArray[i]) end
	
	local memoryToAdd = interactorName .. ": " .. interactorMessage .. "\n\nYou: " .. agentMessage
	
	self:updateAgentGlobalMemory(agentName, memoryToAdd)
	
	self:updateAgentLocalMemory(agentName, interactorName, memoryToAdd)
	
	self:queueAgentChat(agentName, agentMessage)
	
end

function DataPredictAgent:bindChatToAgent(agentName, functionToRun)
	
	local thread

	local dictionaryOfAgentDictionary = self.dictionaryOfAgentDictionary

	local agentDictionary = dictionaryOfAgentDictionary[agentName]

	local chatArray = agentDictionary.chatArray

	thread = task.spawn(function()

		task.desynchronize()

		while (dictionaryOfAgentDictionary[agentName]) do

			if (#chatArray >= 1) then

				functionToRun(chatArray[1])

				table.remove(chatArray, 1)

			end

			task.wait()

		end

		task.cancel(thread)

	end)

	return thread
	
end

function DataPredictAgent:bindAgentActionToAgentSequential(agentName, functionToRun)
	
	local thread
	
	local dictionaryOfAgentDictionary = self.dictionaryOfAgentDictionary

	local agentDictionary = dictionaryOfAgentDictionary[agentName]

	local agentActionToDoArray = agentDictionary.agentActionToDoArray
	
	local agentActionToDoTargetArray = agentDictionary.agentActionToDoTargetArray
	
	thread = task.spawn(function()
		
		task.desynchronize()

		while (dictionaryOfAgentDictionary[agentName]) do
			
			if (#agentActionToDoArray >= 1) then
				
				functionToRun(agentActionToDoArray[1], agentActionToDoTargetArray[1])

				table.remove(agentActionToDoArray, 1)
				
				table.remove(agentActionToDoTargetArray, 1)
				
			end
			
			task.wait()

		end
		
		task.cancel(thread)

	end)

	return thread
	
end

function DataPredictAgent:bindAgentActionToAgentParallel(agentName, agentAction, agentTarget, functionToRun)
	
	local thread

	local agentActionArrayIndex

	local dictionaryOfAgentDictionary = self.dictionaryOfAgentDictionary

	local agentDictionary = dictionaryOfAgentDictionary[agentName]

	local agentActionToDoArray = agentDictionary.agentActionToDoArray
	
	local agentActionToDoTargetArray = agentDictionary.agentActionToDoTargetArray

	thread = task.spawn(function()
		
		task.desynchronize()

		while (dictionaryOfAgentDictionary[agentName]) do

			agentActionArrayIndex = table.find(agentActionToDoArray, agentAction)

			if (agentActionArrayIndex) then
				
				functionToRun()

				table.remove(agentActionToDoArray, agentActionArrayIndex)
				
				table.remove(agentActionToDoTargetArray, agentActionArrayIndex)

			end
			
			task.wait()

		end
		
		task.cancel(thread)

	end)

	return thread

end

function DataPredictAgent:bindFreeWillToAgent(agentName, freeWillFunction)
	
	local thread
	
	local model 

	local classesList
	
	local reinforcementLearningPrompt

	local dictionaryOfAgentDictionary = self.dictionaryOfAgentDictionary

	local agentDictionary = dictionaryOfAgentDictionary[agentName]

	local agentActionToDoArray = agentDictionary.agentActionToDoArray
	
	local initialPromptToAdd = "This is a random number for random response generation. Here is a number, but ignore it: "
	
	local reinforcementLearningInitialPrompt = "Based on the environment, you might consider doing one of the actions based on its respective scores, where the higher the value means a better choice: "
	
	local reinforcementLearningEndingPrompt = "\n\nEnsure that your actions are consistent with your personality."
	
	if (agentDictionary.model) then
		
		model = agentDictionary.model
		
		classesList = model:getClassesList()
		
	end

	thread = task.spawn(function()
		
		while (dictionaryOfAgentDictionary[agentName]) do
			
			if (#agentActionToDoArray == 0) then
				
				local freeWillMessage, environmentVector, reward = freeWillFunction()
				
				if (model) then
					
					reinforcementLearningPrompt = reinforcementLearningInitialPrompt
					
					local reinforcementLearningActionVector = model:reinforce(environmentVector, reward, true)
					
					for i, actionValue in reinforcementLearningActionVector[1] do reinforcementLearningPrompt = reinforcementLearningPrompt .. "\n\n" .. classesList[i] .. ": " .. actionValue end

					reinforcementLearningPrompt = reinforcementLearningPrompt .. reinforcementLearningEndingPrompt
					
				end
				
				local globalMemoryPrompt = self:createAgentGlobalMemoryPrompt(agentName)
				
				local promptToAdd = initialPromptToAdd .. math.random()
				
				if (reinforcementLearningPrompt) then promptToAdd = promptToAdd .. "\n\n" .. reinforcementLearningPrompt end
				
				promptToAdd = promptToAdd .. "\n\n" .. globalMemoryPrompt .. "\n\n" .. freeWillMessage
				
				local prompt = self:createAgentPrompt(agentName, promptToAdd)

				local response = self:sendAgentServerRequest(agentName, prompt)
				
				local agentMessage, actionArray, actionTargetArray = self:splitMessageFromAction(response)

				for i, action in actionArray do self:act(agentName, action, actionTargetArray[i]) end
				
				self:queueAgentChat(agentName, agentMessage)
				
			end
			
			task.wait()

		end
		
		task.cancel(thread)

	end)

	return thread

end

return DataPredictAgent