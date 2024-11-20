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

local DataPredictAgentModuleScript = game.ServerScriptService.DataPredictAgent

local DataPredictAgentRequiredModuleScript = require(DataPredictAgentModuleScript)

local HiddenPromptDictionary = require(DataPredictAgentModuleScript.HiddenPromptDictionary)

local PersonalityDictionary = require(DataPredictAgentModuleScript.PersonalityDictionary)

local DictionaryOfAgentActionArray = require(DataPredictAgentModuleScript.DictionaryOfAgentActionArray)

local DataPredictAgent = DataPredictAgentRequiredModuleScript.new(true)

local agentDictionary = {}

local agentActionArray = {}

local serverDictionary = {

	ipAddress = "https://internet.com:8000/messages",

}

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

DataPredictAgent:bindAgentActionToAgentParallel(agentName, "follow", "player", function()
	
	warn("follow")
	
end)

DataPredictAgent:bindAgentActionToAgentParallel(agentName, "hug", "player", function()

	warn("hug")

end)

DataPredictAgent:bindAgentActionToAgentParallel(agentName, "attack", "player", function()

	warn("attack")

end)

local DataPredictAgentTest = {}

function DataPredictAgentTest:chat(message)
	
	local response = DataPredictAgent:chat(agentName, userName, "Respond to this: " .. message)
	
	print(response)
	
end

return DataPredictAgentTest