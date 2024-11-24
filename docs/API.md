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

## Functions

### addServerDictionary()

```lua

DataPredictAgent:addServerDictionary(serverName: string, serverDictionary: dictionary)

```

#### Parameters:

* serverName: The name of the server to be added to the DataPredict Agent instance.

* serverDictionary: The dictionary containing all the server's information. Available options are:

  * address: The IP address or the website address of the server that is hosting the large language model.

  * inputKey: The name of the input key that is responsible of inputting the message to the server during JSON encoding.

  * outputKey: The name of the output key that is responsible of outputting the message from the server during JSON decoding.

### removeServerDictionary()

```lua

DataPredictAgent:removeServerDictionary(serverName: string)

```

#### Parameters:

* serverName: The name of the server to be removed from the DataPredict Agent instance.

## Events

