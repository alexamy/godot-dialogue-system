extends Node

class_name DialogueInterpreter

@export var dialogue: DialogueData
@onready var blocks = dialogue.parse()
  
func run(block: String):
  for line in blocks[block]:
    var type = line["type"]
    if type == "code":
      await _code(line)
    elif type == "phrase":
      await _phrase(line)
    elif type == "goto":
      return await _goto(line)
    else:
      printerr("Unknown line type: %s." % type)
      
func _code(line):
  await line["expression"].execute([], self)
  
func _phrase(line):
  await _say(line["name"], line["text"])
  
func _goto(line):
  await run(line["block"])

func _say(_name: String, _text: String):
  pass
  
# Common helper methods for dialogues
func pause(millis: int):
  await get_tree().create_timer(millis / 1000.0).timeout
