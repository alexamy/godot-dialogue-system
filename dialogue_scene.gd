extends DialogueInterpreter

@export_node_path("Label") var _name
@onready var nameLabel = get_node(_name) as Label

@export_node_path("Label") var _text
@onready var textLabel = get_node(_text) as Label

func _ready():
  run()

func _say(_name: String, text: String):
  nameLabel.text = _name
  textLabel.text = text