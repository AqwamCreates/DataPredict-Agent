# DataPredict API Reference

## Constructors

### new()

Creates a new DataPredict instance

```lua

DataPredictAgent.new(isGlobalInstance: boolean): DataPredictAgentInstance

```

#### Parameters:

* isGlobalInstance: If set to true, everytime you call new() constructor, it will return the current instance you have created. (Default: true)

### Returns

* DataPredictAgentInstance: The created DataPredict Agent instance.

## Functions (Dictionary-Related)

### addServerDictionary()

```lua

DataPredictAgent:addServerDictionary(serverName: string, serverDictionary: dictionary)

```

#### Parameters:

* serverName: The name of the server to be added to the DataPredict Agent instance.

* serverDictionary: The dictionary containing all the server's information. It contains:

  * address: The IP address or the website address of the server that is hosting the large language model.

  * inputKey: The name of the input key that is responsible of inputting the message to the server during JSON encoding. (Default: "message")

  * outputKey: The name of the output key that is responsible of outputting the message from the server during JSON decoding. (Default: "answer")

### removeServerDictionary()

```lua

DataPredictAgent:removeServerDictionary(serverName: string)

```

#### Parameters:

* serverName: The name of the server to be removed from the DataPredict Agent instance.

### getServerDictionary()

```lua

DataPredictAgent:getServerDictionary(serverName: string): dictionary

```

#### Parameters:

* serverName: The name of the server to get the server dictionary from the DataPredict Agent instance.

#### Returns:

* serverDictionary: The dictionary containing all the server's information. It contains:

  * address: The IP address or the website address of the server that is hosting the large language model.

  * inputKey: The name of the input key that is responsible of inputting the message to the server during JSON encoding.

  * outputKey: The name of the output key that is responsible of outputting the message from the server during JSON decoding.

### addAgentActionArray()

```lua

DataPredictAgent:addAgentActionArray(agentActionName: string, agentActionArray: array)

```

#### Parameters:

* agentActionName: The name of the agent's action to be added to the DataPredict Agent instance.

* agentActionArray: The array containing all of the synonyms related to the given agent's action name.

### removeAgentActionArray()

```lua

DataPredictAgent:removeAgentActionArray(agentActionName: string)

```

#### Parameters:

* agentActionName: The name of the agent's action to be removed from the DataPredict Agent instance.

### getAgentActionArray()

```lua

DataPredictAgent:getAgentActionArray(agentActionName: string): array

```

#### Parameters:

* agentActionName: The name of the agent's action to get the agent action array from the DataPredict Agent instance.

#### Returns:

* agentActionArray: The array containing all of the synonyms related to the given agent's action name.

### addAgentDictionary()

```lua

DataPredictAgent:addAgentDictionary(agentName: string, agentDictionary: dictionary)

```

#### Parameters:

* agentName: The name of the agent to be added to the DataPredict Agent instance.

* agentDictionary: The dictionary containing all the agents's information. It contains:

  * serverName: The name of the server that will handle the agent's interactions.

  * hasGlobalMemory: Sets whether or not the agent remembers all the interactions, including the surroundings. (Default: true)

  * hasLocalMemory: Sets whether or not the agent remembers all the interactions with individual interactors. (Default: true)

  * globalMemoryCapacity: The amount of global memory that the agent can store at a given time. (Default: 100)

  * localMemoryCapacity: The amount of local memory that the agent can store at a given time. (Default: 25)

  * initialHiddenPrompt: The initial hidden prompt to be added to all messages. (Default: nil)

  * hiddenPrompt: The hidden prompt to be added to all messages. (Default: nil)

### removeAgentDictionary()

```lua

DataPredictAgent:removeServerDictionary(agentName: string)

```

#### Parameters:

* agentName: The name of the agent to be removed from the DataPredict Agent instance.

### getAgentDictionary()

```lua

DataPredictAgent:getAgentDictionary(agentName: string): dictionary

```

#### Parameters:

* agentName: The name of the agent to get the agent dictionary from the DataPredict Agent instance.

#### Returns:

* agentDictionary: The dictionary containing all the agents's information. It contains:

  * address: The IP address or the website address of the server that is hosting the large language model.

## Functions (External)

### chat()

```lua

DataPredictAgent:chat(agentName: string, interactorName: string, interactorMessage: string)

```

#### Parameters:

* agentName: The name of the agent that will receive the interactor's message.

* interactorName: The name of the interactor that will send the interactor's message.

* interactorMessage: The message content inside of the interactor's message.

### act()

```lua

DataPredictAgent:act(agentName: string, agentActionName: string, agentActionTarget: string)

```

### Parameters:

* agentName: The name of the agent that will perform the action.

* agentActionName: The name of the agent's action to be performed.

* agentActionTarget: The target of the selected agent's action.

### queueAgentChat()

```lua

DataPredictAgent:queueAgentChat(agentName: string, agentMessage: string)

```

#### Parameters:

* agentName: The name of the agent that will queue the message.

* agentMessage: The message content inside of the agent's message.

## Events

### bindChatToAgent()

```lua

DataPredictAgent:bindChatToAgent(agentName: string, functionToRun: function): thread

```

#### Parameters:

* agentName: The name of the agent to give the chatting ability to.

* functionToRun: The function to be called when the agent chats.

#### Returns:

* chatThread: The thread that controls the agent's chatting ability.

### bindFreeWillToAgent()

```lua

DataPredictAgent:bindFreeWillToAgent(agentName: string, functionToRun: function): thread

```

#### Parameters:

* agentName: The name of the agent to give the free will to.

* functionToRun: The function to be called when agent's free will is activated.

#### Returns:

* freeWillThread: The thread that controls the agent's free will.

### bindAgentActionToAgentSequential()

```lua

DataPredictAgent:bindAgentActionToAgentSequential(agentName: string, functionToRun: function): thread

```

#### Parameters:

* agentName: The name of the agent to bind the agent's action to.

* functionToRun: The function to be called when the agent's action is called by the agent.

#### Returns:

* actionThread: The thread that controls the agent's action.

### bindAgentActionToAgentParallel()

```lua

DataPredictAgent:bindAgentActionToAgentParallel(agentName: string, agentActionName: string, functionToRun: function): thread

```

#### Parameters:

* agentName: The name of the agent to bind the agent's action to.

* agentAction: The name of the agent action so only that particular action a particular function.

* functionToRun: The function to be called when the agent's action is called by the agent.

#### Returns:

* actionThread: The thread that controls the agent's action.
