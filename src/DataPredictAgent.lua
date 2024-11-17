local HttpService = game:GetService("HttpService")

--------------------------------------------------------------------------------

local DataPredictLibrary = require(script.AqwamMachineLearningAndDeepLearningLibraryLinker.Value) -- Aqwam's Machine Learning And Deep Learning Library

local DataPredictNeuralLibrary = require(script.AqwamDeepLearningLibraryLinker.Value) -- Aqwam's Deep Learning Library

--------------------------------------------------------------------------------

local DataPredictAgentGlobalInstance

local isLockedToGlobalInstance = false

local DataPredictAgent = {}

--------------------------------------------------------------------------------

function DataPredictAgent.new(isGlobalInstance) -- Once activated, you cannot deactivate it until the global instance is destroyed.
	
	if (DataPredictAgentGlobalInstance) and (isLockedToGlobalInstance) then return DataPredictAgentGlobalInstance end

	local NewDataPredictAgentInstance = {}
	
	setmetatable(NewDataPredictAgentInstance, DataPredictAgent)
	
	NewDataPredictAgentInstance.dictionaryOfServerDictionary = {}
	
	NewDataPredictAgentInstance.dictionaryOfAgentDictionary = {}
	
	NewDataPredictAgentInstance.dictionaryOfInteractorDictionary = {}
	
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

function DataPredictAgent:addServerDictionary(serverName, ipAddress, mode)
	
	local dictionaryOfServerDictionary = self.dictionaryOfServerDictionary
	
	if (type(serverName) ~= "string") then error("The server name must be a string.") end
	
	if (dictionaryOfServerDictionary[serverName]) then error("The server name already exists.") end
	
	if (type(ipAddress) ~= "string") then error("The IP address must be a string.") end
	
	if (type(mode) ~= "string") then error("The mode must be a string.") end
	
	if (mode ~= "Chat") and (mode ~= "Instruct") then error("The mode must be either \"Chat\" or \"Instruct\" .") end
	
	dictionaryOfServerDictionary[serverName] = {
		
		name = serverName,
		
		ipAddress = ipAddress,
		
		mode = mode
		
	}
	
end

function DataPredictAgent:removeServerDictionary(serverName)
	
	self.dictionaryOfServerDictionary[serverName] = nil
	
end

function DataPredictAgent:getServerDictionary(serverName)
	
	return self.dictionaryOfServerDictionary[serverName]
		
end

function DataPredictAgent:addAgentDictionary(agentName, serverName, scope, errorPrompt, initialHiddenPrompt, hiddenPrompt)
	
	local dictionaryOfAgentDictionary = self.dictionaryOfAgentDictionary
	
	if (type(serverName) ~= "string") then error("The agent name must be a string.") end

	if (dictionaryOfAgentDictionary[agentName]) then error("The agent name already exists.") end
	
	if (scope ~= "Global") and (scope ~= "Local") then error("The mode must be either \"Global\" or \"Local\" .") end
	
	dictionaryOfAgentDictionary[agentName] = {
		
		serverName = serverName,
		
		scope = scope,
		
		errorPrompt = errorPrompt or "Something went wrong. Please chat with me later.",
		
		initialHiddenPrompt = initialHiddenPrompt,
		
		hiddenPrompt = hiddenPrompt
		
	}
	
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

	if (dictionaryOfInteractorDictionary[interactorName]) then error("The interactor name already exists.") end
	
	dictionaryOfInteractorDictionary[interactorName] = interactorDictionary or {}
	
end

function DataPredictAgent:removeInteractorDictionary(interactorName)

	self.dictionaryOfInteractorDictionary[interactorName] = nil
	
end

function DataPredictAgent:getInteractorDictionary(interactorName)
	
	return self.dictionaryOfInteractorDictionary[interactorName]
	
end

function DataPredictAgent:chat(agentName, interactorName, message)
	
	local agentDictionary = self:getAgentDictionary(agentName)
	
	local interactorDictionary = self:getInteractorDictionary(interactorName)

	if (not agentDictionary) then error("The agent name does not exist.") end
	
	if (not interactorDictionary) then error("The interactor name does not exist.") end
	
	local serverName = agentDictionary.serverName
	
	local initialHiddenPrompt = agentDictionary.initialHiddenPrompt
	
	local hiddenPrompt = agentDictionary.hiddenPrompt
	
	local serverDictionary = self:getServerDictionary(serverName)
	
	if (not interactorDictionary[agentName]) then interactorDictionary[agentName] = {} end
	
	local chatCount = interactorDictionary[agentName].chatCount or 0
	
	local stringToSendToServer = ""
	
	if (initialHiddenPrompt) and (chatCount == 0) then stringToSendToServer = stringToSendToServer .. initialHiddenPrompt .. "\n\n" end
	
	if (hiddenPrompt) then stringToSendToServer = stringToSendToServer .. hiddenPrompt .. "\n\n"  end
	
	stringToSendToServer = stringToSendToServer .. message
	
	interactorDictionary[agentName].chatCount = chatCount + 1
	
	local requestBody = HttpService:JSONEncode({
		
		message = stringToSendToServer
		
	})

	local success, response = pcall(function()
		
		return HttpService:PostAsync(serverDictionary.ipAddress, requestBody, Enum.HttpContentType.ApplicationJson)
		
	end)
	
	if (success) then
		
		return HttpService:JSONDecode(response).answer
		
	else
		
		return agentDictionary.errorPrompt
		
	end
	
end 

return DataPredictAgent
