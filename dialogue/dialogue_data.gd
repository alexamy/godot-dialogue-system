extends Resource

class_name DialogueData

@export_multiline var dialogue: String

const COMMENT = "//"
const ANCHOR = "#"
const CODE = "$"
const QUESTION = "=?"
const CHOICE = "=<"
const SWITCH = "$?"
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
    elif line.begins_with(COMMENT):
      pass
    elif line.begins_with(QUESTION):
      var info = _question(lines, idx)
      idx += info[0]
      current.push_back(info[1])
    elif line.begins_with(SWITCH):
      var info = _switch(lines, idx)
      idx += info[0]
      current.push_back(info[1])
    elif line.begins_with(CHOICE):
      printerr("Trying to parse question choice without parent line.")
    elif line.begins_with(GOTO):
      var goto = _goto(line)
      current.push_back(goto)
    elif line.begins_with(CODE):
      var code = _code(line)
      current.push_back(code)
    else:
      var info = _phrase(lines, idx)
      idx += info[0]
      current.push_back(info[1])
    idx += 1  
      
  ast[anchor_name] = current
  return ast
  
func _unescape_line(line: String):
  return line.substr(1) if line.begins_with("\\") else line
  
func _is_special_line(line: String):
  return (line.begins_with(ANCHOR)  
    or line.begins_with(COMMENT)
    or line.begins_with(CODE)
    or line.begins_with(CHOICE)
    or line.begins_with(SWITCH)
    or line.begins_with(QUESTION)
    or line.begins_with(GOTO))
  
func _anchor(line: String):
  if anchor_name != "":
    ast[anchor_name] = current
    current = []
  anchor_name = line.substr(1).strip_edges()  

func _code(line: String):
  var code = line.substr(1).strip_edges()
  return { 
    "type": "code",
    "code": code,
  }

func _phrase(lines: Array[String], idx: int): 
  var line = _unescape_line(lines[idx])
  var parts = line.split(":", false, 2)
  var name = parts[0].strip_edges()
  var text = parts[1].strip_edges() if parts.size() == 2 else ""
  var is_multiline = len(text) == 0
  if is_multiline:
    var phrase = _phrase_multiline(lines, idx)
    return [phrase[0], {
      "type": "phrase", 
      "name": name,
      "text": phrase[1],       
    }]
  else:
    return [0, { 
      "type": "phrase", 
      "name": name,
      "text": text, 
    }] 
    
func _phrase_multiline(lines, idx: int):
  var phrases = []
  var offset = 0
  while(idx + offset + 1 < lines.size()):
    var line = lines[idx + offset + 1]
    var is_text = not _is_special_line(line)
    if offset == 0: assert(is_text, "No text found for multiline phrase.")
    if not is_text: break
    line = _unescape_line(line)
    phrases.push_back(line)
    offset += 1
  var text = "\n".join(phrases)
  return [offset, text]         

func _goto(line: String):
  var block = line.substr(2).strip_edges()
  return { 
    "type": "goto",
    "block": block,
  }

func _question(lines: Array[String], idx: int):
  var text = lines[idx].substr(2).strip_edges()
  var choices = _choices(lines, idx)
  return [choices[0], {
    "type": "question",
    "text": text,
    "choices": choices[1],
  }]
  
func _choices(lines, idx: int):
  var choices = []
  var offset = 0
  while(idx + offset + 1 < lines.size()):
    var line = lines[idx + offset + 1]
    var is_choice = line.begins_with(CHOICE)
    if offset == 0: assert(is_choice, "No choices provided.")
    if not is_choice: break
    var data = line.substr(2).split(">")
    choices.push_back({ "block": data[0], "text": data[1].strip_edges() })
    offset += 1
  return [offset, choices] 

func _switch(lines: Array[String], idx: int):
  var text = lines[idx].substr(2).strip_edges()
  var choices = _choices(lines, idx)
  return [choices[0], {
    "type": "switch",
    "text": text,
    "choices": choices[1],
  }]
