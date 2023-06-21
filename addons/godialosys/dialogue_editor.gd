@tool

extends GraphEdit

func _ready():
  pass

func _on_connection_request(from_node, from_port, to_node, to_port):
  var node = get_node(str(from_node))
  connect_node(from_node, from_port, to_node, to_port)
  if node is DialogueAnchorNode:
    pass

func _on_disconnection_request(from_node, from_port, to_node, to_port):
  disconnect_node(from_node, from_port, to_node, to_port)
