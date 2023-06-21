@tool

extends Control

func _ready():
  pass


func _on_graph_edit_connection_request(from_node, from_port, to_node, to_port):
  print(from_node, from_port, to_node, to_port)

func _on_graph_edit_connection_to_empty(from_node, from_port, release_position):
  pass

func _on_graph_edit_popup_request(position):
  pass # Replace with function body.
