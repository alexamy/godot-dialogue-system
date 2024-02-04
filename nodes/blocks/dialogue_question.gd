@icon("res://nodes/icons/question.png")

extends DialogueNodeBase

class_name DialogueQuestion

@export_multiline var question = ""
@export var options: Array[DialogueQuestionOption]

func start_dialogue():
	var texts = options.map(func(o): return o.option)
	var idx = await interpreter.ask(question, texts)
	var path = options[idx].path
	var block = get_node(path)
	return block
