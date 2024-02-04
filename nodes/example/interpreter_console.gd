extends DialogueInterpreterBase

# This is just an example.
# You must redefine _say and _ask methods of base class.

func say(name, text):
	printt(name, text)
	await get_tree().create_timer(0.7).timeout

func ask(question, options):
	printt(question, options)
	await get_tree().create_timer(0.7).timeout
