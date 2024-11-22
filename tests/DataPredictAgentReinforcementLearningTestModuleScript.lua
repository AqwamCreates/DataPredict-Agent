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

local DataPredict = require(ServerScriptService.AqwamMachineAndDeepLearningLibrary)

local MatrixL = require(ServerScriptService.AqwamMatrixLibrary)

local DataPredictAgentModuleScript = ServerScriptService.DataPredictAgent

local DataPredictAgentRequiredModuleScript = require(DataPredictAgentModuleScript)

local HiddenPromptDictionary = require(DataPredictAgentModuleScript.HiddenPromptDictionary)

local PersonalityDictionary = require(DataPredictAgentModuleScript.PersonalityDictionary)

local DictionaryOfAgentActionArray = require(DataPredictAgentModuleScript.DictionaryOfAgentActionArray)

local DataPredictLibrary = require(DataPredictAgentModuleScript)

local DataPredictAgent = DataPredictAgentRequiredModuleScript.new(true)

local agentDictionary = {}

local agentActionArray = {}

local numberOfFeaturesOfInputEnvironment = 10

local classesList = {"hug", "follow", "wait"}

local serverDictionary = {}

local NeuralNetwork = DataPredict.Models.NeuralNetwork.new()

local DeepDoubleQLearningV2 = DataPredict.Models.DeepDoubleQLearningV2.new()

local CategoricalPolicyQuickSetup = DataPredict.QuickSetups.CategoricalPolicy.new()

NeuralNetwork:setClassesList(classesList)

CategoricalPolicyQuickSetup:setClassesList(classesList)

CategoricalPolicyQuickSetup:setPrintOutput(false)

NeuralNetwork:addLayer(numberOfFeaturesOfInputEnvironment, true, "None")

NeuralNetwork:addLayer(5, true, "LeakyReLU")

NeuralNetwork:addLayer(#classesList, false, "LeakyReLU")

DeepDoubleQLearningV2:setModel(NeuralNetwork)

CategoricalPolicyQuickSetup:setModel(DeepDoubleQLearningV2)

for actionName, content in DictionaryOfAgentActionArray do

	DataPredictAgent:addAgentActionArray(actionName, content)

	table.insert(agentActionArray, actionName)

end

agentDictionary.agentActionArray = agentActionArray

agentDictionary.serverName = "default"

agentDictionary.hiddenPrompt =  HiddenPromptDictionary["default"] .. PersonalityDictionary["empathetic"]

agentDictionary.model = CategoricalPolicyQuickSetup

local function freeWillFunction()
	
	local environmentFeatureVector = MatrixL:createRandomNormalMatrix(1, numberOfFeaturesOfInputEnvironment + 1)
	
	return "", environmentFeatureVector, math.random()
	
end

local userName = "User"

local agentName = "Lilith"

DataPredictAgent:addServerDictionary("default", serverDictionary)

DataPredictAgent:addAgentDictionary(agentName, agentDictionary)

DataPredictAgent:addInteractorDictionary(userName)

DataPredictAgent:bindChatToAgent(agentName, print)

DataPredictAgent:bindAgentActionToAgentSequential(agentName, warn)

DataPredictAgent:bindFreeWillToAgent(agentName, freeWillFunction)

local DataPredictAgentTest = {}

function DataPredictAgentTest:chat(message)
	
	DataPredictAgent:chat(agentName, userName, message)
	
end

return DataPredictAgentTest