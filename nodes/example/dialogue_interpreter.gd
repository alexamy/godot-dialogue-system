extends DialogueInterpreterBase

func _say(name, text):
	printt(name, text)
	await get_tree().create_timer(0.7).timeout

func _ask(question, options):
	printt(question, options)
	await get_tree().create_timer(0.7).timeout
