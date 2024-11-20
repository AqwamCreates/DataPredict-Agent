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

local actionSeperatorString = ","

local hiddenActionToDoPrompt = [[
You will be responding to player commands based on the following actions. Your responses should contain the necessary trigger phrases embedded naturally in the dialogue. When the player requests action, you should act according to the command. If the player asks you to do something like "follow me", "attack the enemy", "move to that position", or similar instructions from the action dictionary, ensure that your response naturally incorporates key action terms such as: "follow", "attack", "move", "defend", "heal", "destroy", "assist", "hug", "hold hands", "date", "kiss", "help", "explore", "rest", "sleep", "dance", "sing", "laugh", "celebrate", "emote", "praise", and others as defined in the action dictionary, using appropriate variants of those commands. Remain neutral and concise in your language but the word count must be similar to regular human conversation.

At the end of your message, you must append {action_to_do} and list of action you want to perform. Must only have one stem word with all letters in lowercase. No punctuations. For example: "{action_to_do}attack,look"
]]

--------------------------------------------------------------------------------

local DataPredictAgentGlobalInstance

local isLockedToGlobalInstance = false

local DataPredictAgent = {}

DataPredictAgent.__index = DataPredictAgent

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
	
	agentDictionary.agentActionArray = agentDictionary.agentActionArray or {}
	
	agentDictionary.agentActionToDoArray = agentDictionary.agentActionToDoArray or {}
	
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
	
	dictionaryOfInteractorDictionary[interactorName] = interactorDictionary or {}
	
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

function DataPredictAgent:createAgentPrompt(agentName, message, isInitialHiddenPromptAdded)
	
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
	
	prompt = prompt .. hiddenActionToDoPrompt .. "\n\n" .. message
	
	return prompt
	
end

function DataPredictAgent:sendServerRequest(serverName, message)
	
	local serverDictionary = self:getServerDictionary(serverName)
	
	local requestBody = HttpService:JSONEncode({message = message})
	
	local success, response = pcall(function() return HttpService:PostAsync(serverDictionary.ipAddress, requestBody, Enum.HttpContentType.ApplicationJson) end)
	
	return (success and HttpService:JSONDecode(response).answer) or nil
	
end

function DataPredictAgent:splitMessageFromAction(response)
	
	local splittedMessageAndActionsArray = string.split(response, agentActionToDoString)
	
	local message, actions = splittedMessageAndActionsArray[1], splittedMessageAndActionsArray[2]
	
	local actionArray = string.split(actions, actionSeperatorString)
	
	return message, actionArray
	
end

function DataPredictAgent:act(agentName, action)

	local agentDictionary = self:getAgentDictionary(agentName)
	
	local agentActionArray = agentDictionary.agentActionArray
	
	local agentActionToDoArray = agentDictionary.agentActionToDoArray
	
	local dictionaryOfAgentActionArray = self.dictionaryOfAgentActionArray
	
	for actionKey, agentActionSynonymArray in dictionaryOfAgentActionArray do
		
		print(actionKey, agentActionSynonymArray)
		
		if (table.find(agentActionSynonymArray, action)) then
			
			if (table.find(agentActionArray, actionKey)) then print("a") table.insert(agentActionToDoArray, actionKey) end
			
		end
		
	end
	
end

function DataPredictAgent:chat(agentName, interactorName, message)
	
	local agentDictionary = self:getAgentDictionary(agentName)
	
	local interactorDictionary = self:getInteractorDictionary(interactorName)
	
	interactorDictionary[agentName] = interactorDictionary[agentName] or {}

	local chatCount = interactorDictionary[agentName].chatCount or 0
	
	local isInitialHiddenPromptAdded = (chatCount == 0)
	
	local prompt = self:createAgentPrompt(agentName, message, isInitialHiddenPromptAdded)
	
	local response = self:sendServerRequest(agentDictionary.serverName, prompt) or agentDictionary.errorPrompt
	
	local message, actionArray = self:splitMessageFromAction(response)
	
	interactorDictionary[agentName].chatCount = chatCount + 1
	
	for _, action in actionArray do self:act(agentName, action) end

	return message
	
end

function DataPredictAgent:bindAgentActionToAgentSequential(agentName, functionToRun)
	
	local thread
	
	local dictionaryOfAgentDictionary = self.dictionaryOfAgentDictionary

	local agentDictionary = dictionaryOfAgentDictionary[agentName]

	local agentActionToDoArray = agentDictionary.agentActionToDoArray
	
	thread = task.spawn(function()
		
		task.desynchronize()

		while (dictionaryOfAgentDictionary[agentName]) do
			
			if (#agentActionToDoArray >= 1) then
				
				functionToRun(agentActionToDoArray[1])

				table.remove(agentActionToDoArray, 1)
				
			end
			
			task.wait()

		end
		
		task.cancel(thread)

	end)

	return thread
	
end

function DataPredictAgent:bindAgentActionToAgentParallel(agentName, agentActionName, functionToRun)
	
	local thread

	local agentActionArrayIndex

	local dictionaryOfAgentDictionary = self.dictionaryOfAgentDictionary

	local agentDictionary = dictionaryOfAgentDictionary[agentName]

	local agentActionToDoArray = agentDictionary.agentActionToDoArray

	thread = task.spawn(function()
		
		task.desynchronize()

		while (dictionaryOfAgentDictionary[agentName]) do

			agentActionArrayIndex = table.find(agentActionToDoArray, agentActionName)

			if (agentActionArrayIndex) then

				table.remove(agentActionToDoArray, agentActionArrayIndex)

				functionToRun() 

			end
			
			task.wait()

		end
		
		task.cancel(thread)

	end)

	return thread

end

function DataPredictAgent:bindFreeWillToAgent(agentName, freeWillMessageGeneratorFunction)
	
	local thread

	local dictionaryOfAgentDictionary = self.dictionaryOfAgentDictionary

	local agentDictionary = dictionaryOfAgentDictionary[agentName]

	local agentActionToDoArray = agentDictionary.agentActionToDoArray

	thread = task.spawn(function()
		
		task.desynchronize()
		
		while (dictionaryOfAgentDictionary[agentName]) do
			
			if (#agentActionToDoArray == 0) then
				
				local freeWillMessage = freeWillMessageGeneratorFunction()
				
				local prompt = self:createAgentPrompt(agentName, freeWillMessage)

				local response = self:sendServerRequest(agentDictionary.serverName, prompt) or agentDictionary.errorPrompt
				
				local _, actionArray = self:splitMessageFromAction(response)

				for _, action in actionArray do self:act(agentName, action) end
				
			end
			
			task.wait()

		end
		
		task.cancel(thread)

	end)

	return thread

end

return DataPredictAgent
