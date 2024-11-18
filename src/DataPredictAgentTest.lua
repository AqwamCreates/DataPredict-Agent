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

DataPredictAgent:addInteractorDictionary("User")

local response = DataPredictAgent:chat("Lilith", "User", "Respond to this: Hello! What's your name?")

print(response)
