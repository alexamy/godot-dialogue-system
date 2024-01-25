extends DialogueNodeBase

class_name DialogueGroup

# start every node sequentiallu
func start_dialogue():
	for child in get_children():
		if child is DialogueNodeBase:
			await _exec(child)


func _exec(block: DialogueNodeBase):
	var target = await block.start_dialogue()
	if target is DialogueNodeBase:
		await _exec(target)
