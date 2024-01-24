extends DialogueInterpreterBase

func _say(name: String, text: String):
	printt(name, text)
	await get_tree().create_timer(0.7).timeout
