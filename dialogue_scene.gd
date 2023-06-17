extends DialogueInterpreter

@export_node_path("Label") var _name_label
@onready var name_label = get_node(_name_label) as Label

@export_node_path("Label") var _text_label
@onready var text_label = get_node(_text_label) as Label

func _ready():
  run("start")

func _say(name_t: String, text: String):
  name_label.text = name_t
  text_label.text = text

func _ask(_text: String, _options: Array[String]) -> int:
  return -1
