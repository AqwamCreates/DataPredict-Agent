# Setting Up The Large Language Model On Self-Hosted Server

Hosting a large language model on your self-hosted server may seem like a complicated task. But no worries! In this tutorial, we will show you how exactly easy it is to set it up.

## Downloading The LlamaFile

LLamaFile is a software that allows us to run the large language model extremely efficiently. In addition, you can use it to easily host the model that you want, giving you flexibility and the freedom from proprietary models.

In order to download it, you can download it from [here](https://github.com/Mozilla-Ocho/llamafile).

## Downloading The Large Language Model

In order to run models inside the LLamaFile, you are required to download the model in .gguf extension format.

You can have a look at a list of model [here](https://huggingface.co/models?sort=trending&search=gguf). Note that I have added gguf as one of the key word to the search bar.

Make sure your model can run on your computer, otherwise it can slow your computer down. Generally:

* The higher the number next to the letter "B", the more computational power it needs. The letter "B" represents the number of parameters in that model.

* The higher the number next to the letter "Q", the more computational power it needs. The letter "Q" represents the number of bits that was used to store values in that model.

My recommendation is to use models that are around 2B-8B and Q3-Q5.

## Hosting The Model

Once you have downloaded the LlamaFile and the large language model, you need to run this on your command prompt / terminal:

```

./llamafile.exe -m your_model_here.gguf --server --nobrowser

```

With this in place, you can connect with your server that is hosting the large language model through your Roblox game's server.

## Connecting With DataPredict Agent API

Once everything has been set up, you now need to set the address in the server dictionary. You must put the address of your server and combine it with "/completion".

```

local serverDictionary = {

  address = "http://127.0.01:8080/completion"

}

DataPredictAgent:addServerDictionary(serverName, serverDictionary)

```

That's all for this tutorial. Hopefully, you can lower the cost as you aren't stuck with using models that are hosted by third-party servers.
