extends Resource

class_name DialogueData

@export_multiline var dialogue: String

const ANCHOR = "#"
const CODE = "$"
const QUESTION = "=?"
const CHOICE = "=<"
const GOTO = "=>"

var ast = {}
var current = []
var anchor_name = ""

func _init(p_dialogue = ""):
  dialogue = p_dialogue

func parse():
  var lines = dialogue.split("\n", false)
  assert(lines[0].begins_with(ANCHOR), "Must start with anchor.")
  var idx = 0
  while idx < lines.size():
    var line = lines[idx].strip_edges()
    if line.begins_with(ANCHOR):
      _anchor(line)
    elif line.begins_with(CODE):
      var code = _code(line)
      current.push_back(code)
    elif line.begins_with(QUESTION):
      var info = _question(lines, idx)
      idx += info[0]
      current.push_back(info[1])
    elif line.begins_with(CHOICE):
      printerr("Trying to parse question choice without question text.")
    elif line.begins_with(GOTO):
      var goto = _goto(line)
      current.push_back(goto)
    else:
      var phrase = _phrase(line)
      current.push_back(phrase)    
    idx += 1  
      
  ast[anchor_name] = current
  return ast
  
func _anchor(line: String):
  if anchor_name != "":
    ast[anchor_name] = current
    current = []
  anchor_name = line.substr(1).strip_edges()  

func _code(line: String):
  var code = line.substr(1).strip_edges()
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
    "name": parts[0].strip_edges(),
    "text": parts[1].strip_edges(), 
  } 

func _goto(line: String):
  var block = line.substr(2).strip_edges()
  return { 
    "type": "goto",
    "block": block,
  }

func _question(lines: Array[String], idx: int):
  var text = lines[idx].substr(2).strip_edges()
  var options = []
  var offset = 1
  while(idx + offset < lines.size()):
    var line = lines[idx + offset]
    var is_option = line.begins_with(CHOICE)
    if offset == 1: assert(is_option, "No choices provided for question.")
    if not is_option: offset -= 1; break
    var data = line.substr(2).split(">")
    options.push_back({ "block": data[0], "text": data[1].strip_edges() })
    offset += 1
  return [offset, {
    "type": "question",
    "text": text,
    "options": options,
  }]
