@tool

extends DialogueBaseNode

class_name DialogueAnchorNode

func _on_resize_request(new_minsize):
  size.x = new_minsize.x

func get_name():
  return $Name.text
