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

  * inputKey: The name of the input key that is responsible of inputting the message to the server during JSON encoding. (Default: message)

  * outputKey: The name of the output key that is responsible of outputting the message from the server during JSON decoding. (Default: answer)

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

## Functions

## chat()

```lua

DataPredictAgent:bindChatToAgent(agentName: string, interactorName: string, interactorMessage: string)

```

#### Parameters:

 * agentName: The name of the agent that will receive the interactor's message.

* interactorName: The name of the interactor that will send the interactor's message.

* interactorMessage: The message content inside of the interactor's message.

## Events

### bindChatToAgent()

```lua

DataPredictAgent:bindChatToAgent(agentName: string, functionToRun: function)

```

#### Parameters:

 * agentName: The name of the agent to give the chatting ability to.

 * functionToRun: The function to be called when the agent chats.

#### Returns:

 * thread: The thread that controls the agent's chatting ability.

### bindFreeWillToAgent()

```lua

DataPredictAgent:bindFreeWillToAgent(agentName: string, functionToRun: function)

```

#### Parameters:

 * agentName: The name of the agent to give the free will to.

 * functionToRun: The function to be called when agent's free will is activated.

#### Returns:

 * thread: The thread that controls the agent's free will.

### bindAgentActionToAgentSequential()

```lua

DataPredictAgent:bindAgentActionToAgentSequential(agentName: string, functionToRun: function)

```

#### Parameters:

 * agentName: The name of the agent to bind the agent's action to.

 * functionToRun: The function to be called when the agent's action is called by the agent.

#### Returns:

 * thread: The thread that controls the agent's action.

### bindAgentActionToAgentParallel()

```lua

DataPredictAgent:bindAgentActionToAgentParallel(agentName: string, agentActionName: string, functionToRun: function)

```

#### Parameters:

 * agentName: The name of the agent to bind the agent's action to.

* agentAction: The name of the agent action so only that particular action a particular function.

 * functionToRun: The function to be called when the agent's action is called by the agent.

#### Returns:

 * thread: The thread that controls the agent's action.
