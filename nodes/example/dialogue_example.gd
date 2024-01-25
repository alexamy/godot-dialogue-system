extends Node2D

func _ready():
	await $DialogueGroup.start_dialogue()
	print("dialogue completed")
