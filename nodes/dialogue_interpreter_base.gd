@icon("res://nodes/icons/interpreter.png")

extends Node

class_name DialogueInterpreterBase

func _say(name: String, text: String):
	pass

func _ask(question: String, options: Array[String]) -> int:
	return -1
