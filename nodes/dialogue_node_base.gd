extends Node

class_name DialogueNodeBase

@export var interpreter: DialogueInterpreterBase

# start this block
func start_dialogue():
	pass

# find the nearest dialogue interpreter on self or above the tree
func _get_interpreter() -> DialogueInterpreterBase:
	var _interpreter = self.get("interpreter")
	while(!_interpreter):
		var parent = get_parent()
		if(!parent): printerr("No interpreter found.")
		_interpreter = parent.get("interpreter")
	return _interpreter
