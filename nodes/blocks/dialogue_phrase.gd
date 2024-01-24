extends DialogueNodeBase

class_name DialoguePhrase

@export var person_name = ""
@export_multiline var text = ""

func _start_dialogue():
	var interpreter = _find_interpreter()

