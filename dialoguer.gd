extends Node

@export var dialogue: DialogueData

@export_node_path("Label") var _whom
@onready var whom = get_node(_whom)

@export_node_path("Label") var _text
@onready var text = get_node(_text)

func _ready():
  dialogue.to_ast()
  await get_tree().create_timer(1).timeout
  say()
  
func say():
  print(whom)
