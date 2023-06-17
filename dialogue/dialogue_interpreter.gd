extends Node

class_name DialogueInterpreter

@export var dialogue: DialogueData
   
func run():
  for line in dialogue.parse():
    var type = line["type"]
    if type == "code":
      await line["expression"].execute([], self)
    elif type == "phrase":
      await _say(line["name"], line["text"])
    else:
      printerr("Unknown line type.")
      
func _say(_name: String, text: String):
  pass
            
func Pause(millis: int):
  await get_tree().create_timer(millis / 1000.0).timeout

