@icon("res://nodes/icons/interpreter.png")

extends Node

class_name DialogueInterpreterBase

func say(name: String, text: String):
	pass

func ask(question: String, options: Array[String]) -> int:
	return -1
