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
    elif type == "question":
      var target = await _question(line)
      return await _goto(target)
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
  
func _question(line):
  var text = line["text"]
  var options = line["options"]
  var option_texts: Array[String]
  option_texts.assign(options.map(func(opt): return opt["text"]))
  var idx = await _ask(text, option_texts)
  assert(idx is int, "Index is not a number.")
  assert(idx > 0 and idx < len(options), "Index is out of range: %s." % idx)
  var option_choosen = options[idx]
  return option_choosen
  
func _ask(text: String, options: Array[String]) -> int:
  return -1

func _say(_name: String, _text: String):
  pass
  
# Common helper methods for dialogues
func pause(millis: int):
  await get_tree().create_timer(millis / 1000.0).timeout
