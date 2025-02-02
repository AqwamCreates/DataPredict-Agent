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

local ServerScriptService = game:GetService("ServerScriptService")

local DataPredictAgentModuleScript = ServerScriptService.DataPredictAgent

local DataPredictAgentRequiredModuleScript = require(DataPredictAgentModuleScript)

local HiddenPromptDictionary = require(DataPredictAgentModuleScript.HiddenPromptDictionary)

local PersonalityDictionary = require(DataPredictAgentModuleScript.PersonalityDictionary)

local DictionaryOfAgentActionArray = require(DataPredictAgentModuleScript.DictionaryOfAgentActionArray)

local DataPredictAgent = DataPredictAgentRequiredModuleScript.new(true)

local agentDictionary = {}

local agentActionArray = {}

local serverDictionary = {}

for actionName, content in DictionaryOfAgentActionArray do

	DataPredictAgent:addAgentActionArray(actionName, content)

	table.insert(agentActionArray, actionName)

end

agentDictionary.agentActionArray = agentActionArray

agentDictionary.serverName = "default"

agentDictionary.hiddenPrompt =  HiddenPromptDictionary["default"] .. PersonalityDictionary["empathetic"]

local userName = "User"

local agentName = "Lilith"

DataPredictAgent:addServerDictionary("default", serverDictionary)

DataPredictAgent:addAgentDictionary(agentName, agentDictionary)

DataPredictAgent:addInteractorDictionary(userName)

DataPredictAgent:bindChatToAgent(agentName, print)

DataPredictAgent:bindAgentActionToAgentParallel(agentName, "follow", function(actionTarget)
	
	warn("follow", actionTarget)
	
end)

DataPredictAgent:bindAgentActionToAgentParallel(agentName, "hug", function(actionTarget)

	warn("hug", actionTarget)

end)

DataPredictAgent:bindAgentActionToAgentParallel(agentName, "attack", function(actionTarget)

	warn("attack", actionTarget)

end)

DataPredictAgent:updateAgentSenseMemory("Lilith", "You see flower.")

local DataPredictAgentTest = {}

function DataPredictAgentTest:chat(message)
	
	DataPredictAgent:chat(agentName, userName, message)
	
end

return DataPredictAgentTest