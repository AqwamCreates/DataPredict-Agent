# Setting Up Our First Agent

In this tutorial, I'll be showing you on how to create your first agent. But first, what we need to do is to initialize our DataPredict Agent instance.

```lua

local DataPredictAgent = require(DataPredictAgent)

local DataPredictAgentInstance = DataPredictAgent.new()

```

By default, when creating another DataPredictAgentInstance by DataPredictAgent.new(), it will always return the very first instance you had created before.

This means that your data is shared globally and we do not need to setup individual DataPredict Agent instances all over again.

## Connecting To Our Servers

In order to connect to the servers that are hosting large language models, we first need to create a server dictionary that stores all the server's information into the DataPredict Agent instance.

```lua

local serverName = "defaultServer"

local serverDictionary = {

  address = "https:\\127.0.0.1:8000" -- Your server's IP address or website address.

  inputKey = "message" -- The key that tells our computer where to store our input message before sending the input message to the server.

  outputKey = "answer" -- The key that tells our computer where our output message is stored when receiving the output message from the server.

}

DataPredictAgentInstance:addServerDictionary(serverName, serverDictionary)

```

## Adding Our Agents' Actions

Different action names often have the same meanings, which could make some parts of our code become repetitive. Fortunately, we can define the synoynms so that we don't have to write all the functions for different actions that have the same meanings.

```lua

local actionName = "follow"

local actionArray = {"follow", "stalk", "shadow"} -- You must include its own actions as well for this to work.

DataPredictAgent:addAgentActionArray(actionName, actionArray)

```

Fortunately, I already have added list of actions directly under "dictionaryOfActionArray" to save your time.

## Creating Our Agents

All agents are required to have a single server associated with it. This allows our agents to be able to chat with other players and have their own free will.

In addition, there are a lot of things you can control for your agents. For example, using the "hiddenPrompt" to add personality to your agents.

```lua

local agentName = "defaultAgent"

local agentDictionary = {

  serverName = "defaultServer" -- The server's name must be one of the servers that you have added to the DataPredict Agent instance.

  agentActionArray = {"follow"} -- You must add the top-level actions into this list. For example, we already set "shadow" as part of "follow", so we need to use "follow" as the top level action.

  hiddenPrompt = "You are sweet and funny." -- This is the hidden prompt that you want to add to the players' messages.

  initialChatPrompt = "Say that they are new here." -- This is when the player interacts with this agent for the first time.

  hasGlobalMemory = true -- This allows your agent to remember all of its interations. By default, it is set to true.

  hasLocalMemory = true -- This allows your agent to remember interactions between the player and the agent. By default, it is set to true.

}

```

## Creating Our Interactors

Once those have been created, we need to add a place to save the interactions with these agents. These interactors are often the players.

It usually stores:

  * The chat count between the interactor and the individual agents.

  * The local memory between the interactor and the individual agents, provided that the "hasLocalMemory" is set to true.

```lua

local interactorName = "player"

local interactorDictionary = {} -- You can load this data from somewhere else as well if you want to keep the interactor's memories.

DataPredictAgent:addInteractorDictionary(interactorName, interactorDictionary)

```

## Enabling Our Agents To Chat

In order for our agents to chat with us, they need a way to output their messages. We can do that with bindChatToAgent() function.

```lua

local thread = DataPredictAgent:bindChatToAgent(agentName, function(agentMessage)

  print(agentMessage) -- You can replace print with any other functions.

end) 

```

## Chatting With Our Agents

This code pretty much explain itself. However, do note that if you do not setup the bindChatToAgent() function, you will not receive any outputs.

```lua

DataPredictAgent:chat(agentName, interactorName, interactorMessage)

```

## Enabling Custom Actions For Our Agents

The agents have multiple ways on how to execute the actions. They can do the actions in sequential or parallel.

For sequential, the actions are performed based on first in, first out basis. Below, we will look into on how to setup sequential actions.

```lua

DataPredict:bindAgentActionToAgentSequential(agentName, function(action, actionTarget)

  print(action, actionTarget) -- Our action is the top-level action here.

end)

```

For parallel, the actions are performed based on the selected actions. Below, we will look into on how to setup parallel actions.

```lua

DataPredict:bindAgentActionToAgentParallel(agentName, action, function(actionTarget) -- This function only runs when the "action" is requested. Also, our action is the top-level action here.

  print(actionTarget) 

end)

```

## Enabling Our Agent Ability To Sense Its Environments

The agents can also sense its environments. For this to happen, you need to call the bindSenseToAgent() function.

```lua

DataPredict:bindSenseToAgent(agentName, function() 

  local sense -- Your code that converts the environment into a string.

  return sense

end)

```

## In Conclusion

Although the agent setup can be quite long, it allows us to have greater flexibility, power and control in the agents' actions, dialogues and so on.

With this knowledge in place, you can now create your very own agents!

I look forward on what you will create with them!
