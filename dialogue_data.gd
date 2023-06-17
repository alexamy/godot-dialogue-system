extends Resource

class_name DialogueData

@export_multiline var dialogue: String
var ast = []

func _init(p_dialogue = ""):
  dialogue = p_dialogue

func to_ast():
  for line in dialogue.split("\n", false):
    if line.begins_with("#"):
      ast.push_back(parse_code(line))
    else:
      ast.push_back(parse_phrase(line))      

func parse_code(line: String):
  var code = line.substr(1)
  var expr = Expression.new()
  expr.parse(code)  
  return { 
    "type": "code",
    "expression": expr,
  }

func parse_phrase(line: String): 
  var parts = line.split(":", false, 2)
  return { 
    "type": "phrase", 
    "name": parts[0],
    "text": parts[1].strip_edges(), 
  } 
