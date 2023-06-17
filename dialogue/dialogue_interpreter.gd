extends Node

class_name DialogueInterpreter

@export var dialogue: DialogueData
   
func run():
  for line in dialogue.parse():
    var type = line["type"]
    if type == "code":
      _code(line)
    elif type == "phrase":
      _phrase(line)
    else:
      printerr("Unknown line type.")
      
func _say(_name: String, text: String):
  pass
            
func Pause(millis: int):
  await get_tree().create_timer(millis / 1000.0).timeout

func _code(line):
  await line["expression"].execute([], self)
  
func _phrase(line):
  await _say(line["name"], line["text"])
