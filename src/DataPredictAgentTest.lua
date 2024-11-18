local DataPredictAgentModuleScript = game.ServerScriptService.DataPredictAgent

local DataPredictAgentRequiredModuleScript = require(DataPredictAgentModuleScript)

local HiddenPromptDictionary = require(DataPredictAgentModuleScript.HiddenPromptDictionary)

local PersonalityDictionary = require(DataPredictAgentModuleScript.PersonalityDictionary)

local DictionaryOfAgentActionDictionary = require(DataPredictAgentModuleScript.DictionaryOfAgentActionDictionary)

local DataPredictAgent = DataPredictAgentRequiredModuleScript.new(true)

local agentDictionary = {}

local agentActionArray = {}

local serverDictionary = {

}

for actionName, content in DictionaryOfAgentActionDictionary do
	
	DataPredictAgent:addAgentActionDictionary(actionName, content)
	
	table.insert(agentActionArray, actionName)
	
end

agentDictionary.agentActionArray = agentActionArray

agentDictionary.serverName = "default"

agentDictionary.hiddenPrompt =  HiddenPromptDictionary["default"] .. PersonalityDictionary["empathetic"] 

DataPredictAgent:addServerDictionary("default", serverDictionary)

DataPredictAgent:addAgentDictionary("Lilith", agentDictionary)

DataPredictAgent:addInteractorDictionary("Aqwam")

local response = DataPredictAgent:chat("Lilith", "Aqwam", "Respond to this: How are you today?")

print(response)
