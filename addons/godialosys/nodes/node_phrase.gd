@tool

extends DialogueBaseNode

class_name DialoguePhraseNode

var line = preload("res://addons/godialosys/nodes/node_phrase_line.tscn")

func _on_resize_request(new_minsize):
  size.x = new_minsize.x

func _on_add_line_button_pressed():
  %Lines.add_child(line.instantiate())

func as_object():
  var result = []
  for child in %Lines.get_children():
    if child is NodePhraseLine:
      result.push_back(child.as_object())
  return result
