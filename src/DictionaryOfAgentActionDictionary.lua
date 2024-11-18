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

DictionaryOfAgentActionDictionary["follow"] = {

	regularExpressionTrigger = "(?i)\\b(follow|shadow|keep\\s*up|stay\\s*close|trail|stay\\s*with|stick\\s*to)\\b.*\\b(player|you|your)\\b"

}

DictionaryOfAgentActionDictionary["attack"] = {

	regularExpressionTrigger = "(?i)\\b(attack|engage|strike|assault|assail|charge)\\b.*\\b(enemy|target|foe|base)\\b"

}

DictionaryOfAgentActionDictionary["move"] = {

	regularExpressionTrigger = "(?i)\\b(move|advance|head\\s*to|proceed)\\b.*\\b(position|target|location)\\b"

}

DictionaryOfAgentActionDictionary["defend"] = {

	regularExpressionTrigger = "(?i)\\b(defend|shield|guard|protect|block)\\b.*\\b(position|you)\\b"

}

DictionaryOfAgentActionDictionary["heal"] = {

	regularExpressionTrigger = "(?i)\\b(heal|restore|assist\\s*in\\s*healing)\\b.*\\b(player|you)\\b"

}

DictionaryOfAgentActionDictionary["destroy"] = {

	regularExpressionTrigger = "(?i)\\b(destroy|demolish|eliminate|remove)\\b.*\\b(target|obstacle|enemy)\\b"

}

DictionaryOfAgentActionDictionary["wait"] = {

	regularExpressionTrigger = "(?i)\\b(wait|stay\\s*still|hold\\s*position|remain\\s*here)\\b"

}

DictionaryOfAgentActionDictionary["build"] = {

	regularExpressionTrigger = "(?i)\\b(build|construct|set\\s*up)\\b.*\\b(structure|building)\\b"

}

DictionaryOfAgentActionDictionary["gather"] = {

	regularExpressionTrigger = "(?i)\\b(gather|collect|pick\\s*up)\\b.*\\b(resources|supplies)\\b"

}

DictionaryOfAgentActionDictionary["explore"] = {

	regularExpressionTrigger = "(?i)\\b(explore|search|investigate|scout)\\b.*\\b(area|location)\\b"

}

DictionaryOfAgentActionDictionary["trade"] = {

	regularExpressionTrigger = "(?i)\\b(trade|exchange|offer)\\b.*\\b(items|goods)\\b"

}

DictionaryOfAgentActionDictionary["evade"] = {

	regularExpressionTrigger = "(?i)\\b(evade|retreat|dodge)\\b.*\\b(attack|incoming\\s*fire)\\b"

}

DictionaryOfAgentActionDictionary["equip"] = {

	regularExpressionTrigger = "(?i)\\b(equip|arm)\\b.*\\b(weapon|gear)\\b"

}

DictionaryOfAgentActionDictionary["hug"] = {

	regularExpressionTrigger = "(?i)\\b(hug|embrace)\\b.*\\b(player|you)\\b"

}

DictionaryOfAgentActionDictionary["hold_hand"] = {

	regularExpressionTrigger = "(?i)\\b(hold\\s*hands|take\\s*hand)\\b.*\\b(player|you)\\b"

}

DictionaryOfAgentActionDictionary["date"] = {

	regularExpressionTrigger = "(?i)\\b(date|go\\s*on\\s*a\\s*date)\\b.*\\b(player|you)\\b"

}

DictionaryOfAgentActionDictionary["kiss"] = {

	regularExpressionTrigger = "(?i)\\b(kiss)\\b.*\\b(player|you)\\b"

}

DictionaryOfAgentActionDictionary["rest"] = {

	regularExpressionTrigger = "(?i)\\b(rest|relax|take\\s*a\\s*break)\\b.*\\b(player|you)\\b"

}

DictionaryOfAgentActionDictionary["sleep"] = {

	regularExpressionTrigger = "(?i)\\b(sleep|take\\s*a\\s*nap|rest)\\b.*\\b(player|you)\\b"

}

DictionaryOfAgentActionDictionary["dance"] = {

	regularExpressionTrigger = "(?i)\\b(dance)\\b.*\\b(player|you)\\b"

}

DictionaryOfAgentActionDictionary["sing"] = {

	regularExpressionTrigger = "(?i)\\b(sing|perform\\s*a\\s*song)\\b.*\\b(player|you)\\b"

}

DictionaryOfAgentActionDictionary["laugh"] = {

	regularExpressionTrigger = "(?i)\\b(laugh|chuckle|giggle)\\b.*\\b(player|you)\\b"

}

DictionaryOfAgentActionDictionary["celebrate"] = {

	regularExpressionTrigger = "(?i)\\b(celebrate|party|cheer)\\b.*\\b(player|you)\\b"

}

DictionaryOfAgentActionDictionary["emote"] = {

	regularExpressionTrigger = "(?i)\\b(emote|express\\s*emotion|show\\s*emotion)\\b.*\\b(player|you)\\b"

}

DictionaryOfAgentActionDictionary["praise"] = {

	regularExpressionTrigger = "(?i)\\b(praise|compliment|admire)\\b.*\\b(player|you)\\b"

}

return DictionaryOfAgentActionDictionary
