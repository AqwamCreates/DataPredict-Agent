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

local DictionaryOfAgentActionDictionary = {}

DictionaryOfAgentActionDictionary["follow"] = {"follow", "pursue", "trail", "chase", "shadow"}

DictionaryOfAgentActionDictionary["attack"] = {"attack", "assault", "strike", "hit", "pounce"}

DictionaryOfAgentActionDictionary["move"] = {"move", "advance", "travel", "shift", "relocate"}

DictionaryOfAgentActionDictionary["defend"] = {"defend", "guard", "protect", "shield", "resist"}

DictionaryOfAgentActionDictionary["heal"] = {"heal", "cure", "restore", "treat", "revive"}

DictionaryOfAgentActionDictionary["destroy"] = {"destroy", "demolish", "ruin", "obliterate", "wreck"}

DictionaryOfAgentActionDictionary["wait"] = {"wait", "pause", "remain", "linger", "stay"}

DictionaryOfAgentActionDictionary["create"] = {"create", "make", "build", "construct", "produce"}

DictionaryOfAgentActionDictionary["gather"] = {"gather", "collect", "amass", "assemble", "harvest"}

DictionaryOfAgentActionDictionary["explore"] = {"explore", "search", "investigate", "discover", "survey"}

DictionaryOfAgentActionDictionary["trade"] = {"trade", "exchange", "barter", "sell", "swap"}

DictionaryOfAgentActionDictionary["evade"] = {"evade", "dodge", "escape", "elude", "avoid"}

DictionaryOfAgentActionDictionary["equip"] = {"equip", "gear up", "arm", "outfit", "prepare"}

DictionaryOfAgentActionDictionary["hug"] = {"hug", "embrace", "cuddle", "snuggle", "hold"}

DictionaryOfAgentActionDictionary["hold_hand"] = {"hold_hand", "grasp hand", "clasp hand", "take hand", "link hands"}

DictionaryOfAgentActionDictionary["date"] = {"date", "romance", "court", "meet", "see"}

DictionaryOfAgentActionDictionary["kiss"] = {"kiss", "peck", "smooch", "lock lips", "plant a kiss"}

DictionaryOfAgentActionDictionary["rest"] = {"rest", "relax", "repose", "unwind", "chill"}

DictionaryOfAgentActionDictionary["sleep"] = {"sleep", "nap", "slumber", "snooze", "rest"}

DictionaryOfAgentActionDictionary["dance"] = {"dance", "boogie", "groove", "jig", "shimmy"}

DictionaryOfAgentActionDictionary["sing"] = {"sing", "chant", "croon", "hum", "vocalize"}

DictionaryOfAgentActionDictionary["laugh"] = {"laugh", "giggle", "chuckle", "snicker", "guffaw"}

DictionaryOfAgentActionDictionary["celebrate"] = {"celebrate", "commemorate", "rejoice", "party", "honor"}

DictionaryOfAgentActionDictionary["emote"] = {"emote", "express", "gesture", "show emotion", "display feelings"}

DictionaryOfAgentActionDictionary["praise"] = {"praise", "commend", "laud", "celebrate", "honor"}

return DictionaryOfAgentActionDictionary
