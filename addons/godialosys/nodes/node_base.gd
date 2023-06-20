@tool

extends GraphNode

class_name DialogueBaseNode

func _ready():
  connect("resize_request", _on_resize_request)

func _on_resize_request(new_minsize):
  size = new_minsize
