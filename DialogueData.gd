extends Resource

class_name DialogueData

@export_multiline var dialogue: String
var ast = []

func _init(p_dialogue = ""):
  dialogue = p_dialogue

func to_ast():
  for line in dialogue.split("\n", false):
    if line.begins_with("#"):
      var code = line.substr(1)
      ast.push_back({ 
        "type": "code", 
        "code": code,
      })
    else: 
      var parts = line.split(":", false, 2)
      ast.push_back({ 
        "type": "phrase", 
        "name": parts[0],
        "text": parts[1].strip_edges(), 
      })      
