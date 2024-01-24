extends DialogueNodeBase

class_name DialogueQuestion

@export_multiline var question = ""
@export_multiline var options: Array[String]

func start_dialogue():
	var interpreter = _get_interpreter()
	await interpreter._ask(question, options)
