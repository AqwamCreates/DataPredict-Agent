# Enabling Free Will To Our Agents

From the previous [tutorial](SettingUpOurFirstAgent.md) we have learnt on how to create the agents. However, they only perform their actions after chatting with the interactors.

In this tutorial, we will show you on how to add free will to our agents so that they do not require interactors and instead rely on their environments.

There are two different types of free will that we can add to the agents:

  * Regular Free Will

  * Free Will With Deep Reinforcement Learning (Requires The DataPredict Library)

We will look at how we can add the free will to the agents below.

## Regular Free Will

To create a regular free will, we first need to call bindFreeWillToAgent() function from the DataPredict Agent instance.

```lua

local thread = DataPredictAgentInstance:bindFreeWillToAgent(agentName, function()

  local freeWillString -- Your code here that detects the surroundings.

  return freeWillString
  
end)

```

In order for the agent to work properly, the free will string must be returned. Otherwise, it will not be able to sense its environment.

That is all you need to do to give agents the regular free wills.

##  Free Will With Deep Reinforcement Learning

The difference between the regular free will and this one is that it allows our agents to learn from its mistakes and its environments.

However, this requires the [DataPredict](https://aqwamcreates.github.io/DataPredict/) library, which could make the setup more complicated. It is strictly not neccesary to do this, but the agents will be limited in their capabilities related to their free will.

I recommend you on reading on how to create neural networks as well as creating learning AIs using quick setup to fully understand the DataPredict library.

For now, we will be skipping the explanation and go straight to coding as it will be less confusing to follow. 

### Creating The Deep Reinforcement Learning Model

```lua

local DataPredict = require(DataPredict)

local NeuralNetwork = DataPredict.Models.NeuralNetwork.new()

local DeepDoubleQLearningV2 = DataPredict.Models.DeepDoubleQLearningV2.new()

local CategoricalPolicyQuickSetup = DataPredict.QuickSetups.CategoricalPolicy.new()

local numberOfFeaturesOfInputEnvironment = 10

local classesList = {"hug", "follow", "wait"}

NeuralNetwork:setClassesList(classesList)

CategoricalPolicyQuickSetup:setClassesList(classesList)

CategoricalPolicyQuickSetup:setPrintOutput(false)

NeuralNetwork:addLayer(numberOfFeaturesOfInputEnvironment, true, "None")

NeuralNetwork:addLayer(5, true, "LeakyReLU")

NeuralNetwork:addLayer(#classesList, false, "LeakyReLU")

DeepDoubleQLearningV2:setModel(NeuralNetwork)

```

### Adding The Deep Reinforcement Learning Model to the Agent Free Will

```lua

local agentDictionary = {}

agentDictionary.model = CategoricalPolicyQuickSetup

DataPredictAgent:addAgentDictionary(agentName, agentDictionary)

```

### Enabling the Free Will With Deep Reinforcement Learning For The Agent

```lua

local thread = DataPredictAgentInstance:bindFreeWillToAgent(agentName, function()

 local freeWillString -- Your code here that detects the surroundings.

 local environmentFeatureVector -- Your agent's observed environment feature vector to be passed into the deep reinforcement learning model.

 local reward -- Your agent's reward as a result of performing certain actions.

 return freeWillString, environmentFeatureVector, reward
  
end)

```

## Conclusion

From this tutorial, you now have learnt on how to add free will to the agents so that they do not require to chat with interactors in order to perform actions.

Although adding the free will with deep reinforcement learning can be quite complicated, you will eventually get used to it with time.

That's for the tutorial today and I look forward on seeing your creations using the DataPredict Agent library!
