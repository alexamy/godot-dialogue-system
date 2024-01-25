extends Node

class_name DialogueNodeBase

@export var interpreter: DialogueInterpreterBase

# start this block
func start_dialogue():
	pass

# find the nearest dialogue interpreter on self or above the tree
func _get_interpreter() -> DialogueInterpreterBase:
	var parent = self
	var _interpreter = parent.get("interpreter")
	while(!_interpreter):
		parent = parent.get_parent()
		if not parent:
			printerr("No interpreter found.")
			break
		_interpreter = parent.get("interpreter")
	return _interpreter
