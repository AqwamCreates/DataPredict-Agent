local DictionaryOfAgentActionDictionary = {}

DictionaryOfAgentActionDictionary["follow"] = {
	
	regularExpressionTrigger = "(?i)\\b(follow|shadow|keep\\s*up|stay\\s*close|trail|stay\\s*with|stick\\s*to)\\b.*\\b(player|you)\\b(\\s*will)?"
	
}

DictionaryOfAgentActionDictionary["attack"] = {
	
	regularExpressionTrigger = "(?i)\\b(attack|engage|strike|assault|assail|charge)\\b.*\\b(enemy|target|foe|base)\\b(\\s*will)?"
	
}

DictionaryOfAgentActionDictionary["move"] = {
	
	regularExpressionTrigger = "(?i)\\b(move|advance|head\\s*to|proceed)\\b.*\\b(position|target|location)\\b(\\s*will)?"
	
}

DictionaryOfAgentActionDictionary["defend"] = {
	
	regularExpressionTrigger = "(?i)\\b(defend|shield|guard|protect|block)\\b.*\\b(position|you)\\b(\\s*will)?"
	
}

DictionaryOfAgentActionDictionary["heal"] = {
	
	regularExpressionTrigger = "(?i)\\b(heal|restore|assist\\s*in\\s*healing)\\b.*\\b(player|you)\\b(\\s*will)?"
	
}

DictionaryOfAgentActionDictionary["destroy"] = {
	
	regularExpressionTrigger = "(?i)\\b(destroy|demolish|eliminate|remove)\\b.*\\b(target|obstacle|enemy)\\b(\\s*will)?"
	
}

DictionaryOfAgentActionDictionary["wait"] = {
	
	regularExpressionTrigger = "(?i)\\b(wait|stay\\s*still|hold\\s*position|remain\\s*here)\\b(\\s*will)?"
	
}

DictionaryOfAgentActionDictionary["build"] = {
	
	regularExpressionTrigger = "(?i)\\b(build|construct|set\\s*up)\\b.*\\b(structure|building)\\b(\\s*will)?"
	
}

DictionaryOfAgentActionDictionary["gather"] = {
	
	regularExpressionTrigger = "(?i)\\b(gather|collect|pick\\s*up)\\b.*\\b(resources|supplies)\\b(\\s*will)?"
	
}

DictionaryOfAgentActionDictionary["explore"] = {
	
	regularExpressionTrigger = "(?i)\\b(explore|search|investigate|scout)\\b.*\\b(area|location)\\b(\\s*will)?"
	
}

DictionaryOfAgentActionDictionary["trade"] = {
	
	regularExpressionTrigger = "(?i)\\b(trade|exchange|offer)\\b.*\\b(items|goods)\\b(\\s*will)?"
	
}

DictionaryOfAgentActionDictionary["evade"] = {
	
	regularExpressionTrigger = "(?i)\\b(evade|retreat|dodge)\\b.*\\b(attack|incoming\\s*fire)\\b(\\s*will)?"
	
}

DictionaryOfAgentActionDictionary["equip"] = {
	
	regularExpressionTrigger = "(?i)\\b(equip|arm)\\b.*\\b(weapon|gear)\\b(\\s*will)?"
	
}

DictionaryOfAgentActionDictionary["hug"] = {
	
	regularExpressionTrigger = "(?i)\\b(hug|embrace)\\b.*\\b(player|you)\\b(\\s*will)?"
	
}

DictionaryOfAgentActionDictionary["hand_holding"] = {
	
	regularExpressionTrigger = "(?i)\\b(hold\\s*hands|take\\s*hand)\\b.*\\b(player|you)\\b(\\s*will)?"
	
}

DictionaryOfAgentActionDictionary["date"] = {
	
	regularExpressionTrigger = "(?i)\\b(date|go\\s*on\\s*a\\s*date)\\b.*\\b(player|you)\\b(\\s*will)?"
	
}

DictionaryOfAgentActionDictionary["kiss"] = {
	
	regularExpressionTrigger = "(?i)\\b(kiss)\\b.*\\b(player|you)\\b(\\s*will)?"
	
}

DictionaryOfAgentActionDictionary["rest"] = {
	
	regularExpressionTrigger = "(?i)\\b(rest|relax|take\\s*a\\s*break)\\b.*\\b(player|you)\\b(\\s*will)?"
	
}

DictionaryOfAgentActionDictionary["sleep"] = {
	
	regularExpressionTrigger = "(?i)\\b(sleep|take\\s*a\\s*nap|rest)\\b.*\\b(player|you)\\b(\\s*will)?"
	
}

DictionaryOfAgentActionDictionary["dance"] = {
	
	regularExpressionTrigger = "(?i)\\b(dance)\\b.*\\b(player|you)\\b(\\s*will)?"
	
}

DictionaryOfAgentActionDictionary["sing"] = {
	
	regularExpressionTrigger = "(?i)\\b(sing|perform\\s*a\\s*song)\\b.*\\b(player|you)\\b(\\s*will)?"
	
}

DictionaryOfAgentActionDictionary["laugh"] = {
	
	regularExpressionTrigger = "(?i)\\b(laugh|chuckle|giggle)\\b.*\\b(player|you)\\b(\\s*will)?"
	
}

DictionaryOfAgentActionDictionary["celebrate"] = {
	
	regularExpressionTrigger = "(?i)\\b(celebrate|party|cheer)\\b.*\\b(player|you)\\b(\\s*will)?"
	
}

DictionaryOfAgentActionDictionary["emote"] = {
	
	regularExpressionTrigger = "(?i)\\b(emote|express\\s*emotion|show\\s*emotion)\\b.*\\b(player|you)\\b(\\s*will)?"
	
}

DictionaryOfAgentActionDictionary["praise"] = {
	
	regularExpressionTrigger = "(?i)\\b(praise|compliment|admire)\\b.*\\b(player|you)\\b(\\s*will)?"
	
}

return DictionaryOfAgentActionDictionary
