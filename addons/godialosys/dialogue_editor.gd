@tool

extends GraphEdit

func _ready():
  await get_tree().create_timer(4).timeout
  print(as_object())

func _on_connection_request(from_node, from_port, to_node, to_port):
  var node = get_node(str(from_node))
  connect_node(from_node, from_port, to_node, to_port)
  if node is DialogueAnchorNode:
    pass

func _on_disconnection_request(from_node, from_port, to_node, to_port):
  disconnect_node(from_node, from_port, to_node, to_port)

func as_object(): 
  var result = {}
  var connections = get_connection_list()
  for connection in connections:
    var node = get_node(str(connection.from))
    if node is DialogueAnchorNode:
      var anchor_name = node.get_name()
      var path = []
      if connection.to: _traverse(connection.to, connections, path)
      result[anchor_name] = path
  return result

func _traverse(start: StringName, connections: Array, path: Array):
  var node = get_node(str(start))
  var obj = node.as_object()
  path.append_array(obj)
  for connection in connections:
    if connection.from == start and connection.from_port == 0:
      _traverse(connection.to, connections, path)
