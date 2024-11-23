# Setting Up Our First Agent

In this tutorial, I'll be showing you on how to create your first agent. But first, what we need to do is to initialize our DataPredict Agent instance.

```lua

local DataPredictAgent = require(DataPredictAgent)

local DataPredictAgentInstance = DataPredictAgent.new()

```

By default, when creating another DataPredictAgentInstance by DataPredictAgent.new(), it will always return the very first instance you had created before.

This means that your data is shared globally and you do not need to setup individual DataPredict Agent instances all over again.

## Connecting To Our Servers

In order to connect to the servers that are hosting large language models, we first need to create a server dictionary that stores all the server's information into the DataPredict Agent instance.

```lua

local serverName = "defaultServer"

local serverDictionary = {

  ipAddress = "https:\\127.0.0.1:8000" -- Your server's IP address

  inputKey = "message" -- The key that tells our computer where to store our input message before sending the input message to the server.

  outputKey = "answer" -- The key that tells our computer where our output message is stored when receiving the output message from the server.

}

DataPredictAgentInstance:addServerDictionary(serverName, serverDictionary)

```

## Creating Our Agents

All agents are required to have a single server associated with it. This allows our agents to be able to chat with other players and have their own free will.

```lua

local agentName = "defaultAgent"

local agentDictionary = {

  serverName = "defaultServer" -- 

  

}



```
