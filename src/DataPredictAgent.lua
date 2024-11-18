--[[

	--------------------------------------------------------------------

	Aqwam's AI Agent Library (DataPredict-Agent)

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
	
	NewDataPredictAgentInstance.dictionaryOfAgentActionDictionary = {}
	
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
	
	if (type(serverDictionary.mode) ~= "string") then error("The mode must be a string.") end
	
	if (serverDictionary.mode ~= "Chat") and (serverDictionary.mode ~= "Instruct") then error("The mode must be either \"Chat\" or \"Instruct\" .") end
	
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

function DataPredictAgent:addAgentActionDictionary(agentActionName, agentActionDictionary)

	local dictionaryOfAgentActionDictionary = self.dictionaryOfAgentActionDictionary

	if (type(agentActionName) ~= "string") then error("The agent action name must be a string.") end

	if (dictionaryOfAgentActionDictionary[agentActionName]) then error("The agent action " .. agentActionName .. " already exists.") end
	
	if (type(agentActionDictionary.regularExpressionTrigger) ~= "string") then error("The regular expression trigger must be a string.") end

	dictionaryOfAgentActionDictionary[agentActionName] = agentActionDictionary or {}

end

function DataPredictAgent:removeAgentActionDictionary(agentActionName)

	self.dictionaryOfAgentActionDictionary[agentActionName] = nil

end

function DataPredictAgent:getAgentActionDictionary(agentActionName)

	return self.dictionaryOfAgentActionDictionary[agentActionName]

end

function DataPredictAgent:createAgentPrompt(agentName, message, isInitialHiddenPromptAdded)
	
	local agentDictionary = self:getAgentDictionary(agentName)
	
	local prompt = "You are " .. agentName .. ".\n\n"

	if (agentDictionary.initialHiddenPrompt) and (isInitialHiddenPromptAdded) then
		
		prompt = prompt .. agentDictionary.initialHiddenPrompt .. "\n\n"
		
	end

	if (agentDictionary.hiddenPrompt) then
		
		prompt = prompt .. agentDictionary.hiddenPrompt .. "\n\n"
		
	end

	prompt = prompt .. message
	
	return prompt
end

function DataPredictAgent:sendServerRequest(serverName, message)
	
	local serverDictionary = self:getServerDictionary(serverName)
	
	local requestBody = HttpService:JSONEncode({message = message})
	
	local success, response = pcall(function() return HttpService:PostAsync(serverDictionary.ipAddress, requestBody, Enum.HttpContentType.ApplicationJson) end)
	
	return (success and HttpService:JSONDecode(response).answer) or nil
	
end

function DataPredictAgent:processAgentResponse(agentName, response)

	local agentDictionary = self:getAgentDictionary(agentName)

	for _, agentActionName in ipairs(agentDictionary.agentActionArray) do
		
		local agentActionDictionary = self:getAgentActionDictionary(agentActionName)
		
		if (string.find(response, agentActionDictionary.regularExpressionTrigger)) then table.insert(agentDictionary.agentActionToDoArray, agentActionName) end
		
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
	
	interactorDictionary[agentName].chatCount = chatCount + 1

	self:processAgentResponse(agentName, response)

	return response
	
end

function DataPredictAgent:bindAgentActionToAgentSequential(agentName, functionToRun)
	
	local thread
	
	local dictionaryOfAgentActionDictionary = self.dictionaryOfAgentActionDictionary

	local agentDictionary = dictionaryOfAgentActionDictionary[agentName]

	local agentActionToDoArray = agentDictionary.agentActionToDoArray
	
	thread = task.spawn(function()
		
		task.desynchronize()

		while (dictionaryOfAgentActionDictionary[agentName]) do
			
			if (#agentActionToDoArray >= 1) then
				
				functionToRun(agentActionToDoArray[1])

				table.remove(agentActionToDoArray, 1)
				
			end

		end
		
		task.cancel(thread)

	end)

	return thread
	
end

function DataPredictAgent:bindAgentActionToAgentParallel(agentName, agentActionName, functionToRun)
	
	local thread

	local agentActionArrayIndex

	local dictionaryOfAgentActionDictionary = self.dictionaryOfAgentActionDictionary

	local agentDictionary = dictionaryOfAgentActionDictionary[agentName]

	local agentActionToDoArray = agentDictionary.agentActionToDoArray

	thread = task.spawn(function()
		
		task.desynchronize()

		while (dictionaryOfAgentActionDictionary[agentName]) do

			agentActionArrayIndex = table.find(agentActionToDoArray, agentActionName)

			if (agentActionArrayIndex) then

				table.remove(agentActionToDoArray, agentActionArrayIndex)

				functionToRun() 

			end

		end
		
		task.cancel(thread)

	end)

	return thread

end

function DataPredictAgent:bindFreeWillToAgent(agentName, freeWillMessageGeneratorFunction)
	
	local thread

	local dictionaryOfAgentActionDictionary = self.dictionaryOfAgentActionDictionary

	local agentDictionary = dictionaryOfAgentActionDictionary[agentName]

	local agentActionToDoArray = agentDictionary.agentActionToDoArray

	thread = task.spawn(function()
		
		task.desynchronize()
		
		while (dictionaryOfAgentActionDictionary[agentName]) do
			
			if (#agentActionToDoArray == 0) then
				
				local freeWillMessage = freeWillMessageGeneratorFunction()
				
				local prompt = self:createAgentPrompt(agentName, freeWillMessage)

				local response = self:sendServerRequest(agentDictionary.serverName, prompt) or agentDictionary.errorPrompt

				self:processAgentResponse(agentName, response)
				
			end

		end
		
		task.cancel(thread)

	end)

	return thread

end

return DataPredictAgent
