extends DialogueNodeBase

class_name DialoguePhrase

@export_multiline var person_name = ""
@export_multiline var text = ""

func start_dialogue():
	var interpreter = _get_interpreter()
	await interpreter._say(person_name, text)

