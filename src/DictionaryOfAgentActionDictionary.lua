local DictionaryOfAgentActionDictionary = {}

DictionaryOfAgentActionDictionary["follow"] = {
	
	regularExpressionTrigger = "(?i)\\b(follow|shadow|keep\\s*up|stay\\s*close|trail|stay\\s*with|stick\\s*to|come\\s*with\\s*me|on\\s*me)\\b.*\\b(player|you|this|here|there|nearby)\\b"
	
}

DictionaryOfAgentActionDictionary["attack"] = {
	
	regularExpressionTrigger = "(?i)\\b(attack|engage|strike|fight|hit|target|take\\s*down|destroy)\\b.*\\b(enemy|opponent|them|target|foe|hostile|this|here|there|nearby|around)\\b"
	
}

DictionaryOfAgentActionDictionary["defend"] = {
	
	regularExpressionTrigger = "(?i)\\b(defend|protect|guard|shield|cover|block|fortify)\\b.*\\b(player|you|base|ally|teammate|position|this|here|there|nearby|around)\\b"
	
}

DictionaryOfAgentActionDictionary["heal"] = {
	
	regularExpressionTrigger = "(?i)\\b(heal|restore|help|aid|patch\\s*up|cure|bandage|revive|resuscitate)\\b.*\\b(player|you|ally|teammate|wounded|this|here|there|nearby)\\b"
	
}

DictionaryOfAgentActionDictionary["move"] = {
	
	regularExpressionTrigger = "(?i)\\b(move|go|proceed|advance|retreat|fall\\s*back|head\\s*to|navigate|relocate|approach|move\\s*towards|go\\s*towards|move\\s*ahead|back\\s*up|run|speed\\s*up)\\b.*\\b(location|there|position|point|marker|destination|this|here|there|nearby|around)\\b"
	
}

DictionaryOfAgentActionDictionary["wait"] = {
	
	regularExpressionTrigger = "(?i)\\b(wait|hold\\s*on|stay|pause|stop|stand\\s*by|delay|freeze|halt|stay\\s*put|wait\\s*here)\\b.*"
	
}

DictionaryOfAgentActionDictionary["gather"] = {
	
	regularExpressionTrigger = "(?i)\\b(gather|collect|pick\\s*up|harvest|loot|scavenge|mine|forage|retrieve)\\b.*\\b(items|resources|materials|loot|supplies|tools|objects|this|here|there|nearby|around)\\b"
	
}

DictionaryOfAgentActionDictionary["communicate"] = {
	
	regularExpressionTrigger = "(?i)\\b(communicate|speak|talk|signal|message|contact|notify|report|shout|call\\s*out|warn)\\b.*\\b(player|you|team|ally|teammate|everyone|this|here|there|nearby)\\b"
	
}

DictionaryOfAgentActionDictionary["explore"] = {
	
	regularExpressionTrigger = "(?i)\\b(explore|search|scout|investigate|look\\s*around|examine|inspect|survey|uncover)\\b.*\\b(area|region|zone|place|location|territory|this|here|there|nearby|around)\\b"
	
}

DictionaryOfAgentActionDictionary["use"] = {
	
	regularExpressionTrigger = "(?i)\\b(use|activate|deploy|operate|employ|trigger|utilize|turn\\s*on|switch\\s*on)\\b.*\\b(tool|ability|skill|item|weapon|gadget|device|this|here|there|nearby)\\b"
	
}

DictionaryOfAgentActionDictionary["build"] = {
	
	regularExpressionTrigger = "(?i)\\b(build|construct|create|assemble|set\\s*up|erect|forge|craft|establish)\\b.*\\b(structure|base|shelter|object|tool|weapon|this|here|there|nearby)\\b"
	
}

DictionaryOfAgentActionDictionary["destroy"] = {
	
	regularExpressionTrigger = "(?i)\\b(destroy|demolish|smash|wreck|obliterate|tear\\s*down|ruin|shatter)\\b.*\\b(target|object|structure|enemy|obstacle|barrier|this|here|there|nearby|around)\\b"
	
}

DictionaryOfAgentActionDictionary["evade"] = {
	
	regularExpressionTrigger = "(?i)\\b(evade|dodge|escape|avoid|retreat|get\\s*out|fall\\s*back|withdraw|run\\s*away|away|move\\s*away)\\b.*\\b(enemy|threat|danger|attack|trouble|this|here|there|nearby|around)\\b"
	
}

DictionaryOfAgentActionDictionary["equip"] = {
	
	regularExpressionTrigger = "(?i)\\b(equip|arm|gear\\s*up|put\\s*on|wear|prepare|ready)\\b.*\\b(weapon|armor|gear|equipment|tool|this|here|there|nearby|around)\\b"
	
}

DictionaryOfAgentActionDictionary["observe"] = {
	
	regularExpressionTrigger = "(?i)\\b(observe|watch|monitor|keep\\s*an\\s*eye\\s*on|track|survey|spy\\s*on)\\b.*\\b(target|enemy|area|situation|object|this|here|there|nearby|around)\\b"
	
}

DictionaryOfAgentActionDictionary["assist"] = {
	
	regularExpressionTrigger = "(?i)\\b(assist|help|support|aid|back\\s*up|lend\\s*a\\s*hand|reinforce)\\b.*\\b(player|you|ally|teammate|friend|this|here|there|nearby)\\b"
	
}

DictionaryOfAgentActionDictionary["prepare"] = {
	
	regularExpressionTrigger = "(?i)\\b(prepare|get\\s*ready|gear\\s*up|ready\\s*up|set\\s*up|brace)\\b.*\\b(for\\s*battle|for\\s*combat|to\\s*attack|to\\s*defend|for\\s*anything|this|here|there|nearby)\\b"
	
}

DictionaryOfAgentActionDictionary["trade"] = {
	
	regularExpressionTrigger = "(?i)\\b(trade|exchange|barter|offer|give|sell|buy)\\b.*\\b(items|goods|resources|materials|supplies|this|here|there|nearby)\\b"
	
}

DictionaryOfAgentActionDictionary["navigate"] = {
	
	regularExpressionTrigger = "(?i)\\b(navigate|find\\s*the\\s*way|map\\s*out|direct|guide|lead)\\b.*\\b(path|route|location|destination|area|this|here|there|nearby|around)\\b"
	
}

return DictionaryOfAgentActionDictionary
