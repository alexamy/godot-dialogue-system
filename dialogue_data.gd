extends Resource

class_name DialogueData

@export_multiline var dialogue: String

func _init(p_dialogue = ""):
  dialogue = p_dialogue

func parse():
  var ast = []
  for line in dialogue.split("\n", false):
    if line.begins_with("#"):
      ast.push_back(_code(line))
    else:
      ast.push_back(_phrase(line))      
  return ast

func _code(line: String):
  var code = line.substr(1)
  var expr = Expression.new()
  var err = expr.parse(code)  
  if err != OK: printerr("Cannot parse code.")
  return { 
    "type": "code",
    "expression": expr,
  }

func _phrase(line: String): 
  var parts = line.split(":", false, 2)
  return { 
    "type": "phrase", 
    "name": parts[0],
    "text": parts[1].strip_edges(), 
  } 
