@tool

extends DialogueBaseNode

class_name DialogueAnchorNode

func _on_resize_request(new_minsize):
  size.x = new_minsize.x

# TODO turn anchor into object key
func as_object():
  return {
    "type": "achor",
    "name": $Name.text,
  }
