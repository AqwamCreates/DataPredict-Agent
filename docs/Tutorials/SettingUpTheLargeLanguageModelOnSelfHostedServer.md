# Setting Up The Large Language Model On Self-Hosted Server

Hosting a large language model on your self-hosted server may seem like a complicated task. But no worries! In this tutorial, we will show you how exactly easy it is to set it up.

## Downloading the LlamaFile

LLamaFile is a software that allows us to run the large language model extremely efficiently. In addition, you can use it to easily host the model that you want, giving you flexibility and the freedom from proprietary models.

In order to download it, you can download it from [here](https://github.com/Mozilla-Ocho/llamafile).

## Downloading the Large Language Model

In order to run models inside the LLamaFile, you are required to download the model in .gguf extension format.

You can have a look at a list of model [here](https://huggingface.co/models?sort=trending&search=gguf). Note taht I have added gguf as one of the key word to the search bar.

Make sure your model can run on your computer, otherwise it can slow your computer down. Generally:

* The higher the number next to the letter "B", the more computational power it needs.

* The higher the number next to the letter "Q", the more computational power it needs.

My recommendation is to use models that are around 2B-8B and Q3-Q5.

## Hosting The Model

Once you have downloaded the LlamaFile and the large language model, you need to run this on your command prompt / terminal:

```

./llamafile.exe -m your_model_here.gguf --server --nobrowser

```

With this in place, you can connect with your server that is hosting the large language model through your Roblox game's server.