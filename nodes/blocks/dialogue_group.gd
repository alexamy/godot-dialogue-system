extends DialogueNodeBase

class_name DialogueGroup

# start every node sequentiallu
func _start_dialogue():
	for child in get_children():
		if(child is DialogueNodeBase):
			await child.start_dialogue()
