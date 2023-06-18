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
      var choice = await _question(line)
      return await _goto(choice)
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
  var choices = line["choices"]
  var choice_texts: Array[String] = []
  choice_texts.assign(choices.map(func(opt): return opt["text"]))
  var idx = await _ask(text, choice_texts)
  assert(idx >= 0 and idx < choices.size(), "Index is out of range: %s." % idx)
  var choice_choosen = choices[idx]
  return choice_choosen

# Will be redefined in child classes
func _ask(_text: String, _choices: Array[String]) -> int:
  @warning_ignore("redundant_await")
  return await -1

func _say(_name: String, _text: String):
  pass
  
# Common helper methods for dialogues
func pause(millis: int):
  await get_tree().create_timer(millis / 1000.0).timeout
