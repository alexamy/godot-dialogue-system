extends Node

class_name DialogueNodeBase

@export var interpreter: DialogueInterpreter

func _start_dialogue():
	var interpreter = _find_interpreter()

func _find_interpreter():
	var _interpreter = self.get("interpreter")
	while(!_interpreter):
		var parent = get_parent()
		if(!parent): printerr("No interpreter found.")
		_interpreter = parent.get("interpreter")
	return _interpreter
