extends DialogueNodeBase

class_name DialogueGroup

# start every node sequentiallu
func start_dialogue():
	for child in get_children():
		if child is DialogueNodeBase:
			await _exec(child)


func _exec(block: DialogueNodeBase):
	var result = await block.start_dialogue()
	if result is NodePath:
		var branch = get_node(result)
		await _exec(branch)
