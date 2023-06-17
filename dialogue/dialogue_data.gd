extends Resource

class_name DialogueData

# TODO
# Multiline phrases
# Options choose
# Branching
# If / switch logic
# Variable read?
# Phrase syntax (effects, highlight, font, etc)

@export_multiline var dialogue: String

func _init(p_dialogue = ""):
  dialogue = p_dialogue

func parse():
  var ast = {}
  var current = []
  var anchor_name = ""
  
  var lines = dialogue.split("\n", false)
  assert(lines[0].begins_with("="), "Must start with anchor.")
  for line in lines:
    if line.begins_with("="):
      if anchor_name != "":
        ast[anchor_name] = current
        current = []
      anchor_name = line.substr(1)
    elif line.begins_with("#"):
      current.push_back(_code(line))
    else:
      current.push_back(_phrase(line))      
      
  ast[anchor_name] = current
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
