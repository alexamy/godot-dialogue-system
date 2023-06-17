extends Node

@export var dialogue: DialogueData

@export_node_path("Label") var _name
@onready var nameLabel = get_node(_name) as Label

@export_node_path("Label") var _text
@onready var textLabel = get_node(_text) as Label
  
func _ready():
  dialogue.to_ast()
  say()
  
func say():
  for line in dialogue.ast:
    var type = line["type"]
    if type == "code":
      await line["expression"].execute([], self)
    if type == "phrase":
      await Say(line["name"], line["text"])
            
func Pause(millis: int):
  await get_tree().create_timer(millis / 1000.0).timeout

func Say(name: String, text: String):
  nameLabel.text = name
  textLabel.text = text 
