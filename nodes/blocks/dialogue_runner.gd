extends DialogueNodeBase

class_name DialogueRunner

# start every node sequentiallu
func start_dialogue():
	for child in get_children():
		if child is DialogueNodeBase:
			await _run(child)


func _run(block: DialogueNodeBase):
	var target = await block.start_dialogue()
	if target is DialogueNodeBase:
		await _run(target)
