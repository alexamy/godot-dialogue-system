extends Node

class_name DialogueInterpreter

@export var dialogue: DialogueData
@onready var blocks = dialogue.parse()

func run_block(block: String):
	for line in blocks[block]:
		if OS.is_debug_build(): print(line)
		var type = line["type"]
		if type == "code":
			await _code(line)
		elif type == "phrase":
			await _phrase(line)
		elif type == "question":
			var choice = await _question(line)
			if choice: return await _goto(choice)
		elif type == "switch":
			var choice = await _switch(line)
			if choice: return await _goto(choice)
		elif type == "goto":
			return await _goto(line)
		else:
			printerr("Unknown line type: %s." % type)

func _code(line):
	await _run_code(line["code"])

func _phrase(line):
	var name_t = _interpolate(line["name"])
	var text = _interpolate(line["text"])
	await _say(name_t, text)

func _goto(line):
	var target = _interpolate(line["block"])
	await run_block(target)

func _question(line):
	var text = _interpolate(line["text"])
	var choices = line["choices"]
	var choice_texts: Array[String] = []
	for choice in choices:
		var ctext = _interpolate(choice["text"])
		var cond = choice["cond"]
		if cond and not _run(cond): continue
		choice_texts.push_back(ctext)
	if choice_texts.size() == 0: return
	var idx = await _ask(text, choice_texts)
	assert(idx >= -1 and idx < choices.size(), "Index is out of range: %s." % idx)
	if idx >= 0: return choices[idx]

func _switch(line):
	var target = await _run(line["text"])
	var choices = line["choices"]
	var options: Array[String] = []
	for choice in choices:
		var ctext = _run(choice["text"])
		var cond = choice["cond"]
		if cond and not _run(cond): continue
		options.push_back(ctext)
	if options.size() == 0: return
	var idx = options.find(target)
	if idx >= 0: return choices[idx]

# Hooks for child classes implementation
func _ask(_text: String, _choices: Array[String]) -> int:
	@warning_ignore("redundant_await")
	return await -2

func _say(_name: String, _text: String):
	pass

# Hooks with default implementation (still may be redefined)
func _run_code(code: String):
	var expr = Expression.new()
	var err = expr.parse(code)
	if err != OK: printerr("Cannot parse code: %s." % code)
	return await expr.execute([], self)

func _interpolate(text: String):
	var result = ""
	var code = ""
	var mode = "text"
	for c in text:
		if c == "{":
			mode = "code"
			continue
		elif c == "}":
			result += str(_run(code))
			mode = "text"
			code = ""
			continue
		if mode == "code":
			code += c
		else:
			result += c
	assert(mode == "text", "Cannot end in code mode when interpolating.")
	return result

# Interpreter helpers
func _run(code: String):
	var expr = Expression.new()
	var err = expr.parse(code)
	if err != OK: printerr("Cannot parse code.")
	return expr.execute([], self)

# Common helper methods for dialogues
func pause(millis: int):
	await get_tree().create_timer(millis / 1000.0).timeout
