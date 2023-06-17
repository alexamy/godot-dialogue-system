extends Node

@export var dialogue: DialogueData

func _ready():
  dialogue.to_ast()
