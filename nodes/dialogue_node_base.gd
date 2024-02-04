extends Node

class_name DialogueNodeBase

@export var _interpreter: DialogueInterpreterBase
var interpreter:
	get: return _get_interpreter()

# start this block
func start_dialogue():
	pass

# find the nearest dialogue interpreter on self or above the tree
func _get_interpreter() -> DialogueInterpreterBase:
	var parent = self
	var result = parent.get("_interpreter")
	while(!result):
		parent = parent.get_parent()
		if not parent:
			printerr("No interpreter found.")
			break
		result = parent.get("_interpreter")
	return result
